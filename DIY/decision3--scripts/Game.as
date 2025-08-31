package
{
   import age.*;
   import age.utils.*;
   import com.*;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.utils.getTimer;
   import game.*;
   import prototypes.*;
   import states.*;
   import triggers.TriggerUseChest;
   
   /**
    * Game 类是游戏的主入口和引擎核心。
    * 它继承自 AgeEngine 框架，作为中央枢纽，负责管理整个游戏的生命周期，
    * 包括：初始化所有管理器、处理游戏状态的切换（例如从主菜单到游戏场景）、
    * 负责调用存盘/读盘逻辑，以及与外部平台SDK（如ArmorGames, Kongregate）进行交互。
    */
   public class Game extends AgeEngine
   {
      // --- 游戏状态实例 ---
      // 每个状态都代表了游戏的一个独立界面或场景。
      public var statePreparePlay:StatePreparePlay;      // 准备游戏状态 (任务开始前的加载、部署界面)
      public var statePlay:StatePlay;                  // 游戏进行中状态 (实际的战斗场景)
      public var stateMainMenu:StateMainMenu;          // 主菜单状态
      public var stateHall:StateHall;                  // 大厅/基地状态 (任务间歇期，用于修整、购买、接取新任务)
      public var stateInventory:StateInventory;        // 物品栏/装备状态
      public var stateAchievements:StateAchievements;  // 成就展示状态
      public var stateCredits:StateCredits;            // 制作人员名单状态
      public var stateLose:StateLose;                  // 游戏失败状态
      public var stateSaveData:StateSaveData;          // 存盘/读盘数据管理状态
      protected var stateVideo:StateVideo;             // 视频播放状态 (用于播放开场、过场动画)
      
      /** @private 用于存储在屏幕渐变（淡入淡出）效果结束后，需要切换到的下一个游戏状态。 */
      protected var pNextStateAfterFade:AgeState;
      
      /** @private 预加载器界面上的“播放/继续”按钮的引用。 */
      protected var mPreloaderBtnPlay:AgeButton = null;
      
      /** @private Spil Games SDK 初始化等待的超时时间（秒）。 */
      protected var mSpilWaitTimout:Number = 7;
      
      /** @private 记录上一次成功保存游戏的时间戳，用于防止过于频繁的存档操作。 */
      protected var mLastSaveTime:int = 0;
      
      /** @private 预加载器界面上，指向赞助商链接的按钮的引用。 */
      protected var mBtnSponsor;
      
      /**
       * 游戏主类的构造函数，是整个游戏的起点。
       * @param param1 Flash Player 的 Stage（舞台）对象。
       */
      public function Game(param1:Stage)
      {
         // 设置安全沙箱，允许游戏与任何域进行数据交换，这对于加载外部资源或与API通信是必要的。
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         
         super(param1);
         
         // 初始化全局变量(GV)和存档系统
         GV.game = this; // 将当前游戏实例赋给全局变量，方便各处调用
         GV.saveGame = new GameSave();
         GV.saveGame.init("Decision3"); // 初始化存档系统，"Decision3" 是存档文件的标识符
         
         // --- 平台相关逻辑 ---
         // 检查游戏是否在 ArmorGames 平台上运行
         if(GV.isArmorGames)
         {
            if(ArmorGames.checkDomain()) // 验证域名是否为官方ArmorGames域名
            {
               Age.log("starting ArmorGames.init");
               GV.showAd = false; // 在官方网站上不显示广告
               ArmorGames.init(Age.stage,"E1BC2E3E-3FC8-4C76-A3FA-5989051C0C62"); // 初始化ArmorGames API
               if(Age.debug)
               {
                  this.showPlayButton();
                  GV.showAd = true;
               }
               else
               {
                  this.onPreloaderBtnClick(); // 如果是正式版，则直接进入游戏初始化流程
               }
            }
            else // 如果域名验证失败
            {
               Age.log("ArmorGames.checkDomain ERROR");
               GV.showAd = true; // 在非官方网站上显示广告
               this.showPlayButton();
            }
         }
         else
         {
            this.showPlayButton(); // 如果不是在特定平台，直接显示播放按钮
         }
         
         // 调试模式下的特殊设置：
         // 为了方便测试，如果在调试模式下运行游戏，
         // 则将机枪、ROKS和加特林机枪这三种武器的最高经验值上限设为一个较低的值 (900)。
         // 这样开发者可以更快地将这些武器升到满级，以测试其满级性能或相关功能。
         if(Age.debug)
         {
            WeaponPlayer.EXP[Weapon.TYPE_MACHINEGUN].max = 900;
            WeaponPlayer.EXP[Weapon.TYPE_ROKS].max = 900;
            WeaponPlayer.EXP[Weapon.TYPE_MINIGUN].max = 900;
         }
      }
      
      // --- 静态链接方法 ---
      // 这些方法用于在游戏内打开外部网页链接。
      public static function linkToFlyAnvil() : void
      {
         AgeLink.openURL("http://flyanvil.com"); // 开发商网站
      }
      
      public static function linkToSponsor() : void
      {
         AgeLink.openURL("http://armor.ag/MoreGames"); // 赞助商网站
      }
      
      public static function linkToWalkthrough() : void
      {
         // 攻略链接，当前为空
      }
      
      public static function linkToSponsorFaceBook() : void
      {
         AgeLink.openURL("http://www.facebook.com/ArmorGames"); // 赞助商Facebook页面
      }
      
      public static function linkToSponsorGame() : void
      {
         AgeLink.openURL("http://armor.ag/MoreGames"); // 赞助商游戏页面
      }
      
      /**
       * 提交玩家的游戏数据到 Kongregate 游戏平台。
       * 这通常用于排行榜和平台成就系统。
       */
      public static function submitKongregate() : void
      {
         if(GV.isKong)
         {
            Kongregate.submit(GV.score,"Score");                 // 提交分数
            Kongregate.submit(GV.money,"Money");                 // 提交金钱
            Kongregate.submit(GV.day,"TotalDays");               // 提交总游戏天数
            if(GV.dayWin)
            {
               Kongregate.submit(GV.dayWin,"WinDays");           // 提交胜利时的天数
            }
            Kongregate.submit(GV.playerKillEnemies,"Kills");     // 提交击杀数
            Kongregate.submit(GV.progress,"Progress");           // 提交游戏进度
            Kongregate.submit(GV.capturedTowers,"Towers");       // 提交占领的塔数
         }
      }
      
      /**
       * 这是一个事件监听函数，用于等待 Spil Games SDK 初始化完成。
       * 在初始化完成或超时后，显示“播放”按钮。
       */
      private function waitForSpil(param1:Event) : void
      {
         this.mSpilWaitTimout -= Age.frameTime;
         if(Spil.isReady || this.mSpilWaitTimout < 0)
         {
            Age.stage.removeEventListener(Event.ENTER_FRAME,this.waitForSpil);
            this.showPlayButton();
            if(Spil.isReady)
            {
               SpilAward.init();
            }
         }
      }
      
      /**
       * 在游戏资源预加载完成后，显示可交互的“播放”按钮。
       */
      protected function showPlayButton() : void
      {
         Preloader.instance.mc.txtLoading.visible = false;
         Preloader.instance.mc.txtValue.visible = false;
         Preloader.instance.mc.btnPlay.visible = true;
         this.mPreloaderBtnPlay = new AgeButton(Preloader.instance.mc.btnPlay,null,this.onPreloaderBtnClick);
         Loc.showText(this.mPreloaderBtnPlay.mc.txtCaption,Loc.BTN_CONTINUE);
         if(Preloader.instance.mc.btnSponsor)
         {
            this.mBtnSponsor = new AgeButton(Preloader.instance.mc.btnSponsor,null,linkToSponsor);
         }
      }
      
      /**
       * 当玩家点击预加载界面的“播放”按钮后，此函数被调用。
       * 它负责执行所有核心系统的初始化操作，是游戏正式开始前的最后准备步骤。
       */
      private function onPreloaderBtnClick() : void
      {
         Preloader.instance.remove();
         if(this.mPreloaderBtnPlay)
         {
            this.mPreloaderBtnPlay.remove();
         }
         
         // 初始化各种管理器和系统
         GoogleAnalitics.init("UA-56777278-1",Preloader.instance); // 初始化谷歌分析
         GoogleAnalitics.trackView("/StartPlay");
         View.createBackBitmap(0);
         GV.layerState = new Sprite(); // 创建用于承载游戏状态内容的图层
         if(Age.debug == false)
         {
            GV.layerState.scrollRect = new Rectangle(0,0,Age.SCREEN_W,Age.SCREEN_H);
         }
         Age.stage.addChild(GV.layerState);
         GV.layerCursor = new Sprite(); // 创建用于承载光标的图层
         Age.stage.addChild(GV.layerCursor);
         
         // 根据是否为调试模式，设置不同的游戏画质和内存管理参数
         if(Age.debug == false)
         {
            Age.setQuality(StageQuality.MEDIUM);
            MemoryController.init(30000,1024 * 1024 * 100,1024 * 1024 * 300,120000);
         }
         else
         {
            AgeDebug.init(G_DebugPanel,GV.layerCursor,Age.SCREEN_W,20,Age.SCREEN_H); // 初始化调试面板
            Debug.initSplashCommands();
            Age.setQuality(StageQuality.MEDIUM);
            MemoryController.init(1000,1024 * 1024 * 60,1024 * 1024 * 100,100000);
         }
         
         Shortcut.initDefaults(); // 初始化快捷键
         AgeLink.init(GV.layerState,G_Link,this.onOpenURLError,this.onShowLinkPopup); // 初始化链接管理器
         SoundManager.init(Age.root); // 初始化声音管理器
         MusicManager.init(Age.root); // 初始化音乐管理器
         GV.cursor = new MouseCursor(GS.CURSOR_ARROW); // 创建鼠标光标
         
         // 从本地存档中恢复玩家的声音和画质设置
         SoundManager.switchSound(true);
         MusicManager.switchMusic(true);
         if(GV.saveGame.localSave.data.musicOn != null)
         {
            MusicManager.switchMusic(GV.saveGame.localSave.data.musicOn);
         }
         if(GV.saveGame.localSave.data.soundOn != null)
         {
            SoundManager.switchSound(GV.saveGame.localSave.data.soundOn);
         }
         if(GV.saveGame.localSave.data.graphic != null)
         {
            Age.setQuality(GV.saveGame.localSave.data.graphic);
         }
         
         this.prepareClasses(); // 预加载一些关键的游戏类
         
         // 初始化 Kongregate SDK
         if(GV.isKong)
         {
            if(Kongregate.checkDomain())
            {
               GV.showAd = false;
               Kongregate.load(Age.stage);
            }
            else
            {
               GV.isKong = false;
               GV.showAd = true;
            }
         }
         
         // 根据运行模式决定游戏的第一个界面（调试模式直接进主菜单，否则播放开场Logo）
         if(Age.debug)
         {
            this.setStateMainMenu();
         }
         else
         {
            this.showAGLogo();
         }
      }
      
      /**
       * 检查游戏是否为独占版本（只允许在特定网站运行）的回调函数。
       */
      protected function GameVarsLoaded(param1:Object = null, param2:Object = null) : void
      {
         if(param2 && param2.Success)
         {
            if(param1 && param1.viral != null)
            {
               GV.isExclusive = !(param1.viral == 1 || param1.viral == true || param1.viral == "1" || param1.viral == "true");
               return;
            }
         }
         UrlTest.run("http://flyanvil.com/isdecision2exclusive",this.exclusiveCheckOK,this.exclusiveCheckFalse);
      }
      
      /**
       * 通过硬编码的加密域名检查，验证游戏是否在授权网站上运行。
       */
      protected function checkForExclusive() : void
      {
         if(Protection.checkDomainHard("BjFCaDFoY20xdmNtZGhiV1Z6TG1OdmJRPT0=","BilCaGxtYkhsaGJuWnBiQzVqYjIwPQ==") == false)
         {
            this.setStateExclusive(); // 如果检查失败，切换到独占内容锁定状态
         }
      }
      
      protected function exclusiveCheckFalse() : void
      {
         GV.isExclusive = false;
      }
      
      protected function exclusiveCheckOK() : void
      {
         GV.isExclusive = true;
      }
      
      /**
       * 预先实例化一些关键的游戏对象类。
       * 这样做可以避免在游戏过程中首次创建这些对象时，因类加载和初始化而可能引起的短暂卡顿。
       */
      protected function prepareClasses() : void
      {
         var _loc1_:Class = Z_Tower1;
         _loc1_ = Z_Tower2;
         _loc1_ = Z_Tower1;
         _loc1_ = Z_Tower2;
         _loc1_ = PrototypeNPC;
      }
      
      protected function onOpenURLError() : void {}
      protected function onShowLinkPopup() : void {}
      
      /**
       * 在切换状态前，重写父类的移除当前状态方法。
       * 除了父类的操作外，还额外清空状态图层的所有子对象并强制进行内存清理。
       */
      override protected function removeCurState() : void
      {
         super.removeCurState();
         AgeU.removeAllChildrens(GV.layerState);
         MemoryController.doForcedClean();
      }
      
      // --- Logo和视频播放 ---
      public function showSpilLogo() : void
      {
         this.setStateVideo(SpilLogo,this.showFlyAnvilLogo,linkToSponsor,GBG_Loader);
      }
      
      public function showFlyAnvilLogo() : void
      {
         MusicManager.stopMusic(false);
         SoundManager.stopAllSounds();
         this.setStateVideo(VideoFA,this.setStateMainMenu);
      }
      
      public function showAGLogo() : void
      {
         this.setStateVideo(VideoAG,this.showFlyAnvilLogo);
      }
      
      /**
       * 在初始化下一个状态时，派发一个全局的“游戏状态改变”事件。
       * 其他游戏模块可以监听此事件，以执行相应的逻辑。
       */
      override protected function initNextState() : void
      {
         super.initNextState();
         Age.dispatchEvent(GameEvent.ON_GAME_STATE_CHANGE);
      }
      
      /**
       * 设置并切换到新的游戏状态。
       * @param param1 要切换到的 AgeState 状态对象。
       */
      override public function setState(param1:AgeState) : void
      {
         if(param1 == null)
         {
            Age.logError("Game:setState null parameter");
         }
         this.pNextStateAfterFade = param1;
         super.setState(param1);
      }
      
      // --- 状态切换的快捷方法 ---
      // 这些函数提供了更简洁的方式来切换到游戏中定义好的各种状态。
      
      /** 切换到主菜单状态 */
      public function setStateMainMenu() : void
      {
         if(Age.debug)
         {
            if(this.stateMainMenu == null)
            {
               this.stateMainMenu = new StateDebugMenu(); // 调试模式下使用特殊的调试菜单
            }
         }
         if(this.stateMainMenu == null)
         {
            this.stateMainMenu = new StateMainMenu();
         }
         this.setState(this.stateMainMenu);
      }
      
      /** 切换到任务准备状态 */
      public function setStatePreparePlay() : void
      {
         if(this.statePreparePlay == null)
         {
            this.statePreparePlay = new StatePreparePlay();
         }
         this.setState(this.statePreparePlay);
      }
      
      /** 切换到故事/剧情叙述状态 */
      public function setStateStory(param1:Class, param2:String, param3:Function, param4:Class = null, param5:Class = null) : void
      {
         this.setState(new StateStory(param1,param2,param3,param4,param5));
      }
      
      /** 切换到实际的游戏战斗状态 */
      public function setStatePlay() : void
      {
         if(Age.isDemo)
         {
            MusicManager.switchMusic(false);
         }
         if(this.statePlay == null)
         {
            this.statePlay = new StatePlay();
         }
         this.setState(this.statePlay);
      }
      
      /** 切换到大厅/基地状态 */
      public function setStateHall() : void
      {
         // 在某些情况下（如游戏第一天、演示版、编辑器模式），返回主菜单而不是进入大厅
         if(GV.day == 0 || Age.isDemo || Age.debug && GV.level && GV.level is LevelEditor)
         {
            GV.level = null;
            this.setStateMainMenu();
            return;
         }
         // 如果需要显示通关视频，则先播放视频，视频结束后再进入大厅
         if(GV.needToShowOutro)
         {
            GV.needToShowOutro = false;
            GV.isCompletedGame = true;
            GV.isVideoOutroShown = true;
            this.setStateVideo(VideoOutro,GV.game.setStateHall,null,null,false);
            GoogleAnalitics.trackView("/CompleteGame");
            return;
         }
         if(this.stateHall == null)
         {
            this.stateHall = new StateHall();
         }
         this.setState(this.stateHall);
      }
      
      /** 切换到物品栏状态 */
      public function setStateInventory() : void
      {
         if(this.stateInventory == null)
         {
            this.stateInventory = new StateInventory();
         }
         this.setState(this.stateInventory);
      }
      
      /** 切换到成就状态 */
      public function setStateAchievements() : void
      {
         if(this.stateAchievements == null)
         {
            this.stateAchievements = new StateAchievements();
         }
         this.setState(this.stateAchievements);
      }
      
      /** 切换到制作人员名单状态 */
      public function setStateCredits() : void
      {
         if(this.stateCredits == null)
         {
            this.stateCredits = new StateCredits();
         }
         this.setState(this.stateCredits);
      }
      
      /** 切换到游戏失败状态 */
      public function setStateLose() : void
      {
         if(Age.isDemo)
         {
            this.setStateMainMenu();
            return;
         }
         if(this.stateLose == null)
         {
            this.stateLose = new StateLose();
         }
         this.setState(this.stateLose);
      }
      
      /** 切换到难度选择状态 */
      public function setStateDifficulty() : void
      {
         this.setState(new StateDifficulty());
      }
      
      /** 切换到存档数据管理状态 */
      public function setStateSaveData() : void
      {
         this.setState(new StateSaveData());
         if(GV.isExclusive && Age.debug == false)
         {
            this.checkForExclusive();
         }
      }
      
      /** 切换到装备状态 */
      public function setStateEquip() : void
      {
         this.setState(new StateEquip());
      }
      
      /** 切换到独占内容锁定状态 */
      public function setStateExclusive() : void
      {
         this.setState(new StateExclusive());
      }
      
      /** 切换到游戏开场文字介绍状态 */
      public function setStateIntroText() : void
      {
         SoundManager.stopAllSounds();
         this.setStateStory(Intro_Screen,Loc.STORY_INTRO,GV.game.setStatePreparePlay);
         SoundManager.createSound(Voice_Intro_9);
         MusicManager.playMusic(Msc_Theme2);
      }
      
      /** 切换到视频播放状态 */
      public function setStateVideo(param1:Class, param2:Function, param3:Function = null, param4:Class = null, param5:Boolean = false) : void
      {
         if(this.stateVideo == null)
         {
            this.stateVideo = new StateVideo();
         }
         this.stateVideo.initVideo(param1,param2,param3,param4,param5);
         this.setState(this.stateVideo);
      }
      
      /** 检查当前是否处于游戏进行中状态 */
      public function isStatePlay() : Boolean
      {
         return Age.state == this.statePlay;
      }
      
      /** 处理舞台尺寸改变事件（当前仅记录日志）*/
      protected function handleStageResize(param1:Event) : void
      {
         Age.log("handleStageResize " + Age.stage.stageWidth + " | " + Capabilities.screenResolutionX);
      }
      
      /**
       * 游戏的主更新循环，每一帧都会被调用。
       * @param param1 事件对象，通常为null。
       */
      override public function update(param1:Event = null) : void
      {
         GV.gameTimer += Age.frameTime; // 更新全局游戏计时器
         super.update(); // 调用父类的更新方法，以驱动当前状态的更新
      }
      
      // --- 游戏流程核心控制 ---
      
      /**
       * 开始一局全新的游戏。
       * 会重置所有游戏数据和玩家进度，然后播放开场动画。
       */
      public function beginNewGame() : void
      {
         this.resetGame(); // 完全重置
         GV.zone = new Zone(-1,PrototypeZone.ZONE_FIRST);
         GV.zoneAction = GC.ACTION_FIRST;
         this.setStateVideo(VideoIntro,this.setStateIntroText,null,null,true);
      }
      
      /**
       * 通关后重新开始游戏（类似于“二周目”）。
       * 会提升游戏难度，并重置世界状态，但通常会保留玩家的部分进度。
       */
      public function startOver() : void
      {
         if(GV.difficulty <= 3)
         {
            GV.difficulty = 4;
         }
         else
         {
            GV.difficulty += 5;
         }
         this.resetGamePart(); // 只重置部分世界数据
         GV.zone = new Zone(-1,PrototypeZone.ZONE_FIRST);
         GV.zoneAction = GC.ACTION_FIRST;
         GV.game.setStatePreparePlay();
      }
      
      /**
       * 在大地图上，检查玩家是否可以开始一个指定的任务。
       * @param param1 区域ID
       * @param param2 任务/动作ID
       * @return 如果可以开始则返回 true，否则返回 false。
       */
      public function canBeginMission(param1:int, param2:int) : Boolean
      {
         if(GV.zones[param1].checkStartAction(param2))
         {
            GV.zoneAction = param2;
            return true;
         }
         GV.zoneAction = -1;
         SoundManager.createSound(Snd_Negative); // 播放一个表示“不行”的音效
         return false;
      }
      
      /**
       * 确认并开始一个任务。
       * @param param1 任务/动作ID。如果为-1，则使用当前已选择的动作。
       */
      public function beginMission(param1:int = -1) : void
      {
         if(param1 != -1)
         {
            GV.zoneAction = param1;
         }
         this.endOfDay(); // 结束当天的地图活动
         this.setStatePreparePlay(); // 进入任务准备界面
      }
      
      /**
       * 从游戏失败界面或暂停菜单中，重新开始当前任务。
       */
      public function restartMission() : void
      {
         this.setStatePreparePlay();
      }
      
      /**
       * 进行一个回合（即“一天”）的结算。这是大地图策略阶段的核心函数。
       * 它会处理所有区域的资源增长、敌人动向、势力范围变化等。
       */
      public function makeTurn() : void
      {
         var _loc1_:Zone = null;
         
         // --- 每日状态初始化 ---
         // 在每天开始时，重置所有与当天计算相关的临时变量，确保一个干净的结算环境。
         GV.isRain = AgeU.rand() < 0.2;          // 设置当天的天气，有20%的几率下雨，可能会影响战斗。
         GV.lostZones = [];                      // 清空“当天丢失区域”列表，用于记录本回合被敌人攻占的区域。
         GV.dayFactoryProfit = 0;                // 当天工厂产出的金钱总和，归零。
         GV.dayFactoryProfitMaterial = 0;        // 当天工厂产出的物资总和，归零。
         GV.dayDangerIncreased = 0;              // 当天危险度的总增长值，归零。
         GV.levelNewEnemyTypes.length = 0;       // 清空“当天出现的新敌人类型”列表。
         GV.flags["civilian"] = null;            // 重置与平民相关的事件标记。
         
         // 1. 所有区域进行“回合开始”结算（如资源产出）
         for each(_loc1_ in GV.zones)
         {
            _loc1_.makeTurnStart();
         }
         
         // 2. 处理敌人的攻击
         this.makeZoneAttack();
         
         // 3. 所有区域进行“回合结束”结算（如状态更新）
         for each(_loc1_ in GV.zones)
         {
            _loc1_.makeTurnEnd();
         }
         
         ++GV.day; // 天数加一
         
         // 4. 根据游戏进度，更新大地图的可见状态
         // 如果大地图状态为0 (初始状态) 并且区域1可以被侦察
         if(GV.mapState == 0 && GV.zones[1].canBeRecon)
         {
            // 则将大地图状态更新为1，可能会解锁新的区域或任务
            GV.mapState = 1;
         }
         // 如果大地图状态为2 并且区域4或区域5可以被侦察
         if(GV.mapState == 2 && (GV.zones[4].canBeRecon || GV.zones[5].canBeRecon))
         {
            // 则将大地图状态更新为3
            GV.mapState = 3;
         }
         
         // 计算当天的总收入，等于工厂产出加上关卡奖励
         var _loc2_:Number = GV.dayFactoryProfit + GV.levelRewardMoney;
         // 如果当天的总收入超过了历史最高日收入
         if(GV.maxDayProfit < _loc2_)
         {
            // 则更新历史最高日收入记录
            GV.maxDayProfit = _loc2_;
         }
         
         // 记录已完成的任务
         if(GV.zone && GV.zoneActions[GV.zone.id])
         {
            GV.zoneActions[GV.zone.id][GV.zoneAction] = true;
         }
         
         // 如果游戏进度达到100%，记录胜利时的天数
         if(GV.progress == 100 && GV.dayWin == 0)
         {
            GV.dayWin = GV.day;
         }
         
         if(Age.debug && GV.zone)
         {
            Age.log("Game.makeTurn: GV.zone.id: " + GV.zone.id + "  GV.zoneAction: " + GV.zoneAction);
         }
         
         // 更新成就进度
         Achieve.TOWER_CAPTURE.update(GV.capturedTowers);
         Achieve.PROGRESS.update(GV.progress);
         
         GV.mapEffectShown = false;
         GV.isNight = !GV.isNight; // 切换昼夜
         GV.mscHall = !!AgeU.randBoolean() ? Msc_Hall : Msc_Theme2; // 随机选择一首大厅音乐
         
         GV.game.saveGame(); // 自动保存游戏
         this.sendStats(); // 发送统计数据到平台
         
         if(Age.debug)
         {
            GV.statBuying.length = 0;
         }
      }
      
      /**
       * 触发所有区域的攻击判定逻辑。
       */
      protected function makeZoneAttack() : void
      {
         var _loc1_:Zone = null;
         GV.isZoneAttacked = false;
         for each(_loc1_ in GV.zones)
         {
            _loc1_.makeAttack();
         }
      }
      
      /**
       * 在进入一个任务之前调用，用于结束“一天”的地图活动。
       * 主要作用是备份当前的金钱、物资等数值，以便任务失败后可以恢复。
       */
      public function endOfDay() : void
      {
         var _loc1_:Zone = null;
         GV.prevMoney = GV.money;
         GV.prevMaterial = GV.material;
         GV.prevTeam = GV.teamSize;
         for each(_loc1_ in GV.zones)
         {
            _loc1_.state = 0;
         }
      }
      
      /**
       * 重置一局游戏的核心世界数据。
       * 此函数用于“新游戏”或“通关后重玩”(startOver)的场景，它会重置所有与世界状态、区域进度和战役相关的变量。
       * 它不会触及玩家的永久性数据（如金钱、技能、物品等，那些由 `resetGame` 函数进一步处理）。
       * 这样做可以将游戏世界恢复到初始状态，以便开始新的征程。
       */
      protected function resetGamePart() : void
      {
         // 重置基本状态
         GV.day = 0; // 将游戏天数归零
         GV.zone = null; // 清除当前所在的区域
         GV.mapState = 0; // 重置大地图状态
         GV.needToShowOutro = false; // 重置是否需要播放通关动画的标记
         GV.isVideoOutroShown = false; // 重置通关动画是否已播放的标记
         GV.isCompletedGame = false; // 重置游戏是否已通关的标记
         GV.isNight = false; // 将时间重置为白天
         GV.flags = {}; // 清空所有游戏事件标记
         GV.flags["tspec"] = {}; // 清空与特殊单位相关的事件标记
         GV.zonesSiege = []; // 清空被围攻的区域列表
         View.resetGame(); // 调用视图管理器的重置方法
         
         // 重新初始化所有游戏区域
         // 创建一个新的数组来存储每个区域已完成的行动
         GV.zoneActions = new Array(GV.zonesQuantity);
         // 创建一个新的向量来存储所有的区域对象
         GV.zones = new Vector.<Zone>(GV.zonesQuantity);
         var _loc1_:int = 0;
         // 遍历所有区域
         while(_loc1_ < GV.zonesQuantity)
         {
            // 为每个区域ID创建一个新的Zone实例
            GV.zones[_loc1_] = new Zone(_loc1_,PrototypeZones.ZONES[_loc1_]);
            // 初始化该区域的行动记录数组
            GV.zoneActions[_loc1_] = [];
            _loc1_++;
         }
         
         // 重置与区域相关的状态
         GV.lostZones = []; // 清空丢失区域的列表
         GV.attackZoneChance = 0; // 重置区域被攻击的几率
         GV.prevMoney = 0; // 清空任务开始前的金钱备份
         GV.prevMaterial = 0; // 清空任务开始前的物资备份
         GV.prevTeam = 0; // 清空任务开始前的队伍规模备份
         
         // 清空在关卡中收集的临时物品/单位
         GV.atms = new Vector.<Object>(); // 清空ATM机（宝箱）的记录
         GV.storehouses = new Vector.<int>(); // 清空仓库的记录
         GV.secrets = new Vector.<Object>(); // 清空秘密地点的记录
         GV.materialStocks = new Vector.<Object>(); // 清空物资储备点的记录
         GV.civilians = new Vector.<int>(); // 清空已营救平民的记录
         GV.recruits = new Vector.<int>(); // 清空已招募新兵的记录
         
         // 重置预备役单位系统
         GV.curReservation = 0; // 将当前预备役类别索引重置为0
         GV.reservationUnits = new Vector.<Vector.<int>>(); // 创建一个新的向量来存储不同类别的预备役单位
         GV.reservationUnits.push(new Vector.<int>()); // 添加建筑工预备役列表
         GV.reservationUnits.push(new Vector.<int>()); // 添加市民预备役列表
         GV.reservationUnits.push(new Vector.<int>()); // 添加士兵预备役列表
         GV.pushSpecToReservation(GC.SPEC_BUILDER,0); // 向预备役中添加一个初始建筑工
         GV.pushSpecToReservation(GC.SPEC_CITIZEN,0); // 向预备役中添加一个初始市民
         GV.pushSpecToReservation(GC.SPEC_SOLDIER,0); // 向预备役中添加一个初始士兵
         
         // 重置其他战役相关数据
         GV.masters = []; // 清空大师/专家的列表
         GV.joinedSpecs = 0; // 重置加入队伍的专家总数
         GV.joinedSpecsCaptains = 0; // 重置加入队伍的队长总数
         GV.uniqueEntities = new Vector.<Number>(); // 清空关卡中唯一实体的记录
      }
      
      /**
       * 完全重置所有游戏数据，用于“开始新游戏”。
       * 这个函数会先调用 `resetGamePart` 来重置世界状态，然后再重置所有与玩家个人相关的、
       * 跨越周目的永久性进度，例如金钱、技能、物品、杀敌数等。
       */
      override public function resetGame() : void
      {
         var _loc1_:* = undefined; // 声明一个通用类型的变量，用于遍历
         var _loc2_:Object = null; // 声明一个对象变量，用于存储关卡原型
         var _loc3_:Object = null; // 声明一个对象变量，用于存储触发器
         if(!Age.debug) // 检查是否不处于调试模式
         {
         }
         GV.saveCount = 0; // 重置存档次数
         GV.mscHall = Msc_Hall; // 设置大厅音乐
         
         this.resetGamePart(); // 首先，重置所有与单次战役相关的世界数据
         
         // 接着，重置玩家的永久性数据
         GV.controls = 1; // 设置默认控制方式
         GV.keyboard = 0; // 设置默认键盘布局
         GV.money = 300; // 设置初始金钱
         GV.material = 20; // 设置初始物资
         GV.score = 0; // 重置分数
         GV.playerHealth = GC.PLAYER_DEF_HEALTH; // 设置玩家初始生命值
         GV.playerHealthMax = GC.PLAYER_DEF_HEALTH; // 设置玩家最大生命值
         GV.playerRegeneration = GC.PLAYER_DEF_REGENERATION; // 设置玩家生命恢复速率
         GV.playerKillEnemies = 0; // 重置玩家击杀敌人数量
         GV.killWithMelee = 0; // 重置近战击杀数量
         GV.bossKillTime = 0; // 重置击杀BOSS用时
         GV.playerKillBosses = 0; // 重置玩家击杀BOSS数量
         GV.gameTimer = 0; // 重置游戏计时器
         GV.headshots = 0; // 重置爆头数
         GV.maxDayProfit = 0; // 重置最高日收入
         GV.playerDeaths = 0; // 重置玩家死亡次数
         GV.lastAttackZoneDay = 1; // 重置上一次区域被攻击的天数
         GV.dayWin = 0; // 重置胜利天数
         
         // 重置所有武器的经验值
         GV.weaponExp = {}; // 创建一个新的空对象来存储武器经验
         for(_loc1_ in WeaponPlayer.EXP) // 遍历所有武器类型
         {
            GV.weaponExp[_loc1_] = 0; // 将每种武器的经验值设为0
         }
         
         // 统计关卡中宝箱的总数
         GV.atmCount = 0; // 初始化宝箱计数器
         _loc2_ = null; // 重置关卡原型变量
         while(_loc2_ = Zone.getNextLevelPrototype(_loc2_)) // 循环获取下一个关卡原型
         {
            _loc2_.levelProto; // 访问关卡原型数据（此行代码似乎没有实际作用）
            for each(_loc3_ in _loc2_.levelProto.triggers) // 遍历关卡中的所有触发器
            {
               if(_loc3_.objClass == TriggerUseChest) // 如果触发器是宝箱类型
               {
                  ++GV.atmCount; // 宝箱计数器加一
               }
            }
         }
         
         // 重置各个游戏子系统
         ArmorAchieve.resetGame(); // 重置ArmorGames成就系统
         PlayerAbility.resetGame(); // 重置玩家能力系统
         PlayerInventory.resetGame(); // 重置玩家物品栏系统
         Quest.resetGame(); // 重置任务系统
         Achieve.resetGame(); // 重置游戏内成就系统
         
         // 重置其他杂项状态
         GV.mapEffectShown = true; // 标记大地图效果已显示
         GV.isTriggerUseNestShown = 1; // 重置“巢穴”触发器提示显示状态
         GV.isTriggerUseChestShown = 1; // 重置“宝箱”触发器提示显示状态
         GV.isCompletedGame = false; // 标记游戏未通关
         GV.specs = []; // 清空专家列表
         GV.tipNum = 0; // 重置提示编号
         GV.survival = 60; // 设置生存模式初始值
         GV.survival2 = 0; // 设置生存模式附加值
         GV.isCompleteButtonEffectShown = 2; // 重置“完成”按钮特效显示状态
         GV.killedEnemies = {}; // 清空已击杀敌人记录
         GV.statBuying = []; // 清空购买统计
         GV.statAllSaves = []; // 清空所有存档相关的统计
      }
      
      /**
       * 将当前的游戏状态序列化并保存到本地。
       * 这是一个核心函数，负责收集所有需要持久化的数据并写入存档。
       */
      override public function saveGame() : void
      {
         var _loc2_:int = 0; // 声明一个整数变量，用作循环计数器
         var _loc3_:Object = null; // 声明一个对象变量，用于临时存储数据
         var _loc4_:* = null; // 声明一个通用类型的变量，用于遍历
         var _loc5_:int = 0; // 声明一个整数变量，用作嵌套循环计数器
         // 为防止过于频繁的保存操作（例如在循环中被调用），增加一个2秒的冷却时间。
         if(getTimer() - this.mLastSaveTime < 2000) // 如果距离上次保存不足2秒
         {
            return; // 则直接返回，不执行保存
         }
         this.mLastSaveTime = getTimer(); // 更新上次保存的时间戳
         
         // 1. 保存与设备相关的本地设置（这些设置不跟游戏进度走）
         GV.saveGame.localSave.data.musicOn = MusicManager.isMusicOn(); // 保存音乐开关状态
         GV.saveGame.localSave.data.soundOn = SoundManager.isSoundOn(); // 保存音效开关状态
         GV.saveGame.localSave.data.graphic = Age.getQuality(); // 保存画质设置
         
         // 如果游戏还没正式开始（day=0），则不保存游戏进度。
         if(GV.day == 0) // 检查当前是否为第0天
         {
            return; // 如果是，则不保存进度
         }
         
         // 2. 开始保存核心游戏进度数据
         var _loc1_:Object = GV.saveGame.data; // 获取存档数据对象的引用
         _loc1_.saveVer = 1; // 设置存档版本号，用于未来处理兼容性
         ++GV.saveCount; // 存档次数加一
         _loc1_.saveCount = GV.saveCount; // 将新的存档次数写入存档数据
         
         // 保存玩家设置和基本进度
         _loc1_.difficulty = GV.difficulty; // 保存游戏难度
         _loc1_.controls = GV.controls; // 保存控制方式
         _loc1_.keyboard = GV.keyboard; // 保存键盘布局
         _loc1_.day = GV.day; // 保存当前天数
         _loc1_.money = AgeU.b64Encode(GV.money); // 使用b64编码对敏感数据（如金钱）做简单处理后保存
         _loc1_.score = AgeU.b64Encode(GV.score); // 编码并保存分数
         _loc1_.material = AgeU.b64Encode(GV.material); // 编码并保存物资
         
         // 保存玩家统计数据
         _loc1_.playerKillEnemies = GV.playerKillEnemies; // 保存玩家击杀敌人总数
         _loc1_.playerKillBosses = GV.playerKillBosses; // 保存玩家击杀BOSS总数
         _loc1_.bossKillTime = GV.bossKillTime; // 保存击杀BOSS的最快时间
         _loc1_.killWithMelee = GV.killWithMelee; // 保存近战击杀数
         _loc1_.gameTimer = int(GV.gameTimer); // 保存总游戏时长（取整）
         _loc1_.headshots = GV.headshots; // 保存爆头数
         _loc1_.maxDayProfit = GV.maxDayProfit; // 保存最高日收入
         _loc1_.playerDeaths = GV.playerDeaths; // 保存玩家死亡次数
         
         // 保存世界和战役状态
         _loc1_.lastAttackZoneDay = GV.lastAttackZoneDay; // 保存上一次区域被攻击的天数
         _loc1_.isCompletedGame = GV.isCompletedGame; // 保存游戏是否通关的状态
         _loc1_.mapState = GV.mapState; // 保存大地图状态
         _loc1_.tipNum = GV.tipNum; // 保存提示编号
         _loc1_.zoneActions = GV.zoneActions; // 保存各区域已完成的行动
         _loc1_.isVideoOutroShown = GV.isVideoOutroShown; // 保存通关动画是否已播放
         _loc1_.dayWin = GV.dayWin; // 保存胜利时的天数
         _loc1_.isNight = GV.isNight; // 保存当前是白天还是黑夜
         _loc1_.attackZoneChance = GV.attackZoneChance; // 保存区域被攻击的几率
         _loc1_.weaponExp = AgeU.createCopy(GV.weaponExp); // 复制并保存武器经验数据
         
         // 清理并保存游戏事件标记(flags)
         if(GV.flags["tspec"] is Array) // 如果特殊单位标记是数组形式（旧格式）
         {
            _loc3_ = {}; // 创建一个新对象
            for(_loc4_ in GV.flags["tspec"]) // 遍历数组
            {
               if(GV.flags["tspec"][_loc4_] != null) // 如果值不为空
               {
                  _loc3_[_loc4_] = int(GV.flags["tspec"][_loc4_]); // 将其转换为整数并存入新对象
               }
            }
            GV.flags["tspec"] = _loc3_; // 用新对象替换旧数组
         }
         _loc1_.flags = AgeU.createCopy(GV.flags); // 复制并保存所有事件标记
         
         // 保存其他杂项数据
         _loc1_.isTriggerUseNestShown = GV.isTriggerUseNestShown; // 保存“巢穴”提示的显示状态
         _loc1_.isTriggerUseChestShown = GV.isTriggerUseChestShown; // 保存“宝箱”提示的显示状态
         _loc1_.atms = AgeU.copyArr(GV.atms,[]); // 复制并保存在关卡中找到的ATM机（宝箱）
         _loc1_.storehouses = AgeU.copyArr(GV.storehouses,[]); // 复制并保存仓库数据
         _loc1_.secrets = AgeU.copyArr(GV.secrets,[]); // 复制并保存秘密地点数据
         _loc1_.civilians = AgeU.copyArr(GV.civilians,[]); // 复制并保存营救的平民
         _loc1_.materialStocks = AgeU.copyArr(GV.materialStocks,[]); // 复制并保存物资储备点
         _loc1_.progress = GV.progress; // 保存游戏总进度
         _loc1_.survival = GV.survival; // 保存生存模式数据
         _loc1_.survival2 = GV.survival2; // 保存生存模式附加数据
         _loc1_.isCompleteButtonEffectShown = GV.isCompleteButtonEffectShown; // 保存“完成”按钮特效的显示状态
         
         // 3. 调用各个子系统的保存方法
         PlayerAbility.saveGame(); // 保存玩家能力数据
         PlayerInventory.saveGame(); // 保存玩家物品栏数据
         Achieve.saveGame(); // 保存成就数据
         Quest.saveGame(); // 保存任务数据
         
         // 4. 序列化所有区域(Zone)对象的数据
         _loc1_.zones = []; // 在存档数据中创建一个空数组用于存放区域数据
         _loc2_ = 0; // 初始化循环计数器
         while(_loc2_ < GV.zones.length) // 遍历所有区域
         {
            _loc1_.zones[_loc2_] = GV.zones[_loc2_].serialize(); // 序列化每个区域对象并存入数组
            _loc2_++; // 计数器加一
         }
         
         // 5. 保存单位和团队相关数据
         _loc1_.masters = AgeU.copyArr(GV.masters,[]); // 复制并保存大师/专家单位
         _loc1_.killedEnemies = AgeU.createCopy(GV.killedEnemies); // 复制并保存已击杀敌人的记录
         _loc1_.recruits = AgeU.vecToArray(GV.recruits); // 将招募单位的向量转换为数组并保存
         _loc1_.reservationUnits = []; // 在存档数据中创建一个空数组用于存放预备役单位
         _loc2_ = 0; // 重置循环计数器
         while(_loc2_ < GV.reservationUnits.length) // 遍历预备役单位的类别
         {
            _loc1_.reservationUnits[_loc2_] = []; // 为每个类别创建一个空数组
            _loc5_ = 0; // 初始化嵌套循环计数器
            while(_loc5_ < GV.reservationUnits[_loc2_].length) // 遍历该类别下的所有单位
            {
               _loc1_.reservationUnits[_loc2_][_loc5_] = GV.reservationUnits[_loc2_][_loc5_]; // 复制单位ID
               _loc5_++; // 嵌套循环计数器加一
            }
            _loc2_++; // 主循环计数器加一
         }
         _loc1_.curReservation = GV.curReservation; // 保存当前选择的预备役类别
         _loc1_.specs = AgeU.copyArr(GV.specs); // 复制并保存玩家队伍中的专家
         _loc1_.joinedSpecs = GV.joinedSpecs; // 保存已加入的专家总数
         _loc1_.joinedSpecsCaptains = GV.joinedSpecsCaptains; // 保存已加入的队长总数
         _loc1_.zonesSiege = AgeU.copyArr(GV.zonesSiege); // 复制并保存被围攻的区域列表
         _loc1_.uniqueEntities = AgeU.vecToArray(GV.uniqueEntities); // 将唯一实体的向量转换为数组并保存
         
         // 6. 执行最终的存档写入操作
         GV.saveGame.save(); // 调用存档对象的save方法，将数据写入本地
         
         if(Age.debug) // 如果是调试模式
         {
            _loc1_.statAllSaves = GV.statAllSaves; // 保存所有存档相关的统计数据
            _loc1_.statBuying = GV.statBuying; // 保存购买相关的统计数据
         }
      }
      
      /**
       * 从本地存档中读取数据并恢复游戏状态。
       * @param param1 可选的存档数据对象。如果为null，则从全局的 `GV.saveGame.data` 加载。
       */
      override public function loadGame(param1:Object = null) : void
      {
         var _loc3_:int = 0; // 声明一个整数变量，用作循环计数器
         var _loc4_:* = undefined; // 声明一个通用类型的变量，用于遍历
         var _loc5_:* = null; // 声明一个通用类型的变量，用于遍历
         var _loc6_:* = null; // 声明一个通用类型的变量，用于遍历
         var _loc7_:int = 0; // 声明一个整数变量，用作嵌套循环计数器
         var _loc2_:Object = param1 != null ? param1 : GV.saveGame.data; // 确定要加载的存档数据源，如果提供了param1则使用它，否则使用全局存档
         
         this.resetGame(); // 在加载前，先将游戏状态完全重置，以避免旧数据残留。
         
         if(_loc2_ == null || _loc2_.saveCount == null) // 检查存档数据是否有效
         {
            return; // 如果存档为空或无效，则中止加载。
         }
         
         // 1. 恢复所有已保存的数据到对应的全局变量(GV)中
         GV.saveCount = _loc2_.saveCount; // 恢复存档次数
         GV.controls = _loc2_.controls; // 恢复控制方式
         if(_loc2_.keyboard) // 如果存档中有键盘布局数据
         {
            GV.keyboard = _loc2_.keyboard; // 恢复键盘布局
         }
         GV.day = _loc2_.day; // 恢复天数
         if(_loc2_.difficulty) // 如果存档中有难度数据
         {
            GV.difficulty = _loc2_.difficulty; // 恢复游戏难度
         }
         if(_loc2_.money is String) // 如果金钱数据是字符串（经过b64编码）
         {
            GV.money = AgeU.b64Decode(_loc2_.money) as int; // 解码并恢复金钱
         }
         if(_loc2_.score is String) // 如果分数数据是字符串
         {
            GV.score = AgeU.b64Decode(_loc2_.score) as int; // 解码并恢复分数
         }
         if(_loc2_.material is String) // 如果物资数据是字符串
         {
            GV.material = AgeU.b64Decode(_loc2_.material) as int; // 解码并恢复物资
         }
         GV.playerKillEnemies = _loc2_.playerKillEnemies; // 恢复玩家击杀敌人总数
         if(_loc2_.playerKillBosses) // 如果存档中有击杀BOSS数据
         {
            GV.playerKillBosses = _loc2_.playerKillBosses; // 恢复玩家击杀BOSS总数
         }
         if(_loc2_.bossKillTime) // 如果存档中有击杀BOSS用时数据
         {
            GV.bossKillTime = _loc2_.bossKillTime; // 恢复击杀BOSS用时
         }
         if(_loc2_.killWithMelee) // 如果存档中有近战击杀数据
         {
            GV.killWithMelee = _loc2_.killWithMelee; // 恢复近战击杀数
         }
         GV.gameTimer = _loc2_.gameTimer; // 恢复游戏总时长
         GV.headshots = _loc2_.headshots; // 恢复爆头数
         GV.maxDayProfit = _loc2_.maxDayProfit; // 恢复最高日收入
         GV.playerDeaths = _loc2_.playerDeaths; // 恢复玩家死亡次数
         GV.lastAttackZoneDay = _loc2_.lastAttackZoneDay; // 恢复上一次区域被攻击的天数
         if(_loc2_.isVideoOutroShown) // 如果存档中有通关动画播放记录
         {
            GV.isVideoOutroShown = _loc2_.isVideoOutroShown; // 恢复该记录
         }
         
         // 加载武器经验，并处理旧版本存档的兼容性问题
         if(_loc2_.weaponExp) // 如果存档中有武器经验数据
         {
            for(_loc4_ in _loc2_.weaponExp) // 遍历存档中的每种武器
            {
               if(_loc2_.weaponExp[_loc4_]) // 如果该武器有经验值
               {
                  GV.weaponExp[_loc4_] = _loc2_.weaponExp[_loc4_]; // 恢复经验值
                  // 如果存档版本过旧（没有saveVer字段或版本号小于1），需要根据新旧经验上限的比例来转换经验值
                  if(!_loc2_.saveVer || _loc2_.saveVer < 1)
                  {
                     if(WeaponPlayer.EXP[_loc4_]) // 检查当前游戏版本中是否存在该武器的经验定义
                     {
                        // 按比例转换经验值：(旧经验 / 旧最大经验) * 新最大经验
                        GV.weaponExp[_loc4_] = GV.weaponExp[_loc4_] / WeaponPlayer.EXP[_loc4_].oldmax * WeaponPlayer.EXP[_loc4_].max;
                        if(GV.weaponExp[_loc4_] > WeaponPlayer.EXP[_loc4_].max) // 如果转换后的经验超过了新的上限
                        {
                           GV.weaponExp[_loc4_] = WeaponPlayer.EXP[_loc4_].max; // 则将其设置为上限值
                        }
                     }
                  }
                  if(GV.weaponExp[_loc4_] > 10000) // 另一个兼容性处理：如果经验值异常地高
                  {
                     GV.weaponExp[_loc4_] /= 100; // 则将其缩小100倍
                  }
               }
            }
         }
         
         GV.mapState = _loc2_.mapState; // 恢复大地图状态
         if(_loc2_.tipNum) // 如果存档中有提示编号
         {
            GV.tipNum = _loc2_.tipNum; // 恢复提示编号
         }
         if(_loc2_.zoneActions) // 如果存档中有区域行动记录
         {
            GV.zoneActions = _loc2_.zoneActions; // 恢复区域行动记录
         }
         if(_loc2_.dayWin) // 如果存档中有胜利天数
         {
            GV.dayWin = _loc2_.dayWin; // 恢复胜利天数
         }
         if(_loc2_.isNight != null) // 如果存档中有昼夜状态
         {
            GV.isNight = _loc2_.isNight; // 恢复昼夜状态
         }
         if(_loc2_.attackZoneChance != null) // 如果存档中有区域被攻击几率
         {
            GV.attackZoneChance = _loc2_.attackZoneChance; // 恢复该几率
         }
         if(_loc2_.flags != null) // 如果存档中有事件标记
         {
            for(_loc5_ in _loc2_.flags) // 遍历所有标记
            {
               if(_loc5_ == "tspec") // 如果是特殊单位标记
               {
                  for(_loc6_ in _loc2_.flags["tspec"]) // 遍历特殊单位标记内部
                  {
                     if(_loc2_.flags["tspec"][_loc6_] != null) // 如果值不为空
                     {
                        GV.flags["tspec"][_loc6_] = int(_loc2_.flags["tspec"][_loc6_]); // 恢复为整数
                     }
                  }
               }
               else // 对于其他标记
               {
                  GV.flags[_loc5_] = AgeU.createCopy(_loc2_.flags[_loc5_]); // 直接复制恢复
               }
            }
         }
         if(_loc2_.isTriggerUseNestShown != null) // 如果存档中有“巢穴”提示显示状态
         {
            GV.isTriggerUseNestShown = _loc2_.isTriggerUseNestShown; // 恢复该状态
         }
         if(_loc2_.isTriggerUseChestShown != null) // 如果存档中有“宝箱”提示显示状态
         {
            GV.isTriggerUseChestShown = _loc2_.isTriggerUseChestShown; // 恢复该状态
         }
         if(_loc2_.atms) // 如果存档中有ATM机（宝箱）数据
         {
            AgeU.copyArr(_loc2_.atms,GV.atms); // 复制恢复
         }
         if(_loc2_.storehouses) // 如果存档中有仓库数据
         {
            AgeU.copyArr(_loc2_.storehouses,GV.storehouses); // 复制恢复
         }
         if(_loc2_.secrets) // 如果存档中有秘密地点数据
         {
            AgeU.copyArr(_loc2_.secrets,GV.secrets); // 复制恢复
         }
         if(_loc2_.civilians) // 如果存档中有平民数据
         {
            AgeU.copyArr(_loc2_.civilians,GV.civilians); // 复制恢复
         }
         if(_loc2_.materialStocks) // 如果存档中有物资储备点数据
         {
            AgeU.copyArr(_loc2_.materialStocks,GV.materialStocks); // 复制恢复
         }
         if(_loc2_.survival) // 如果存档中有生存模式数据
         {
            GV.survival = _loc2_.survival; // 恢复
         }
         if(_loc2_.survival2) // 如果存档中有生存模式附加数据
         {
            GV.survival2 = _loc2_.survival2; // 恢复
         }
         if(_loc2_.isCompleteButtonEffectShown) // 如果存档中有“完成”按钮特效显示状态
         {
            GV.isCompleteButtonEffectShown = _loc2_.isCompleteButtonEffectShown; // 恢复
         }
         if(_loc2_.masters) // 如果存档中有大师/专家单位数据
         {
            GV.masters = _loc2_.masters; // 恢复
         }
         if(_loc2_.isCompletedGame) // 如果存档中有游戏通关状态
         {
            GV.isCompletedGame = _loc2_.isCompletedGame; // 恢复
         }
         if(_loc2_.killedEnemies) // 如果存档中有已击杀敌人记录
         {
            GV.killedEnemies = _loc2_.killedEnemies; // 恢复
         }
         if(_loc2_.zonesSiege) // 如果存档中有被围攻区域列表
         {
            GV.zonesSiege = _loc2_.zonesSiege; // 恢复
         }
         if(_loc2_.joinedSpecs) // 如果存档中有已加入专家总数
         {
            GV.joinedSpecs = _loc2_.joinedSpecs; // 恢复
         }
         if(_loc2_.joinedSpecsCaptains) // 如果存档中有已加入队长总数
         {
            GV.joinedSpecsCaptains = _loc2_.joinedSpecsCaptains; // 恢复
         }
         if(_loc2_.uniqueEntities) // 如果存档中有唯一实体记录
         {
            AgeU.copyArr(_loc2_.uniqueEntities,GV.uniqueEntities); // 复制恢复
         }
         
         // 2. 调用各个子系统的加载方法
         Achieve.loadGame(_loc2_); // 加载成就数据
         PlayerAbility.loadGame(_loc2_); // 加载玩家能力数据
         PlayerInventory.loadGame(_loc2_); // 加载玩家物品栏数据
         Quest.loadGame(_loc2_); // 加载任务数据
         
         // 3. 反序列化所有区域(Zone)的数据
         _loc3_ = 0; // 初始化循环计数器
         while(_loc3_ < GV.zonesQuantity) // 遍历所有区域ID
         {
            if(_loc2_.zones[_loc3_]) // 如果存档中存在该区域的数据
            {
               GV.zones[_loc3_].deserialize(_loc2_.zones[_loc3_]); // 调用区域对象的反序列化方法来恢复状态
            }
            _loc3_++; // 计数器加一
         }
         
         // 4. 恢复单位和团队数据
         if(_loc2_.recruits) // 如果存档中有招募单位数据
         {
            AgeU.copyArr(_loc2_.recruits,GV.recruits); // 复制恢复
         }
         if(_loc2_.specs && _loc2_.specs.length > 0 && _loc2_.specs[0] is int) // 如果存档中有专家数据，并进行简单的格式校验
         {
            GV.specs = _loc2_.specs; // 恢复专家列表
         }
         if(_loc2_.curReservation != null) // 如果存档中有当前预备役类别
         {
            GV.curReservation = _loc2_.curReservation; // 恢复
         }
         if(_loc2_.reservationUnits) // 如果存档中有预备役单位数据
         {
            _loc3_ = 0; // 重置循环计数器
            while(_loc3_ < _loc2_.reservationUnits.length) // 遍历所有预备役类别
            {
               GV.reservationUnits[_loc3_] = new Vector.<int>(); // 为每个类别创建一个新的向量
               _loc7_ = 0; // 初始化嵌套循环计数器
               while(_loc7_ < _loc2_.reservationUnits[_loc3_].length) // 遍历该类别下的所有单位
               {
                  GV.reservationUnits[_loc3_][_loc7_] = _loc2_.reservationUnits[_loc3_][_loc7_]; // 复制单位ID
                  _loc7_++; // 嵌套循环计数器加一
               }
               _loc3_++; // 主循环计数器加一
            }
         }
         
         // 5. 提交加载后的数据到外部平台
         Game.submitKongregate(); // 提交数据到Kongregate平台
         ArmorAchieve.updateAchieves(); // 更新ArmorGames平台的成就状态
         if(!Age.debug) // 如果不是调试模式
         {
         }
      }
      
      /**
       * 发送统计数据（如分数）到外部平台。
       */
      protected function sendStats() : void
      {
         if(Spil.isReady)
         {
            Spil.submitScore(GV.score);
         }
      }
   }
}

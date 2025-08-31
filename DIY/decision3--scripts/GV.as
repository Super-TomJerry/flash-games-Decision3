package
{
   // 导入各个包中必需的类
   import age.Age;
   import age.AgeGraphic;
   import age.AgeParameter;
   import age.AgePrototype;
   import age.AgeU;
   import controller.ControllerReward;
   import controller.ControllerWeaponCursor;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.Achieve;
   import game.Debug;
   import game.GameSave;
   import game.LevelBG;
   import game.MouseCursor;
   import game.PlayerAbility;
   import game.PlayerInventory;
   import game.SoundObject;
   import game.Tavern;
   import game.Weapon;
   import game.Zone;
   import game.gui.GameInterface;
   import levels.Level;
   import mochi.as3.MochiDigits;
   import prototypes.PrototypeZones;
   import states.StateHall;
   import states.StatePlay;
   import units.EntityCursorFakeEnemy;
   import units.Unit;
   import units.UnitPlayer;
   
   // GV 类，很可能代表“全局变量”（Global Variables）。它包含静态属性和方法，用于全局访问。
   public class GV
   {
      
      // 游戏版本号字符串
      public static var version:String = "1.17";
      
      // 检查游戏是否在 Kongregate 平台上运行的标志
      public static var isKong:Boolean = false;
      
      // 检查游戏是否在 Armor Games 平台上运行的标志
      public static var isArmorGames:Boolean = false;
      
      // 决定是否应显示广告的标志
      public static var showAd:Boolean = true;
      
      // 检查游戏是否为特定门户网站的独家版本的标志
      public static var isExclusive:Boolean = false;
      
      // 对主 Game 对象的引用
      public static var game:Game;
      
      // 指示游戏是否以低质量模式运行的标志
      public static var isLowQuality:Boolean;
      
      // 指示游戏当前是否暂停的标志
      public static var isGamePaused:Boolean;
      
      // 对游戏存档对象的引用
      public static var saveGame:GameSave;
      
      // 对主游戏状态的引用
      public static var gameStatePlay:StatePlay;
      
      // 对大厅/中心状态的引用
      public static var gameStateHall:StateHall;
      
      // 对自定义鼠标光标的引用
      public static var cursor:MouseCursor;
      
      // 对武器光标控制器的引用
      public static var weaponCursor:ControllerWeaponCursor;
      
      // 对玩家单位对象的引用
      public static var player:UnitPlayer;
      
      // 悬停时不应触发射击的对象数组
      public static var dontShootOnHover:Array;
      
      // 大厅音乐的类引用
      public static var mscHall:Class;
      
      // 当前游戏难度级别（例如，1 代表普通）
      public static var difficulty:int = 1;
      
      // 对当前关卡对象的引用
      public static var level:Level;
      
      // 对当前区域对象的引用
      public static var zone:Zone;
      
      // 在区域中执行的当前操作（例如，侦察、攻击）
      public static var zoneAction:int;
      
      // 包含游戏中所有区域对象的向量
      public static var zones:Vector.<Zone>;
      
      // 当前游戏状态的主显示层
      public static var layerState:Sprite;
      
      // 所有世界对象（单位、建筑等）的容器
      public static var layerWorld:DisplayObjectContainer;
      
      // 场地对象的容器，可能是世界层的一部分
      public static var layerField:DisplayObjectContainer;
      
      // 背景元素的容器
      public static var layerBG:DisplayObjectContainer;
      
      // 视觉效果（爆炸等）的容器
      public static var layerEffect:DisplayObjectContainer;
      
      // 图形用户界面（GUI）的容器
      public static var layerGUI:DisplayObjectContainer;
      
      // 鼠标光标的容器，确保它在最顶层
      public static var layerCursor:Sprite;
      
      // 对主游戏界面对象的引用
      public static var gameInterface:GameInterface;
      
      // 用于标志或 UI 元素的阴影效果的影片剪辑
      public static var signShadow:MovieClip;
      
      // 对奖励控制器的引用，管理给予玩家的奖励
      public static var controllerReward:ControllerReward;
      
      // 指示屏幕当前是否在震动的标志
      public static var isScreenShaking:Boolean;
      
      // 用于跟踪已丢失区域的数组
      public static var lostZones:Array;
      
      // 工厂一天内产生的利润金额
      public static var dayFactoryProfit:Number;
      
      // 工厂一天内产生的材料利润
      public static var dayFactoryProfitMaterial:Number;
      
      // 一天内危险等级增加的量
      public static var dayDangerIncreased:Number;
      
      // 指示上一个关卡是否有 Boss 的标志
      public static var wasBoss:Boolean;
      
      // 用于存储日志事件的数组
      public static var journalEvents:Array;
      
      // 相对于游戏场地的鼠标 X 位置
      public static var fieldMX:Number = 0;
      
      // 相对于游戏场地的鼠标 Y 位置
      public static var fieldMY:Number = 0;
      
      // 目标鼠标 X 位置，可能用于平滑相机移动
      public static var targetMX:Number = 0;
      
      // 目标鼠标 Y 位置，可能用于平滑相机移动
      public static var targetMY:Number = 0;
      
      // 游戏场地的宽度
      public static var fieldW:Number = 0;
      
      // 游戏场地的高度
      public static var fieldH:Number = 0;
      
      // 定义屏幕边界的矩形
      public static var screenBounds:Rectangle = new Rectangle(0,0,Age.SCREEN_W,Age.SCREEN_H);
      
      // 定义双倍屏幕边界的矩形，可能用于剔除对象
      public static var screenBoundsDouble:Rectangle = new Rectangle(0,0,Age.SCREEN_W * 2,Age.SCREEN_H * 2);
      
      // 屏幕的中心 X 坐标
      public static var screenCX:Number = 0;
      
      // 屏幕的中心 Y 坐标
      public static var screenCY:Number = 0;
      
      // 控制屏幕移动行为的参数
      public static var screenMoveCoef:AgeParameter;
      
      // 屏幕移动速度的系数
      public static var screenSpeedCoef:Number;
      
      // 对关卡背景对象的引用
      public static var levelBG:LevelBG;
      
      // 当前关卡的计时器
      public static var levelTimer:Number = 0;
      
      // 击杀 Boss 所花费的时间
      public static var bossKillTime:Number = 0;
      
      // 关卡中当前的敌人数量
      public static var levelCurEnemyQuantity:int = 0;
      
      // 关卡中当前的 Boss 数量
      public static var levelCurBossQuantity:int = 0;
      
      // 关卡中允许同时存在的最大敌人数量
      public static var levelMaxEnemyQuantity:int = 0;
      
      // 迄今为止在关卡中创建的敌人总数
      public static var levelCreatedEnemyQuantity:int = 0;
      
      // 完成任务需要击杀的 Boss 数量
      public static var levelBossTaskQuantity:int = 0;
      
      // 关卡中可以创建的最大敌人数量
      public static var levelCreatedEnemyMax:int = 0;
      
      // 玩家在当前关卡中击杀的敌人数量
      public static var levelPlayerKillEnemies:int = 0;
      
      // 关卡中（因任何原因）死亡的敌人数量
      public static var levelDeadEnemies:int = 0;
      
      // 从关卡中移除的敌人数量（例如，消失）
      public static var levelRemovedEnemies:int = 0;
      
      // 当前屏幕上的敌人数量
      public static var levelEnemiesOnScreen:int = 0;
      
      // 关卡的当前威胁等级
      public static var levelThreat:int = 0;
      
      // 威胁等级的总和，可能用于计算平均威胁
      public static var levelThreatSum:int = 0;
      
      // 当前处于“狂暴”状态的单位数量
      public static var levelUnitsInRage:int = 0;
      
      // 关卡中的当前行走动作状态
      public static var levelWalkAct:int = 0;
      
      // 关卡中的转生或波数
      public static var levelReincarnations:int = 0;
      
      // 指示进入基地的触发器是否已激活的标志
      public static var levelIsTriggerBaseEnter:Boolean;
      
      // 指示关卡中是否可使用狂暴注射的标志
      public static var levelRageInjAvailable:Boolean;
      
      // 代表第 1 侧敌人的对象
      public static var levelEnemySide1:Object;
      
      // 代表第 2 侧敌人的对象
      public static var levelEnemySide2:Object;
      
      // 关卡中引入的新敌人类型数组
      public static var levelNewEnemyTypes:Array = [];
      
      // 关卡中找到的专家数量
      public static var levelFoundSpec:int;
      
      // 将被送往保留区的专家数量
      public static var levelSpecToReserv:int;
      
      // 将被添加到团队的专家数量
      public static var levelSpecToTeam:int;
      
      // 用于光标目标的假敌人实体
      public static var cursorFakeEntity:EntityCursorFakeEnemy;
      
      // 上一个执行操作的区域
      public static var lastActZone:Zone;
      
      // 上一个执行的操作
      public static var lastAct:int;
      
      // 用于关卡奖励金钱的 MochiDigits 对象（用于高分/排行榜）
      public static var mLevelRewardMoney:MochiDigits = new MochiDigits();
      
      // 用于关卡奖励材料的 MochiDigits 对象
      public static var mLevelRewardMaterials:MochiDigits = new MochiDigits();
      
      // 完成关卡的分数奖励
      public static var levelRewardScore:int = 0;
      
      // 指示狂暴模式是否激活的标志
      public static var isRage:Boolean = false;
      
      // 狂暴乘数
      public static var rageX:int = 1;
      
      // 武器散布（扩散）系数
      public static var dispersionCoef:Number = 1;
      
      // 用于存储武器经验值的对象
      public static var weaponExp:Object;
      
      // 指示玩家是否在巢穴内的标志
      public static var playerInNest:Boolean;
      
      // 指示玩家是否在瞭望塔内的标志
      public static var playerInWatchtower:Boolean;
      
      // 当前在鼠标光标下的单位
      public static var unitUnderCursor:Unit;
      
      // 可招募单位的向量
      public static var recruitUnits:Vector.<Unit>;
      
      // 将被添加到团队的专家数量
      public static var specsToTeam:int;
      
      // 玩家失败时显示的字符串
      public static var loseStr:String;
      
      // 区域被攻击的几率
      public static var attackZoneChance:Number;
      
      // 指示地图效果是否已显示的标志
      public static var mapEffectShown:Boolean;
      
      // 上一个获得经验的武器
      public static var lastExpWeapon:Weapon = null;
      
      // 控制显示次要主菜单的标志
      public static var mainMenuShow2:Boolean = false;
      
      // ATM（自动取款机）的数量
      public static var atmCount:int;
      
      // 指示区域当前是否受到攻击的标志
      public static var isZoneAttacked:Boolean;
      
      // 用于与故事相关的配音的声音对象
      public static var storyVoice:SoundObject;
      
      // 游戏被保存次数的计数器
      public static var saveCount:Number;
      
      // 游戏中的当前天数
      public static var day:int;
      
      // 游戏获胜的日期
      public static var dayWin:int;
      
      // 区域中可用操作的数组
      public static var zoneActions:Array;
      
      // 玩家之前的金钱数量
      public static var prevMoney:int;
      
      // 用于玩家金钱的 MochiDigits 对象
      protected static var mMoney:MochiDigits = new MochiDigits();
      
      // 用于玩家分数的 MochiDigits 对象
      protected static var mScore:MochiDigits = new MochiDigits();
      
      // 玩家之前的团队成员数量
      public static var prevTeam:int;
      
      // 玩家之前的材料数量
      public static var prevMaterial:int;
      
      // 用于玩家材料的 MochiDigits 对象
      protected static var mMaterial:MochiDigits = new MochiDigits();
      
      // 玩家当前生命值
      public static var playerHealth:Number;
      
      // 玩家最大生命值
      public static var playerHealthMax:Number;
      
      // 玩家生命恢复率
      public static var playerRegeneration:Number;
      
      // 控制方案设置
      public static var controls:int;
      
      // 键盘布局设置
      public static var keyboard:int;
      
      // 日志条目数组
      public static var journal:Array;
      
      // 当前显示的提示编号
      public static var tipNum:int;
      
      // 已被黑客攻击的 ATM 对象向量
      public static var atms:Vector.<Object>;
      
      // 仓库位置的向量
      public static var storehouses:Vector.<int>;
      
      // 已发现秘密的向量
      public static var secrets:Vector.<Object>;
      
      // 材料库存位置的向量
      public static var materialStocks:Vector.<Object>;
      
      // 平民位置的向量
      public static var civilians:Vector.<int>;
      
      // 向量的向量，代表不同保留区中的单位
      public static var reservationUnits:Vector.<Vector.<int>>;
      
      // 当前选择的保留区
      public static var curReservation:int;
      
      // 已招募单位的向量
      public static var recruits:Vector.<int>;
      
      // 遇到的唯一实体的向量
      public static var uniqueEntities:Vector.<Number>;
      
      // 用于跟踪每种被击杀敌人数量的对象
      public static var killedEnemies:Object;
      
      // 指示视频结尾是否已显示的标志
      public static var isVideoOutroShown:Boolean;
      
      // 指示是否需要显示结尾的标志
      public static var needToShowOutro:Boolean;
      
      // 指示游戏是否已完成的标志
      public static var isCompletedGame:Boolean;
      
      // 用于存储各种游戏标志的对象
      public static var flags:Object;
      
      // 显示“使用巢穴”触发器的标志/计数器
      public static var isTriggerUseNestShown:int;
      
      // 显示“使用箱子”触发器的标志/计数器
      public static var isTriggerUseChestShown:int;
      
      // 显示“完成按钮”效果的标志/计数器
      public static var isCompleteButtonEffectShown:int;
      
      // 玩家击杀的敌人总数
      public static var playerKillEnemies:int = 0;
      
      // 玩家击杀的 Boss 总数
      public static var playerKillBosses:int = 0;
      
      // 使用近战武器的击杀数
      public static var killWithMelee:int = 0;
      
      // 玩游戏的总时间
      public static var gameTimer:Number = 0;
      
      // 玩家爆头数
      public static var headshots:int = 0;
      
      // 单日赚取的最大利润
      public static var maxDayProfit:int = 0;
      
      // 玩家死亡次数
      public static var playerDeaths:int = 0;
      
      // 生存统计数据 1
      public static var survival:int = 0;
      
      // 生存统计数据 2
      public static var survival2:int = 0;
      
      // 大师（特殊单位或成就）数组
      public static var masters:Array = null;
      
      // 专家数组
      public static var specs:Array = null;
      
      // 已加入团队的专家数量
      public static var joinedSpecs:int = 0;
      
      // 已加入的专家队长数量
      public static var joinedSpecsCaptains:int = 0;
      
      // 上次区域被攻击的日期
      public static var lastAttackZoneDay:int;
      
      // 当前被围困的区域数组
      public static var zonesSiege:Array;
      
      // 用于存储所有存档文件统计数据的数组
      public static var statAllSaves:Array = null;
      
      // 用于存储购买统计数据的数组
      public static var statBuying:Array = null;
      
      // 显示/隐藏单位图形的调试标志
      public static var debugUnitGraphicShow:Boolean = true;
      
      // 地图视图的当前状态
      public static var mapState:int = 0;
      
      // 在编辑器中启用对齐的标志
      public static var editorSnapping:Boolean = false;
      
      // 关卡编辑器的标题
      public static var editorLevelCaption:String = "Editor";
      
      // 一个临时的 Point 对象，以避免频繁创建新对象
      public static var tempPoint:Point = new Point();
      
      // 用于测试点的图形对象
      public static var test_Point:AgeGraphic;
      
      // 测试中烟雾效果的计数器
      public static var testSmokeCount:int = 0;
      
      // 测试中的总奖励
      public static var testTotalReward:Number = 0;
      
      // 测试中游戏统计数据的字符串
      public static var testGameplayStatistic:String = "";
      
      // 用于测试的成就 ID
      public static var testAchieve:int = 0;
      
      // 当前狂暴值
      public static var rage:Number = 0;
      
      // 指示当前是否为夜晚的标志
      public static var isNight:Boolean;
      
      // 指示当前是否在下雨的标志
      public static var isRain:Boolean;
       
      
      // GV 类的构造函数
      public function GV()
      {
         super();
      }
      
      // 获取区域总数的 getter
      public static function get zonesQuantity() : int
      {
         return PrototypeZones.ZONES.length;
      }
      
      // 检查是否所有区域都已完成的 getter
      public static function get isAllZonesDone() : Boolean
      {
         var _loc2_:Zone = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isDone == false)
            {
               _loc1_ = false;
               break;
            }
         }
         return _loc1_;
      }
      
      // 检查是否至少有一个区域已完成的 getter
      public static function get isZoneDone() : Boolean
      {
         var _loc1_:Zone = null;
         for each(_loc1_ in GV.zones)
         {
            if(_loc1_.isDone == true)
            {
               return true;
            }
         }
         return false;
      }
      
      // 检查是否至少有一个区域被防御的 getter
      public static function get isZoneDefended() : Boolean
      {
         var _loc1_:Zone = null;
         for each(_loc1_ in GV.zones)
         {
            if(_loc1_.state & Zone.STATE_DEFENDED)
            {
               return true;
            }
         }
         return false;
      }
      
      // 检查是否至少有一个区域正在被攻击的 getter
      public static function get isZoneAttacket() : Boolean
      {
         var _loc1_:Zone = null;
         for each(_loc1_ in GV.zones)
         {
            if(_loc1_.state & Zone.STATE_ATTACKED)
            {
               return true;
            }
         }
         return false;
      }
      
      // 获取当前关卡名称的 getter
      public static function get levelName() : String
      {
         return GV.zone.caption + "-" + Loc.ZONE_ACTIONS[GV.zoneAction];
      }
      
      // 获取当前关卡原型的 getter
      public static function get levelPrototype() : AgePrototype
      {
         return GV.zone.getLevelPrototype(GV.zoneAction);
      }
      
      // 检查是否是游戏前几天的 getter
      public static function get isFirstDays() : Boolean
      {
         return GV.masters.length == 0 && GV.isCompletedGame == false;
      }
      
      // 获取当前关卡金钱奖励的 getter
      public static function get levelRewardMoney() : int
      {
         return mLevelRewardMoney.value;
      }
      
      // 设置当前关卡金钱奖励的 setter
      public static function set levelRewardMoney(param1:int) : void
      {
         mLevelRewardMoney.setValue(param1);
      }
      
      // 获取当前关卡材料奖励的 getter
      public static function get levelRewardMaterials() : int
      {
         return mLevelRewardMaterials.value;
      }
      
      // 设置当前关卡材料奖励的 setter
      public static function set levelRewardMaterials(param1:int) : void
      {
         mLevelRewardMaterials.setValue(param1);
      }
      
      // 获取玩家当前金钱的 getter
      public static function get money() : int
      {
         return mMoney.value;
      }
      
      // 设置玩家当前金钱的 setter
      public static function set money(param1:int) : void
      {
         return mMoney.setValue(param1);
      }
      
      // 获取玩家当前分数的 getter
      public static function get score() : int
      {
         return mScore.value;
      }
      
      // 设置玩家当前分数的 setter
      public static function set score(param1:int) : void
      {
         return mScore.setValue(param1);
      }
      
      // 获取玩家当前材料的 getter
      public static function get material() : int
      {
         return mMaterial.value;
      }
      
      // 设置玩家当前材料的 setter，有最大值上限
      public static function set material(param1:int) : void
      {
         if(param1 > materialMax)
         {
            param1 = materialMax;
         }
         return mMaterial.setValue(param1);
      }
      
      // 获取玩家可持有的最大材料量的 getter
      public static function get materialMax() : int
      {
         return 30 + storehouses.length * GC.MATERIAL_PER_STORE;
      }
      
      // 用于调试目的设置材料的 setter
      public static function set debugMaterial(param1:int) : void
      {
         return mMaterial.setValue(param1);
      }
      
      // 获取玩家可拥有的最大招募数量的 getter
      public static function get curRecruitsMaxCount() : int
      {
         return PlayerAbility.recruitsCount[PlayerAbility.recruits];
      }
      
      // 获取玩家团队当前规模的 getter
      public static function get teamSize() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavernAvailable && _loc2_.tavern && _loc2_.tavern.isCaptured)
            {
               _loc1_ += _loc2_.tavern.teamSpecs.length;
            }
         }
         return _loc1_;
      }
      
      // 获取被击杀的独特敌人类型数量的 getter
      public static function get killedEnemiesCount() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for(_loc2_ in killedEnemies)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      // 获取达到的最高围攻波次的 getter
      public static function get maxSiegeWave() : int
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = 0;
         for each(_loc2_ in zonesSiege)
         {
            if(_loc2_ > _loc1_)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
      
      // 尝试向团队中添加一名专家，成功时返回 true
      public static function tryToAddToTeam() : Boolean
      {
         if(teamSize + specsToTeam >= teamMaxSize)
         {
            return false;
         }
         ++specsToTeam;
         return true;
      }
      
      // 获取已侦察区域数量的 getter
      public static function get reconedZones() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon == true)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      // 获取玩家团队最大规模的 getter
      public static function get teamMaxSize() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavernAvailable && _loc2_.tavern && _loc2_.tavern.isCaptured)
            {
               _loc1_ += _loc2_.tavern.teamMaxCount;
            }
         }
         return _loc1_;
      }
      
      // 获取所有建筑总维护费用的 getter
      public static function get buildingUpkeep() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon)
            {
               if(_loc2_.tavern && _loc2_.tavern.isCaptured)
               {
                  if(_loc2_.tavern.upkeepMoney > 0)
                  {
                     _loc1_ += _loc2_.tavern.upkeepMoney;
                  }
               }
               if(_loc2_.tower && _loc2_.tower.isCaptured)
               {
                  if(_loc2_.tower.upkeepMoney > 0)
                  {
                     _loc1_ += _loc2_.tower.upkeepMoney;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      // 获取有维护费用的建筑数量的 getter
      public static function get buildingUpkeepCount() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon)
            {
               if(_loc2_.tavern && _loc2_.tavern.isCaptured)
               {
                  if(_loc2_.tavern.upkeepMoney > 0)
                  {
                     _loc1_++;
                  }
               }
               if(_loc2_.tower && _loc2_.tower.isCaptured)
               {
                  if(_loc2_.tower.upkeepMoney > 0)
                  {
                     _loc1_++;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      // 获取有维护费用的专家数量的 getter
      public static function get specUpkeepCount() : int
      {
         return recruits.length;
      }
      
      // 获取所有专家总维护费用的 getter
      public static function get specUpkeep() : int
      {
         return recruitsUpkeep + 0;
      }
      
      // 获取产生金钱的专家数量的 getter
      public static function get specMoneyCount() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavernAvailable && _loc2_.tavern && _loc2_.tavern.isCaptured)
            {
               _loc1_ += _loc2_.tavern.specMoneyCount;
            }
         }
         return _loc1_;
      }
      
      // 获取专家产生的总金钱利润的 getter
      public static function get specMoneyProfit() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavernAvailable && _loc2_.tavern && _loc2_.tavern.isCaptured)
            {
               _loc1_ += _loc2_.tavern.profitMoney;
            }
         }
         return _loc1_;
      }
      
      // 获取产生材料的专家数量的 getter
      public static function get specMaterialCount() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavernAvailable && _loc2_.tavern && _loc2_.tavern.isCaptured)
            {
               _loc1_ += _loc2_.tavern.specMaterialCount;
            }
         }
         return _loc1_;
      }
      
      // 获取专家产生的总材料利润的 getter
      public static function get specMaterialProfit() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavernAvailable && _loc2_.tavern && _loc2_.tavern.isCaptured)
            {
               _loc1_ += _loc2_.tavern.profitMaterial;
            }
         }
         return _loc1_;
      }
      
      // 将一名专家推送到团队或保留区
      public static function pushSpecToTeam(param1:int, param2:int = -1) : Boolean
      {
         if(pushSpecToTavern(param1))
         {
            return true;
         }
         pushSpecToReservation(param1,param2);
         return false;
      }
      
      // 将一名专家从团队移动到保留区
      public static function specFromTeamToReservation(param1:int, param2:int = 0) : void
      {
         if(removeSpecFromTeam(param1))
         {
            pushSpecToReservation(param1,param2);
         }
      }
      
      // 将一名专家推送到特定的保留区
      public static function pushSpecToReservation(param1:int, param2:int = -1) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Zone = null;
         if(param2 == -1)
         {
            _loc3_ = [];
            for each(_loc4_ in GV.zones)
            {
               if(_loc4_.isReserve && _loc4_.isRecon)
               {
                  _loc3_.push(_loc4_.prototype.reserveId);
               }
            }
            param2 = AgeU.randFromArray(_loc3_);
         }
         if(reservationUnits.length > param2 && reservationUnits[param2] != null)
         {
            reservationUnits[param2].push(param1);
         }
      }
      
      // 将一名专家推送到酒馆
      protected static function pushSpecToTavern(param1:int, param2:int = -1) : Boolean
      {
         var _loc3_:Tavern = null;
         if(param2 == -1)
         {
            _loc3_ = findFreeTavern();
         }
         else if(GV.zones[param2].isRecon)
         {
            _loc3_ = GV.zones[param2].tavern;
         }
         else
         {
            _loc3_ = findFreeTavern();
         }
         if(_loc3_ == null || _loc3_.isCaptured == false || _loc3_.isTeamMax)
         {
            return false;
         }
         if(teamSize >= teamMaxSize)
         {
            Age.logError("GV.pushSpecToTavern таверны и команда рассинхронизированы. ");
            return false;
         }
         _loc3_.pushSpecToTavern(param1);
         return true;
      }
      
      // 从保留区移除一名专家
      public static function removeSpecFromReservation(param1:int, param2:int) : Boolean
      {
         if(reservationUnits.length > param2 && reservationUnits[param2] != null)
         {
            AgeU.removeFromVector(reservationUnits[param2],param1);
            return true;
         }
         return false;
      }
      
      // 将一名专家从招募列表移动到酒馆
      public static function specFromRecruitsToTavern(param1:int) : Boolean
      {
         if(recruits.indexOf(param1) != -1)
         {
            if(pushSpecToTavern(param1))
            {
               return AgeU.removeFromVector(recruits,param1);
            }
         }
         return false;
      }
      
      // 将一名专家从招募列表移动到保留区
      public static function specFromRecruitsToReservation(param1:int) : void
      {
         if(recruits.indexOf(param1) != -1)
         {
            pushSpecToReservation(param1);
            AgeU.removeFromVector(recruits,param1);
         }
      }
      
      // 将一名专家从酒馆移动到招募列表
      public static function specFromTavernToRecruits(param1:int) : Boolean
      {
         if(GV.recruits.length < GV.curRecruitsMaxCount)
         {
            GV.removeSpecFromTeam(param1);
            GV.recruits.push(param1);
            return true;
         }
         return false;
      }
      
      // 从团队中移除一名专家
      public static function removeSpecFromTeam(param1:int) : Boolean
      {
         var _loc2_:Tavern = findTavernWithSpec(param1);
         if(_loc2_ == null || _loc2_.isCaptured == false)
         {
            return false;
         }
         return _loc2_.removeSpecFromTavern(param1);
      }
      
      // 查找拥有特定专家的酒馆
      public static function findTavernWithSpec(param1:int) : Tavern
      {
         var _loc2_:Zone = null;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavernAvailable && _loc2_.tavern && _loc2_.tavern.isCaptured && _loc2_.tavern.teamSpecs.indexOf(param1) != -1)
            {
               return _loc2_.tavern;
            }
         }
         return null;
      }
      
      // 查找有空位的酒馆
      public static function findFreeTavern() : Tavern
      {
         var _loc3_:Zone = null;
         var _loc1_:int = 1000;
         var _loc2_:Tavern = null;
         for each(_loc3_ in GV.zones)
         {
            if(_loc3_.isRecon && _loc3_.tavernAvailable && _loc3_.tavern && _loc3_.tavern.isCaptured && _loc3_.tavern.isTeamMax == false && _loc3_.tavern.teamSpecs.length < _loc1_)
            {
               _loc1_ = _loc3_.tavern.teamSpecs.length;
               _loc2_ = _loc3_.tavern;
            }
         }
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_;
      }
      
      // 获取被黑客攻击的 ATM 数量的 getter
      public static function get hackedATMs() : int
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         for each(_loc2_ in atms)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      // 查找特定的 ATM
      public static function findATM(param1:int, param2:int) : Object
      {
         var _loc3_:Object = null;
         for each(_loc3_ in atms)
         {
            if(_loc3_.trId == param1 && _loc3_.x == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      // 获取关卡标题
      public static function getLevelCaption(param1:int, param2:int, param3:AgePrototype = null) : String
      {
         if(param3 == null)
         {
            param3 = GV.zones[param1].getLevelPrototype(param2);
         }
         var _loc4_:* = "LEVEL_0" + param1 + "_" + Loc.DEBUG_ZONE_ACTIONS[param2];
         if(param2 == GC.ACTION_TOWER_UPGRADE || GC.ACTION_FACTORY_UPGRADE)
         {
            if(param3.bg.graphicFrame == 4)
            {
               _loc4_ += "_1";
            }
            if(param3.bg.graphicFrame == 6)
            {
               _loc4_ += "_2";
            }
         }
         return _loc4_;
      }
      
      // 检查是否有新的大师的 getter
      public static function get isNewMaster() : Boolean
      {
         var _loc1_:Object = null;
         for each(_loc1_ in GV.masters)
         {
            if(_loc1_.recent)
            {
               return true;
            }
         }
         return false;
      }
      
      // 检查是否有新的、未显示的大师的 getter
      public static function get isNewUnShownMaster() : Boolean
      {
         var _loc1_:Object = null;
         for each(_loc1_ in GV.masters)
         {
            if(_loc1_.recent && !_loc1_.winShown)
            {
               return true;
            }
         }
         return false;
      }
      
      // 获取最后一个大师图标 ID 的 getter
      public static function get lastMasterIcon() : Number
      {
         if(!GV.masters || GV.masters.length == 0)
         {
            return 1;
         }
         return GV.masters[GV.masters.length - 1].id;
      }
      
      // 获取已占领区域数量的 getter
      public static function get capturedZonesQuantity() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in zones)
         {
            if(_loc2_.isRecon)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      // 获取已占领塔楼数量的 getter
      public static function get capturedTowers() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in zones)
         {
            if(_loc2_.tower && _loc2_.tower.isCaptured)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      // 获取完全升级的塔楼数量的 getter
      public static function get towerFullCount() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in zones)
         {
            if(_loc2_.tower && _loc2_.tower.isFullyUpgraded)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      // 检查是否所有塔楼都已占领并完全升级的 getter
      public static function get allTowersCaptured() : Boolean
      {
         var _loc1_:Zone = null;
         if(Age.debug && Debug.getVar("completeGame",0))
         {
            return true;
         }
         for each(_loc1_ in zones)
         {
            if(_loc1_.towerAvailable && (_loc1_.isRecon == false || _loc1_.tower.isCaptured == false || _loc1_.tower.isFullyUpgraded == false))
            {
               return false;
            }
         }
         return true;
      }
      
      // 获取成就完成进度的 getter
      public static function get achProgress() : int
      {
         var _loc3_:Achieve = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in Achieve.allAchievemets)
         {
            _loc1_++;
            if(_loc3_.isComplete)
            {
               _loc2_++;
            }
         }
         return _loc2_ / _loc1_ * 100;
      }
      
      // 获取物品栏（武器和能力）完成进度的 getter
      public static function get inventoryProgress() : int
      {
         return (PlayerInventory.maxWeaponPercent * 2 + PlayerAbility.availableAbilitiesPercent) / 3;
      }
      
      // 获取游戏总进度的 getter
      public static function get progress() : int
      {
         var _loc3_:Zone = null;
         if(!GV.zones)
         {
            return 0;
         }
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in GV.zones)
         {
            if(!(_loc3_.isOutside || _loc3_.isReserve))
            {
               _loc1_ += _loc3_.progress;
               _loc2_++;
            }
         }
         return _loc1_ / _loc2_;
      }
      
      // 获取已占领酒馆数量的 getter
      public static function get tavernsCount() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavern && _loc2_.tavern.isCaptured)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      // 获取酒馆总数的 getter
      public static function get tavernsTotal() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.tavernAvailable)
            {
               _loc1_++;
            }
         }
         return _loc1_ + 1;
      }
      
      // 获取酒馆占领比例的 getter
      public static function get tavernsNorm() : Number
      {
         return tavernsCount / tavernsTotal;
      }
      
      // 获取酒馆占领百分比的 getter
      public static function get tavernsProcent() : Number
      {
         return tavernsCount / tavernsTotal * 100;
      }
      
      // 获取最大可用专家数量的 getter
      public static function get maxAvailableSpecs() : int
      {
         return tavernsCount * GC.SPEC_PER_TAVERN;
      }
      
      // 获取当前专家数量与最大值的比例的 getter
      public static function get curSpecNorm() : Number
      {
         return GV.teamSize / GV.teamMaxSize;
      }
      
      // 获取招募单位维护费用的 getter
      public static function get recruitsUpkeep() : int
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc1_:int = 0;
         for each(_loc2_ in recruits)
         {
            _loc3_ = AgeU.findElementWith(GC.RECRUITS,"spec",_loc2_);
            if(_loc3_)
            {
               _loc1_ += _loc3_.upkeep;
            }
         }
         return _loc1_;
      }
      
      // 计算在酒馆中的特定专家数量
      public static function specInTaverns(param1:int) : int
      {
         var _loc3_:Zone = null;
         var _loc2_:int = 0;
         for each(_loc3_ in GV.zones)
         {
            if(_loc3_.isRecon && _loc3_.tavern && _loc3_.tavern.isCaptured)
            {
               _loc2_ += _loc3_.tavern.calcSpecInTeam(param1);
            }
         }
         return _loc2_;
      }
      
      // 计算在保留区中的特定专家数量
      public static function specInReservation(param1:int, param2:int = -1) : int
      {
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         var _loc6_:* = undefined;
         var _loc3_:int = 0;
         if(param2 == -1)
         {
            _loc4_ = 0;
            while(_loc4_ < reservationUnits.length)
            {
               _loc3_ += specInReservation(param1,_loc4_);
               _loc4_++;
            }
            return _loc3_;
         }
         if(reservationUnits.length > param2 && reservationUnits[param2] != null)
         {
            _loc5_ = reservationUnits[param2];
            for each(_loc6_ in _loc5_)
            {
               if(_loc6_ == param1)
               {
                  _loc3_++;
               }
            }
         }
         return _loc3_;
      }
      
      // 检查是否拥有工厂的 getter
      public static function get haveFactories() : Boolean
      {
         var _loc1_:Zone = null;
         for each(_loc1_ in GV.zones)
         {
            if(_loc1_.isRecon && _loc1_.factory && _loc1_.factory.isCaptured)
            {
               return true;
            }
         }
         return false;
      }
      
      // 获取产生金钱的工厂数量的 getter
      public static function get factoriesWithMoney() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in zones)
         {
            if(_loc2_.isRecon && _loc2_.factory && _loc2_.factory.profitMoney > 0)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      // 获取产生材料的工厂数量的 getter
      public static function get factoriesWithMaterials() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in zones)
         {
            if(_loc2_.isRecon && _loc2_.factory && _loc2_.factory.profitMaterial > 0)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      // 获取完全升级的工厂数量的 getter
      public static function get factoriesFullCount() : int
      {
         var _loc2_:Zone = null;
         var _loc1_:int = 0;
         for each(_loc2_ in zones)
         {
            if(_loc2_.isRecon && _loc2_.factory && _loc2_.factory.isFullyUpgraded)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      // 获取工厂总金钱利润的 getter
      public static function get factoryProfit() : Number
      {
         var _loc2_:Zone = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.factory)
            {
               _loc1_ += _loc2_.factory.profitMoney;
            }
         }
         return _loc1_;
      }
      
      // 获取工厂总材料利润的 getter
      public static function get factoryMaterialProfit() : Number
      {
         var _loc2_:Zone = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in GV.zones)
         {
            if(_loc2_.isRecon && _loc2_.factory)
            {
               _loc1_ += _loc2_.factory.profitMaterial;
            }
         }
         return _loc1_;
      }
      
      // 获取玩家击杀速度（每分钟击杀数）的 getter
      public static function get killSpeed() : int
      {
         if(levelTimer == 0)
         {
            return 0;
         }
         return levelPlayerKillEnemies / levelTimer * 60;
      }
      
      // 检查高级成就状态的 getter
      public static function get premiumAchieves() : Boolean
      {
         return false;
      }
      
      // 检查玩家是否拥有高级状态的 getter
      public static function get premium() : Boolean
      {
         return GV.flags["premium"] && premiumAchieves;
      }
      
      // 设置玩家高级状态的 setter
      public static function set premium(param1:Boolean) : void
      {
         if(!GV.flags)
         {
            return;
         }
         if(param1 && premiumAchieves)
         {
            GV.flags["premium"] = true;
         }
         else
         {
            GV.flags["premium"] = null;
         }
      }
      
      // 计算所有武器的总经验值比例（待办事项）
      public static function calcAllWeaponExpNorm() : Number
      {
         Age.logError("GV.calcAllWeaponExpNorm TODO!!!");
         return 0;
      }
      
      // 创建并返回一个临时 Point 对象，以提高性能
      public static function newPoint(param1:Number, param2:Number) : Point
      {
         tempPoint.x = param1;
         tempPoint.y = param2;
         return tempPoint;
      }
   }
}

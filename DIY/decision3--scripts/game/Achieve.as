package game // 定义包名为 game
{
   import age.Age; // 导入 Age 类，可能是游戏引擎的核心类
   import age.AgeU; // 导入 AgeU 工具类
   import flash.display.MovieClip; // 导入 MovieClip 类，用于处理动画和显示对象
   import flash.utils.getDefinitionByName; // 导入 getDefinitionByName 函数，用于通过类名的字符串形式获取类的定义
   
   // 定义一个动态类 Achieve，用于管理和处理游戏中的所有成就
   public dynamic class Achieve
   {
      
      // --- 静态变量，用于存储和引用不同类型的成就实例 ---
      public static var FIRST:Achieve; // 第一个成就
      
      public static var KILLS:Achieve; // 击杀数成就
      
      public static var KILL_TROLLS:Achieve; // 击杀巨魔成就
      
      public static var TOWER_CAPTURE:Achieve; // 占领塔楼成就
      
      public static var KILLSPEED:Achieve; // 快速击杀成就
      
      public static var STASHES:Achieve; // 发现储藏品成就
      
      public static var START_ALL:Achieve; // 全面发展成就（例如所有技能和武器）
      
      public static var ATHLETE:Achieve; // 运动员成就（例如敏捷和耐力）
      
      public static var KILL_BOSS:Achieve; // 击杀Boss成就
      
      public static var SPECS:Achieve; // 可能是指特殊行动或规格成就
      
      public static var TOWER_UPGRADES:Achieve; // 塔楼升级成就
      
      public static var PROGRESS:Achieve; // 游戏总进度成就
      
      public static var allAchievemets:Array; // 存储游戏中所有成就实例的数组
      
      public static var newAchievemets:Array; // 存储本轮游戏中新达成的成就的数组
      
      public static var COUNT:uint; // 成就的总数量
       
      
      // --- 实例变量，定义每个成就对象的属性 ---
      public var type:int; // 成就的唯一标识ID
      
      public var typeObject:Object; // 存储成就配置信息的对象（如奖励、目标、文本等）
      
      public var value:Number = 0; // 成就当前的进度值
      
      public var bestValue:Number = 0; // 该成就的历史最佳进度值
      
      public var prevBestValue:Number = 0; // 上一次的最佳进度值
      
      public var isComplete:Boolean = false; // 标记该成就是否已经完成
      
      public var isRewarded:Boolean = false; // 标记该成就的奖励是否已经发放
      
      public var isUnlimitValue:Boolean = true; // 标记进度值是否可以超过目标值（true表示不能超过）
      
      public var isCountable:Boolean = false; // 标记该成就是否可以重复完成和计数
      
      public var count:int = 0; // 该成就已经完成的次数
      
      public var aimStr:Function; // 一个函数，用于获取目标值的字符串表示形式
      
      public var valueStr:Function; // 一个函数，用于获取当前进度值的字符串表示形式
      
      public var bestValueStr:Function; // 一个函数，用于获取最佳进度值的字符串表示形式
      
      public var prevBestValueStr:Function; // 一个函数，用于获取上一次最佳进度值的字符串表示形式
      
      // 构造函数
      public function Achieve()
      {
         this.typeObject = {}; // 初始化配置对象
         this.aimStr = this.getAimStr; // 设置默认的获取目标字符串的函数
         this.valueStr = this.getValueStr; // 设置默认的获取当前值字符串的函数
         this.bestValueStr = this.getBestValueStr; // 设置默认的获取最佳值字符串的函数
         this.prevBestValueStr = this.getPrevBestValueStr; // 设置默认的获取上一次最佳值字符串的函数
         super(); // 调用父类的构造函数
      }
      
      // 静态方法：重置所有成就数据，通常在开始新游戏时调用
      public static function resetGame() : void
      {
         allAchievemets = []; // 清空所有成就列表
         newAchievemets = []; // 清空新达成成就列表
         var _loc1_:Object = {}; // 临时的局部变量，此处未使用
         // --- 创建并初始化所有具体的成就 ---
         FIRST = create({
            "reward":100, // 奖励值
            "str":Loc.ACH_FIRST, // 相关的文本（标题、描述等）
            "iconFrame":1 // 图标在素材中的帧数
         });
         KILL_TROLLS = create({
            "reward":3000,
            "aim":20, // 目标值
            "count":true, // 可重复计数
            "str":Loc.ACH_KILL_TROLLS,
            "iconFrame":2
         });
         KILLS = create({
            "reward":1000,
            "aim":1000,
            "count":true,
            "str":Loc.ACH_KILLS,
            "iconFrame":3
         });
         TOWER_CAPTURE = create({
            "reward":5000,
            "aim":7,
            "str":Loc.ACH_TOWER_CAPTURE,
            "iconFrame":4
         });
         START_ALL = create({
            "reward":4000,
            "aim":100,
            "str":Loc.ACH_START_ALL,
            "iconFrame":5
         });
         ATHLETE = create({
            "showOnWin":false, // 配置为在胜利界面不显示
            "reward":1000,
            "str":Loc.ACH_ATHLETE,
            "iconFrame":6
         });
         KILL_BOSS = create({
            "reward":5000,
            "str":Loc.ACH_KILL_BOSS,
            "iconFrame":7
         });
         SPECS = create({
            "reward":2000,
            "aim":100,
            "str":Loc.ACH_SPECS,
            "iconFrame":8
         });
         TOWER_UPGRADES = create({
            "reward":4000,
            "aim":16,
            "str":Loc.ACH_TOWER_UPGRADES,
            "iconFrame":9
         });
         STASHES = create({
            "reward":4000,
            "aim":50,
            "str":Loc.ACH_STASHES,
            "iconFrame":10
         });
         PROGRESS = create({
            "reward":10000,
            "aim":100,
            "str":Loc.ACH_PROGRESS,
            "iconFrame":11
         });
         KILLSPEED = create({
            "reward":1000,
            "aim":40,
            "unlimitValue":false, // 进度值可以超过目标值（对于越小越好的成就）
            "str":Loc.ACH_KILLSPEED,
            "iconFrame":12
         });
         COUNT = allAchievemets.length; // 更新成就总数
      }
      
      // 静态方法：更新需要实时检查的成就进度
      public static function updateAchieves() : void
      {
         TOWER_UPGRADES_update(); // 更新塔楼升级成就
         ATHLETE_update(); // 更新运动员成就
         START_ALL_update(); // 更新全面发展成就
         TOWER_CAPTURE.update(GV.capturedTowers); // 更新占领塔楼成就
      }
      
      // 静态方法：保存所有成就数据到存档
      public static function saveGame() : void
      {
         var _loc2_:Achieve = null; // 用于遍历的成就变量
         var _loc3_:Object = null; // 用于存储单个成就数据的对象
         var _loc1_:Array = []; // 用于存储所有成就数据的数组
         for each(_loc2_ in allAchievemets) // 遍历所有成就
         {
            // 将成就的关键数据存入一个临时对象
            _loc3_ = {
               "type":_loc2_.type,
               "value":_loc2_.value,
               "count":_loc2_.count,
               "bestValue":_loc2_.bestValue,
               "isComplete":_loc2_.isComplete,
               "isRewarded":_loc2_.isRewarded,
               "prevBestValue":_loc2_.prevBestValue
            };
            _loc1_[_loc2_.type] = _loc3_; // 以成就的type ID为索引存入数组
         }
         GV.saveGame.data.achievements = _loc1_; // 将成就数据数组存入全局存档对象
      }
      
      // 静态方法：从存档中加载成就数据
      public static function loadGame(param1:Object) : void
      {
         var _loc3_:Object = null; // 用于遍历存档中成就数据的对象
         var _loc4_:Achieve = null; // 对应的游戏内成就实例
         var _loc5_:* = null; // 用于遍历属性名的变量
         var _loc2_:Array = param1.achievements as Array; // 从存档对象中获取成就数据数组
         if(_loc2_ != null) // 如果存档中存在成就数据
         {
            for each(_loc3_ in _loc2_) // 遍历存档中的每个成就数据
            {
               if((_loc4_ = allAchievemets[_loc3_.type]) != null) // 根据type ID找到对应的成就实例
               {
                  for(_loc5_ in _loc3_) // 遍历该成就的所有已保存属性
                  {
                     _loc4_[_loc5_] = _loc3_[_loc5_]; // 将存档中的值赋给成就实例的对应属性
                  }
               }
            }
         }
      }
      
      // 静态方法：创建一个新的成就实例
      public static function create(param1:Object) : Achieve
      {
         var _loc2_:int = allAchievemets.length; // 使用当前数组长度作为新成就的type ID
         if(param1.objClass == null) // 如果配置中没有指定类
         {
            param1.objClass = Achieve; // 使用默认的Achieve类
         }
         var _loc3_:Achieve = new param1.objClass(); // 实例化成就对象
         _loc3_.init(_loc2_,param1); // 调用init方法进行初始化
         allAchievemets[_loc2_] = _loc3_; // 将新成就添加到所有成就数组中
         return _loc3_; // 返回创建的实例
      }
      
      // 静态方法：完成所有成就（主要用于调试）
      public static function completeAll() : void
      {
         var _loc1_:Achieve = null;
         for each(_loc1_ in allAchievemets)
         {
            _loc1_.complete(); // 调用每个成就的complete方法
         }
      }
      
      // 静态方法：将所有成就设置为未完成状态（主要用于调试）
      public static function inCompleteAll() : void
      {
         var _loc1_:Achieve = null;
         for each(_loc1_ in allAchievemets)
         {
            _loc1_.setIncomplete(); // 调用每个成就的setIncomplete方法
         }
      }
      
      // 静态方法：获取已完成成就的总数
      public static function getCompletedCount() : int
      {
         var _loc2_:Achieve = null;
         var _loc1_:int = 0; // 计数器
         var _loc3_:int = 0;
         while(_loc3_ < COUNT) // 遍历所有成就
         {
            _loc2_ = allAchievemets[_loc3_];
            if(_loc2_.isComplete) // 如果成就已完成
            {
               _loc1_++; // 计数器加1
            }
            _loc3_++;
         }
         return _loc1_; // 返回总数
      }
      
      // 静态方法：填充UI上的任务列表（与特定的UI MovieClip 绑定）
      public static function fillTasks(param1:int, param2:MovieClip) : void
      {
         var _loc3_:int = 0;
         var _loc5_:MovieClip = null;
         _loc3_ = 1;
         while(_loc3_ <= 5) // 先隐藏所有任务单元格
         {
            param2["cell" + _loc3_].visible = false;
            _loc3_++;
         }
         var _loc4_:Array;
         if((_loc4_ = allAchievemets[param1].tasks) == null) // 获取指定成就的任务列表
         {
            return; // 如果没有任务，则直接返回
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length) // 遍历任务列表
         {
            (_loc5_ = param2["cell" + (_loc3_ + 1)]).visible = true; // 显示对应的单元格
            _loc5_.gotoAndStop(_loc4_[_loc3_][0] == true ? 2 : 1); // 根据任务完成状态（数组第一个元素）设置显示帧
            Loc.showText(_loc5_.caption,_loc4_[_loc3_][1]); // 显示任务描述（数组第二个元素）
            _loc3_++;
         }
      }
      
      // 静态方法：更新“塔楼升级”成就的进度
      public static function TOWER_UPGRADES_update(param1:Boolean = true) : void
      {
         var _loc2_:int = 0; // 用于记录找到的最高塔楼等级
         var _loc3_:Zone = null;
         if(TOWER_UPGRADES && TOWER_UPGRADES.isComplete == false) // 如果该成就存在且未完成
         {
            _loc2_ = 0;
            for each(_loc3_ in GV.zones) // 遍历所有区域
            {
               // 如果区域已侦察，有塔楼且塔楼对象存在
               if(_loc3_.isRecon && _loc3_.towerAvailable && _loc3_.tower)
               {
                  if(_loc2_ < _loc3_.tower.upgCount) // 找到最高的升级次数
                  {
                     _loc2_ = _loc3_.tower.upgCount;
                  }
               }
            }
            TOWER_UPGRADES.update(_loc2_); // 用找到的最高等级更新成就进度
         }
      }
      
      // 静态方法：更新“运动员”成就
      public static function ATHLETE_update(param1:Boolean = true) : void
      {
         if(ATHLETE && ATHLETE.isComplete == false) // 如果该成就存在且未完成
         {
            // 检查敏捷和耐力技能等级是否都达到3级
            if(PlayerAbility.getAbilityLevel(PlayerAbility.numAgility) == 3 && PlayerAbility.getAbilityLevel(PlayerAbility.numStamina) == 3)
            {
               ATHLETE.complete(param1); // 如果都达到，则完成成就
            }
         }
      }
      
      // 静态方法：更新“全面发展”成就
      public static function START_ALL_update() : void
      {
         if(START_ALL && START_ALL.isComplete == false) // 如果该成就存在且未完成
         {
            // 根据已拥有的能力和武器的平均百分比来更新进度
            START_ALL.update((int(PlayerAbility.abilitiesHaveCount / (PlayerAbility.abilities.length - 1) * 100) + PlayerInventory.weaponsHavePercent) / 2);
         }
      }
      
      // 静态方法：打印所有成就的标题和描述（用于调试）
      public static function testPrintAllAchieves() : *
      {
         var _loc1_:Achieve = null;
         for each(_loc1_ in allAchievemets)
         {
            Age.log(_loc1_.caption + " - " + _loc1_.description); // 使用引擎的日志功能打印信息
         }
      }
      
      // 静态方法：一个特殊的回调函数，用于获取武器经验值相关的字符串
      public static function WPN_EXP_valueStr(param1:Achieve) : String
      {
         if(GV.lastExpWeapon != null) // 如果全局变量中记录了最近获得经验的武器
         {
            return GV.lastExpWeapon.caption; // 返回该武器的名称
         }
         return ""; // 否则返回空字符串
      }
      
      // 实例方法：获取目标值的字符串表示
      public function getAimStr(param1:Achieve) : String
      {
         return int(param1.aim).toString();
      }
      
      // 实例方法：获取当前进度值的字符串表示（保留两位小数）
      public function getValueStr(param1:Achieve) : String
      {
         return (int(param1.value * 100) / 100).toString();
      }
      
      // 实例方法：获取最佳进度值的字符串表示
      public function getBestValueStr(param1:Achieve) : String
      {
         return param1.bestValue.toString();
      }
      
      // 实例方法：获取上一次最佳进度值的字符串表示
      public function getPrevBestValueStr(param1:Achieve) : String
      {
         return param1.prevBestValue.toString();
      }
      
      // 实例方法：初始化成就
      public function init(param1:int, param2:Object) : void
      {
         this.type = param1; // 设置type ID
         this.typeObject = AgeU.parseOptions(param2,this.typeObject); // 解析并合并配置对象
         if("value" in this.typeObject) // 如果配置中定义了初始值
         {
            this.value = this.typeObject.value;
         }
         else
         {
            this.value = 0; // 否则默认为0
         }
         this.isComplete = false; // 初始为未完成
         this.count = 0; // 初始完成次数为0
         if(this.typeObject.unlimitValue != null) // 如果配置了 isUnlimitValue
         {
            this.isUnlimitValue = this.typeObject.unlimitValue;
         }
         if(this.typeObject.aimStr != null) // 如果配置了自定义的 aimStr 函数
         {
            this.aimStr = this.typeObject.aimStr;
         }
         if(this.typeObject.valueStr != null) // 如果配置了自定义的 valueStr 函数
         {
            this.valueStr = this.typeObject.valueStr;
         }
         if(this.typeObject.bestValueStr != null) // 如果配置了自定义的 bestValueStr 函数
         {
            this.bestValueStr = this.typeObject.bestValueStr;
         }
         if(this.typeObject.count) // 如果配置为可计数
         {
            this.isCountable = true;
         }
      }
      
      // 实例方法：检查前置成就要求是否满足
      public function checkRequire() : Boolean
      {
         if(this.typeObject.require == null) // 如果没有前置要求
         {
            return true; // 直接返回true
         }
         return this.typeObject.require.isComplete; // 返回前置成就是否已完成
      }
      
      // 实例方法：检查一个后置条件，通常用于决定是否显示某些特效
      public function checkAfter() : Boolean
      {
         if(this.typeObject.after == null) // 如果没有后置条件
         {
            return true; // 直接返回true
         }
         return this.typeObject.after.isComplete; // 返回后置条件对应的成就是否已完成
      }
      
      // 实例方法：增加成就进度
      public function increase(param1:Number = 1, param2:Boolean = false) : Boolean
      {
         // 必须满足前置条件，并且（成就未完成 或 强制增加 或 可重复计数）
         if(this.checkRequire() == true && (this.isComplete == false || param2 || this.isCountable))
         {
            this.value += param1; // 增加进度值
            this.updateBestValue(); // 更新最佳值
            Age.dispatchEvent(GameEvent.ON_ACHIEVEMENT_UPDATE,{"achive":this}); // 派发成就更新事件
            if(this.aim <= this.value) // 如果达到或超过目标
            {
               this.value = this.aim; // 将当前值设为目标值
               this.complete(); // 完成成就
            }
            else if(this.updateEffect) // 如果未完成但需要显示特效
            {
               View.showEffectAchieveAdd(); // 显示进度增加特效
            }
            return true; // 表示进度已增加
         }
         return false; // 表示进度未增加
      }
      
      // 实例方法：将成就进度更新为一个特定的值
      public function update(param1:Number, param2:Boolean = true) : Boolean
      {
         var _loc3_:Number = NaN; // 用于存储更新前的旧值
         var _loc4_:Boolean = false; // 标记是否需要显示特效
         if(this.checkRequire() == true) // 检查前置条件
         {
            if(this.value != param1) // 只有当值发生变化时才处理
            {
               _loc3_ = this.value; // 保存旧值
               this.value = param1; // 更新为新值
               if(param2) // param2为true，表示值越大越好
               {
                  if(this.isUnlimitValue && this.value > this.aim) // 如果值不能超过目标且已超过
                  {
                     this.value = this.aim; // 设为目标值
                  }
                  if(this.bestValue < this.value) // 如果当前值是新的最佳值
                  {
                     this.prevBestValue = this.bestValue; // 保存上一个最佳值
                     this.bestValue = this.value; // 更新最佳值
                  }
               }
               else // param2为false，表示值越小越好
               {
                  if(this.isUnlimitValue && this.value < this.aim) // 如果值不能低于目标且已低于
                  {
                     this.value = this.aim; // 设为目标值
                  }
                  if(this.bestValue > this.value) // 如果当前值是新的最佳值
                  {
                     this.prevBestValue = this.bestValue;
                     this.bestValue = this.value;
                  }
               }
               if(this.isComplete == false || this.isCountable) // 如果成就未完成或可重复计数
               {
                  _loc4_ = true; // 默认显示特效
                  if(this.value < _loc3_ && this.decreasePlusEffect == false) // 如果值减小了且没有配置减小也显示特效
                  {
                     _loc4_ = false; // 则不显示特效
                  }
                  // 检查是否满足完成条件
                  if(param2 == true && this.aim <= this.value || param2 == false && this.aim >= this.value)
                  {
                     if(this.isUnlimitValue) // 如果值不能超过目标
                     {
                        this.value = this.aim; // 设为目标值
                     }
                     this.complete(); // 完成成就
                  }
                  else if(_loc4_ && this.updateEffect) // 如果需要显示特效
                  {
                     View.showEffectAchieveAdd(); // 显示进度增加特效
                  }
                  return true; // 表示已更新
               }
               return false;
            }
         }
         return false;
      }
      
      // 实例方法：更新最佳值
      public function updateBestValue() : void
      {
         if(this.bestValue < this.value) // 如果当前值大于历史最佳值
         {
            this.bestValue = this.value; // 更新最佳值
         }
      }
      
      // 实例方法：将成就设置为未完成
      public function setIncomplete() : void
      {
         this.isComplete = false;
      }
      
      // 实例方法：完成成就
      public function complete(param1:Boolean = false) : void
      {
         // 如果（成就未完成 或 可重复计数）并且满足前置条件
         if((this.isComplete == false || this.isCountable) && this.checkRequire() == true)
         {
            this.isComplete = true; // 标记为已完成
            ++this.count; // 完成次数加1
            this.onComplete(); // 调用完成时的处理逻辑
            if(this.isCountable) // 如果是可重复计数的成就
            {
               this.value = 0; // 重置进度值，以便下一次计数
            }
         }
      }
      
      // 实例方法：完成成就时的核心处理逻辑
      public function onComplete() : void
      {
         // 如果（配置为在胜利时显示 或 未配置）并且尚未被添加到新成就列表中
         if((this.typeObject.showOnWin == null || this.typeObject.showOnWin == true) && newAchievemets.indexOf(this) == -1)
         {
            newAchievemets.push(this); // 添加到新成就列表，用于在游戏结束时显示
         }
         this.showEffectComplete(); // 显示完成特效
         Age.dispatchEvent(GameEvent.ON_ACHIEVEMENT_COMPLETE,{"ach":this}); // 派发成就完成事件
         GV.score += this.reward; // 给予玩家分数奖励
         Age.log("Achive::complete\t" + this.caption + "\t" + this.type); // 记录日志
      }
      
      // 实例方法：显示完成特效
      public function showEffectComplete() : void
      {
         View.showEffectAchieveComplete(this);
      }
      
      // 实例方法：重置成就状态（用于调试）
      public function testReset() : void
      {
         if("value" in this.typeObject) // 如果配置了初始值
         {
            this.value = this.typeObject.value;
         }
         else
         {
            this.value = 0; // 否则重置为0
         }
         this.isComplete = false; // 设为未完成
      }
      
      // --- Getter 和 Setter ---
      
      // 获取成就的标题（动态格式化）
      public function get caption() : String
      {
         // 使用本地化工具格式化文本，替换占位符
         var _loc1_:String = Loc.formatText2(this.typeObject.str.caption,["%aim",this.aimStr(this)],["%value",this.valueStr(this)],["%bestValue",this.bestValueStr(this)],["%prevBestValue",this.prevBestValueStr(this)]);
         if(this.isCountable && this.count > 0) // 如果可重复计数且已完成过
         {
            _loc1_ += " x" + this.count; // 在标题后附加完成次数
         }
         return _loc1_;
      }
      
      // 获取原始的描述文本
      public function get protoDesc() : String
      {
         if(this.typeObject.str.desc is Function) // 如果描述是一个函数
         {
            return this.typeObject.str.desc(); // 调用函数获取描述
         }
         return this.typeObject.str.desc; // 否则直接返回描述字符串
      }
      
      // 获取格式化后的成就描述
      public function get description() : String
      {
         return Loc.formatText2(this.protoDesc,["%aim",this.aimStr(this)],["%value",this.valueStr(this)],["%bestValue",this.bestValueStr(this)],["%prevBestValue",this.prevBestValueStr(this)]);
      }
      
      // 获取提示信息
      public function get hint() : String
      {
         if(!this.typeObject.str.hint) // 如果没有配置提示信息
         {
            return "";
         }
         return Loc.formatText2(this.typeObject.str.hint,["%aim",this.aimStr(this)],["%value",this.valueStr(this)],["%bestValue",this.bestValueStr(this)],["%prevBestValue",this.prevBestValueStr(this)]);
      }
      
      // 获取简短描述
      public function get shortDesc() : String
      {
         if(!this.typeObject.str.shortDesc) // 如果没有配置简短描述
         {
            return this.caption; // 返回标题作为替代
         }
         return Loc.formatText2(this.typeObject.str.shortDesc,["%aim",this.aimStr(this)],["%value",this.valueStr(this)],["%bestValue",this.bestValueStr(this)]);
      }
      
      // 获取进度描述
      public function get descProgress() : String
      {
         if(!this.typeObject.str.progress) // 如果没有配置进度描述
         {
            return "";
         }
         return Loc.formatText2(this.typeObject.str.progress,["%aim",this.aimStr(this)],["%value",this.valueStr(this)],["%bestValue",this.bestValueStr(this)],["%prevBestValue",this.prevBestValueStr(this)]);
      }
      
      // 获取任务列表（基类中返回null，可能由子类实现）
      public function get tasks() : Array
      {
         return null;
      }
      
      // 获取目标值
      public function get aim() : int
      {
         return this.typeObject.aim;
      }
      
      // 获取奖励值
      public function get reward() : Number
      {
         return this.typeObject.reward;
      }
      
      // 获取前置成就
      public function get require() : Achieve
      {
         return this.typeObject.require;
      }
      
      // 获取图标类
      public function get iconClass() : Class
      {
         return !!this.typeObject.iconClass ? this.typeObject.iconClass : GS.ICON_ACHIEVE; // 返回配置的图标类，否则返回默认图标类
      }
      
      // 获取图标帧
      public function get iconFrame() : int
      {
         return !!this.typeObject.iconFrame ? int(this.typeObject.iconFrame) : 1; // 返回配置的图标帧，否则返回1
      }
      
      // 设置图标类
      public function set iconClass(param1:Class) : void
      {
         this.typeObject.iconClass = param1;
      }
      
      // 通过类定义或类名字符串设置图标类
      public function setIconClass(param1:Object) : void
      {
         if(param1 is Class) // 如果传入的是类
         {
            this.typeObject.iconClass = param1;
         }
         else if(param1 is String) // 如果传入的是字符串
         {
            this.typeObject.iconClass = getDefinitionByName(param1 as String); // 通过名称获取类定义
         }
      }
      
      // 设置图标帧
      public function set iconFrame(param1:int) : void
      {
         this.typeObject.iconFrame = param1;
      }
      
      // 获取进度百分比
      public function get progress() : Number
      {
         return this.value / this.aim * 100;
      }
      
      // 判断是否是系列成就中的下一个
      public function get isNextAch() : Boolean
      {
         return !!this.typeObject.nextAch ? Boolean(this.typeObject.nextAch) : false;
      }
      
      // 判断进度减少时是否也显示特效
      public function get decreasePlusEffect() : Boolean
      {
         return !!this.typeObject.decreasePlusEffect ? Boolean(this.typeObject.decreasePlusEffect) : false;
      }
      
      // 判断是否应该显示更新特效
      public function get updateEffect() : Boolean
      {
         if(this.typeObject.updateEffect != null && this.typeObject.updateEffect == false) // 如果明确配置为不显示
         {
            return false;
         }
         if(this.checkAfter() == false) // 如果后置条件不满足
         {
            return false;
         }
         return true; // 默认显示
      }
      
      // 在胜利界面显示成就信息
      public function showWinInfo(param1:MovieClip) : void
      {
         View.setPic(param1.icon,this.iconClass,this.iconFrame); // 设置图标
         if(this.isComplete) // 根据完成状态
         {
            param1.gotoAndStop("units"); // 显示为“已完成”外观
         }
         else
         {
            param1.gotoAndStop("unitsDisable"); // 显示为“未完成”外观
         }
         param1.bg.gotoAndStop(1); // 设置背景
         Loc.showText(param1.txtCaption,this.caption); // 显示标题
         var _loc2_:String = this.description; // 获取描述
         if(this.descProgress != "") // 如果有进度描述
         {
            _loc2_ += "\n" + this.descProgress; // 附加进度描述
         }
         if(this.hint != "") // 如果有提示
         {
            _loc2_ += "\n\n" + this.hint; // 附加提示
         }
         Loc.showText(param1.txtDesc,_loc2_); // 显示最终的描述文本
      }
   }
}

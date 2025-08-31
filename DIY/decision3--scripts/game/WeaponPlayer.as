package game
{
   import age.Age;
   import age.AgeEntity;
   import age.AgePrototype;
   import units.Unit;
   
   public class WeaponPlayer extends WeaponWithCursor
   {
      
      // 定义一个静态常量对象EXP，用于存储所有武器类型的经验值相关配置
      public static const EXP:Object = [];
      
      // 静态初始化块，在类加载时执行，用于填充EXP对象
      {
         // 刀的经验配置：最大经验1500，满级增加30点伤害
         EXP[Weapon.TYPE_KNIFE] = {
            "max":1500,
            "damage":30
         };
         // 手雷的经验配置：最大经验900，满级增加40点伤害
         EXP[Weapon.TYPE_GRENADE] = {
            "max":900,
            "damage":40
         };
         // 近战武器的经验配置：最大经验500，满级增加30点伤害
         EXP[Weapon.TYPE_MELEE] = {
            "max":500,
            "damage":30
         };
         // 榴弹发射器的经验配置：最大经验10000，满级增加40点伤害
         EXP[Weapon.TYPE_LAUNCHER] = {
            "max":10000,
            "damage":40
         };
         // 手枪的经验配置：最大经验5000，满级增加40点伤害
         EXP[Weapon.TYPE_PISTOL] = {
            "max":5000,
            "damage":40
         };
         // 机枪的经验配置：最大经验8000，满级增加30点伤害
         EXP[Weapon.TYPE_MACHINEGUN] = {
            "max":8000,
            "damage":30
         };
         // 霰弹枪的经验配置：最大经验9000，满级增加20点伤害
         EXP[Weapon.TYPE_SHOTGUN] = {
            "max":9000,
            "damage":20
         };
         // 步枪的经验配置：最大经验4000，满级增加50点伤害
         EXP[Weapon.TYPE_RIFLE] = {
            "max":4000,
            "damage":50
         };
         // ROKS喷火器的经验配置：最大经验4000，满级增加40点伤害
         EXP[Weapon.TYPE_ROKS] = {
            "max":4000,
            "damage":40
         };
         // 加特林机枪的经验配置：最大经验8000，满级增加20点伤害
         EXP[Weapon.TYPE_MINIGUN] = {
            "max":8000,
            "damage":20
         };
         // 地雷的经验配置：最大经验700，满级增加70点伤害
         EXP[Weapon.TYPE_MINE] = {
            "max":700,
            "damage":70
         };
         // RPG的经验配置：最大经验8000，满级增加40点伤害
         EXP[Weapon.TYPE_RPG] = {
            "max":8000,
            "damage":40
         };
         // 弓的经验配置：最大经验3500，满级增加30点伤害
         EXP[Weapon.TYPE_BOW] = {
            "max":3500,
            "damage":30
         };
      }
      
      // 标记当前武器是否有经验系统
      protected var mIsExp:Boolean;
      
      // 当前武器的经验等级
      protected var mExpLvl:int;
      
      // 标记武器是否正在蓄力
      protected var mCharge:Boolean;
      
      // 武器的连射/爆发加成系数
      protected var mBurst:Number;
      
      // 武器达到最大连射/爆发加成所需的时间
      protected var mBurstTime:Number;
      
      // 构造函数，接收一个原型对象
      public function WeaponPlayer(param1:AgePrototype)
      {
         // 调用父类的构造函数
         super(param1);
      }
      
      // 调试函数：设置指定武器类型的经验等级（0-10级）
      public static function debugSetExpLevel(param1:uint, param2:Number) : void
      {
         // 根据等级参数和最大经验值，计算并设置经验值
         GV.weaponExp[param1] = int(param2 * EXP[param1].max / 10);
      }
      
      // 调试函数：设置所有武器的经验等级
      public static function debugSetAllExpLevel(param1:Number) : void
      {
         var _loc2_:int = 1; // 初始化循环变量
         while(_loc2_ <= Weapon.TYPE_COUNT) // 遍历所有武器类型
         {
            // 调用debugSetExpLevel为每种武器设置等级
            debugSetExpLevel(1 << _loc2_,param1);
            _loc2_++; // 循环变量递增
         }
      }
      
      // 计算一组武器的平均标准化经验值（0到1之间）
      public static function getWeaponExpNorm(param1:Array) : Number
      {
         var _loc2_:Number = NaN; // 声明一个数字变量，用于存储单把武器的标准化经验
         var _loc4_:int = 0; // 声明一个整数变量，用于存储武器类型
         _loc2_ = 0; // 初始化
         var _loc3_:Number = 0; // 声明一个数字变量，用于累加所有武器的标准化经验
         for each(_loc4_ in param1) // 遍历传入的武器类型数组
         {
            // 计算标准化经验 = 当前经验 / 最大经验
            _loc2_ = GV.weaponExp[_loc4_] / WeaponPlayer.EXP[_loc4_].max;
            if(_loc2_ > 1) // 如果计算结果超过1
            {
               _loc2_ = 1; // 则将其置为1
            }
            _loc3_ += _loc2_; // 累加到总和中
         }
         // 返回平均值
         return _loc3_ / param1.length;
      }
      
      // 初始化武器实例
      override public function init(param1:Object = null) : void
      {
         super.init(param1); // 调用父类的初始化方法
         // 检查该武器类型是否有经验配置
         this.mIsExp = EXP[type] && EXP[type].max;
         if(this.mIsExp) // 如果有经验系统
         {
            // 计算当前经验等级（每10%经验升一级）
            this.mExpLvl = int(GV.weaponExp[type] / (EXP[type].max / 10));
            this.updateExp(); // 更新武器属性
         }
         this.mBurst = 1; // 初始化连射加成为1（无加成）
         // 从原型数据中获取连射时间，如果没有则默认为2
         this.mBurstTime = Number(prototype.burstTime) || Number(2);
         // 从原型数据中获取投掷几率，如果没有则默认为0
         mThrowChance = !!prototype.throwChance ? Number(prototype.throwChance) : Number(0);
         this.mCharge = false; // 初始化为非蓄力状态
      }
      
      // 激活武器时的逻辑（当前为空，继承父类）
      override public function activate() : void
      {
         super.activate();
      }
      
      // 射击方法
      override public function shoot(param1:AgeEntity, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint = 0, param7:uint = 4.294967295E9, param8:Object = null, param9:Number = NaN) : Object
      {
         this.mBurst = 1; // 每次射击时重置连射加成
         // 调用父类的射击方法
         return super.shoot(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      // 当武器对单位造成伤害时的回调
      override public function onApplyDamage(param1:Number, param2:Unit) : void
      {
         // 如果武器经验还未满
         if(GV.weaponExp[type] < EXP[type].max)
         {
            GV.weaponExp[type] += 1; // 经验值加1
            this.updateExp(); // 更新武器属性
            GV.gameInterface.showWeaponExp(type,1); // 在游戏界面上显示获得经验的提示
         }
      }
      
      // 根据当前经验值更新武器属性
      public function updateExp() : void
      {
         var _loc1_:Object = null; // 声明一个对象变量，用于存储当前武器的经验配置
         var _loc2_:Number = NaN; // 声明一个数字变量，用于存储标准化经验值
         if(this.mIsExp) // 如果武器有经验系统
         {
            _loc1_ = EXP[type]; // 获取经验配置
            _loc2_ = GV.weaponExp[type] / _loc1_.max; // 计算标准化经验值
            if(_loc2_ > 1) // 如果超过1
            {
               _loc2_ = 1; // 置为1
               GV.weaponExp[type] = _loc1_.max; // 并将当前经验值修正为最大值
            }
            // 如果计算出的新等级高于当前等级，说明升级了
            if(int(GV.weaponExp[type] / (_loc1_.max / 10)) > this.mExpLvl)
            {
               // 根据标准化经验和配置中的伤害加成，更新武器伤害
               mDamage.init(getProtoValue("damage") + _loc2_ * _loc1_.damage);
               // 如果武器有散射度且经验配置中也有散射度加成
               if(mDispersion && _loc1_.dispersion)
               {
                  // 更新散射度（经验越高，散射度越低）
                  mDispersion = !!getProtoValue("dispersion") ? Number(getProtoValue("dispersion")) : Number(0 - _loc2_ * _loc1_.dispersion);
               }
               // 更新当前经验等级
               this.mExpLvl = int(GV.weaponExp[type] / (_loc1_.max / 10));
               // 记录最后一个升级的武器
               GV.lastExpWeapon = this;
               // 如果不是近战武器
               if(type != Weapon.TYPE_MELEE)
               {
                  // 显示武器升级特效
                  View.showEffectNewWeaponExp(this,this.mExpLvl,GV.weaponExp[type],WeaponPlayer.EXP[type].max,_loc2_ * _loc1_.damage);
               }
            }
         }
      }
      
      // 开始蓄力
      override public function beginCharge() : void
      {
         this.mCharge = true;
      }
      
      // 开始连射/爆发，重置加成
      override public function beginBurst() : void
      {
         this.mBurst = 1;
      }
      
      // 更新连射/爆发加成
      override public function updateBurst() : void
      {
         // 根据玩家的爆发力能力、爆发时间和帧时间来增加加成
         this.mBurst += PlayerAbility.burstPower / this.mBurstTime * Age.frameTime;
         // 加成有上限
         if(this.mBurst > 1 + PlayerAbility.burstPower)
         {
            this.mBurst = 1 + PlayerAbility.burstPower;
         }
      }
      
      // 获取当前的连射/爆发加成系数
      override public function getBurst() : Number
      {
         return this.mBurst;
      }
      
      // 获取当前连射/爆发加成的百分比
      override public function getBurstPercent() : Number
      {
         // 如果玩家没有爆发力能力，则返回0
         if(PlayerAbility.burstPower == 0)
         {
            return 0;
         }
         // 计算并返回百分比
         return (this.mBurst - 1) * 100 / PlayerAbility.burstPower;
      }
      
      // 获取武器的伤害组ID
      override public function get damageGroup() : uint
      {
         return prototype.damageGroup;
      }
      
      // 获取武器的最终散射度（基础散射度 * 全局散射度系数）
      override public function get dispersion() : Number
      {
         return mDispersion * GV.dispersionCoef;
      }
      
      // 获取当前武器的经验值
      override public function get exp() : Number
      {
         return GV.weaponExp[type];
      }
      
      // 获取当前武器的最大经验值
      override public function get expMax() : Number
      {
         return EXP[type].max;
      }
      
      // 获取当前武器的标准化经验值
      override public function get expNorm() : Number
      {
         return GV.weaponExp[type] / EXP[type].max;
      }
      
      // 获取当前武器的经验等级
      override public function get expLvl() : int
      {
         return this.mExpLvl;
      }
      
      // 获取当前武器经验等级的字符串形式
      override public function get expString() : String
      {
         return this.mExpLvl.toString();
      }
      
      // 获取子弹轨迹特效的类（此处返回null，表示没有）
      override public function get trailSymbol() : Class
      {
         return null;
      }
      
      // 获取枪口火焰特效的类（此处返回null，表示没有）
      override public function get burstSymbol() : Class
      {
         return null;
      }
   }
}

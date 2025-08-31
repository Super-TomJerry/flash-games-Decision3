package game // 定义包名为 game
{
   import age.*; // 导入 age 包中的所有类
   import age.utils.Key; // 导入 age.utils 包中的 Key 类
   import flash.display.MovieClip; // 导入 flash.display 包中的 MovieClip 类
   import prototypes.PrototypeNPC; // 导入 prototypes 包中的 PrototypeNPC 类
   import prototypes.PrototypeWeaponPlayer; // 导入 prototypes 包中的 PrototypeWeaponPlayer 类
   import triggers.Trigger; // 导入 triggers 包中的 Trigger 类
   import units.Unit; // 导入 units 包中的 Unit 类
   import units.UnitEnemy; // 导入 units 包中的 UnitEnemy 类
   import units.UnitMercenary; // 导入 units 包中的 UnitMercenary 类
   
   public class PlayerAbility // 定义一个名为 PlayerAbility 的公共类
   {
      
      public static var engineering:int; // 工程学技能等级
      
      public static var stamina:int; // 耐力技能等级
      
      public static var melee:int; // 近战技能等级
      
      public static var rage:int; // 狂暴技能等级
      
      public static var stability:int; // 稳定技能等级
      
      public static var hacker:int; // 黑客技能等级
      
      public static var agility:int; // 敏捷技能等级
      
      public static var taunt:int; // 嘲讽技能等级
      
      public static var navigator:int; // 导航员技能等级
      
      public static var rageInjection:int; // 狂暴注射技能等级
      
      public static var grab:int; // 抓取技能等级
      
      public static var jump:int; // 跳跃技能等级
      
      public static var recruits:int; // 招募技能等级
      
      public static var supply:int; // 补给技能等级
      
      public static var elite:int; // 精英技能等级
      
      public static var finder:int; // 寻宝者技能等级
      
      public static var armorS:int; // S 型护甲等级
      
      public static var armorM:int; // M 型护甲等级
      
      public static var armorL:int; // L 型护甲等级
      
      public static var armorX:int; // X 型护甲等级
      
      public static const numStamina:int = 0; // 耐力技能编号
      
      public static const numEngineering:int = 1; // 工程学技能编号
      
      public static const numHacker:int = 2; // 黑客技能编号
      
      public static const numNavigator:int = 3; // 导航员技能编号
      
      public static const numRecruits:int = 4; // 招募技能编号
      
      public static const numAgility:int = 5; // 敏捷技能编号
      
      public static const numStability:int = 6; // 稳定技能编号
      
      public static const numMelee:int = 7; // 近战技能编号
      
      public static const numSupply:int = 8; // 补给技能编号
      
      public static const numRage:int = 9; // 狂暴技能编号
      
      public static const numRageInjection:int = 10; // 狂暴注射技能编号
      
      public static const numTaunt:int = 11; // 嘲讽技能编号
      
      public static const numJump:int = 12; // 跳跃技能编号
      
      public static const numGrab:int = 13; // 抓取技能编号
      
      public static const numElite:int = 14; // 精英技能编号
      
      public static const numArmorS:int = 16; // S 型护甲编号
      
      public static const numArmorM:int = 17; // M 型护甲编号
      
      public static const numArmorL:int = 18; // L 型护甲编号
      
      public static const numArmorX:int = 19; // X 型护甲编号
      
      public static var MASTER_ABILITY:Array = [[numArmorM,0,1,2],[3,4,5],[numArmorL,6,7,8],[9,10],[numArmorX,11,12],[13,14]]; // 主技能树数组
      
      public static var taran:int; // 冲撞技能等级
      
      public static var guards:int; // 守卫技能等级
      
      public static var fling:int; // 投掷技能等级
      
      public static var merc:int; // 佣兵技能等级
      
      public static var thunder:int; // 雷电技能等级
      
      public static var burst:int; // 爆发技能等级
      
      public static var charge:int; // 冲锋技能等级
      
      public static const numThunder:int = 21; // 雷电技能编号
      
      public static const numTaran:int = 22; // 冲撞技能编号
      
      public static const numBurst:int = 23; // 爆发技能编号
      
      public static const numCharge:int = 24; // 冲锋技能编号
      
      public static const numMerc:int = 25; // 佣兵技能编号
      
      public static var abilities:Array; // 存储所有技能的数组
      
      public static var recruitsCount:Array = [0,1,3,6]; // 不同等级招募技能对应的招募数量
      
      public static var recruitsMaxCount:int = recruitsCount[3]; // 最大招募数量
      
      public static var staminaHealth:Array = [0,100,150,220]; // 不同等级耐力技能增加的生命值
      
      public static var staminaRegeneration:Array = [0,3,6,10]; // 不同等级耐力技能增加的生命恢复速度
      
      public static var meleeHandWeapon:Weapon; // 徒手近战武器
      
      public static var meleeRoundWeapon:Weapon; // 回旋近战武器
      
      public static var meleeKarateWeapon:Weapon; // 空手道近战武器
      
      public static var flingWeapon:Weapon; // 投掷武器
      
      public static var jumpWeapon:Weapon; // 跳跃攻击武器
      
      public static var jumpOn:Boolean = false; // 跳跃状态是否开启
      
      public static var rageReload:Number; // 狂暴技能冷却计时
      
      public static var rageReloadTime:Number = 20; // 狂暴技能冷却时间
      
      public static var rageTime:Number = 4; // 狂暴技能持续时间
      
      public static var mineReload:Number; // 地雷技能冷却计时
      
      public static var mineReloadTime:Number; // 地雷技能冷却时间
      
      public static var minePrototype:AgePrototype; // 地雷的原型
      
      public static var mineTimeToPlace:Number; // 放置地雷所需时间
      
      protected static var stabilityArmorValues:Array = [0,0.1,0.2,0.3]; // 不同等级稳定技能提供的护甲值
      
      protected static var stabilityThrowValues:Array = [0.2,0.3,0.5,0.6]; // 不同等级稳定技能提供的投掷加成
      
      public static var stabilityOn:Boolean; // 稳定技能是否开启
      
      public static var stabilityArmor:Number; // 当前稳定技能提供的护甲
      
      public static var stabilityThrow:Number; // 当前稳定技能提供的投掷加成
      
      public static var stabilitySkillSpeed:Number = 1; // 稳定技能的速度系数
      
      public static var burstPower:Number; // 爆发技能的威力
      
      protected static var burstPowerValues:Array = [0,1,3,4]; // 不同等级爆发技能的威力值
      
      public static var burstPowerBar:Array = [0,36,9,1]; // 爆发技能能量条相关数值
      
      public static var tauntReload:Number; // 嘲讽技能冷却计时
      
      public static var tauntReloadTime:Number = 12; // 嘲讽技能冷却时间
      
      public static var rageInjReload:Number; // 狂暴注射技能冷却计时
      
      public static var rageInjReloadTime:Number; // 狂暴注射技能冷却时间
      
      public static var rageInjWeapon:Weapon; // 狂暴注射技能武器
      
      public static var thunderReady:Boolean; // 雷电技能是否准备就绪
      
      public static var thunderCount:Number; // 雷电技能计数
      
      public static var thunderReqCount:Number = 4; // 释放雷电技能所需的计数
      
      public static var thunderWeapon:Weapon; // 雷电技能武器
      
      public static var thunderDamageCoef:Number; // 雷电技能伤害系数
      
      public static var thunderDamageCoefValues:Array = [1,1.5,1.8,2]; // 不同等级雷电技能的伤害系数值
      
      protected static var hackerHackTime:Array = [2,5,3,0.1]; // 不同等级黑客技能的破解时间
      
      public static var agilityOn:Boolean; // 敏捷技能是否开启
      
      public static var agilityCharge:Number; // 敏捷技能充能值
      
      public static var agilitySpeedCoef:Number; // 敏捷技能速度系数
      
      public static var agilityIncreaseSpeed:Number; // 敏捷技能加速值
      
      public static var agilityDecreaseSpeed:Number; // 敏捷技能减速值
      
      public static var agilityValues:Object = { // 敏捷技能各等级数值
         "speed":[3.6,4,5,5.5], // 速度
         "speedCoef":[1,1.6,1.7,1.8], // 速度系数
         "incSpeed":[0.8,1,1.2,1.5], // 加速值
         "decSpeed":[2.6,2.3,1.8,1.6] // 减速值
      };
      
      public static var taranAvailable:Boolean; // 冲撞技能是否可用
      
      public static var taranWeapon:Weapon; // 冲撞技能武器
      
      public static var taranEnemyCount:int; // 冲撞技能可影响的敌人数量
      
      public static var taranEnemyCountValues:Array = [0,4,7,10]; // 不同等级冲撞技能可影响的敌人数量
      
      protected static var chargePowerValues:Array = [1,1.2,1.3,1.5]; // 不同等级冲锋技能的威力系数
      
      protected static var chargeDistValues:Array = [0,150,200,300]; // 不同等级冲锋技能的距离
      
      public static var chargePower:Number; // 当前冲锋技能威力
      
      public static var chargeDist:Number; // 当前冲锋技能距离
      
      public static var grabChance:Array = [0,20,40,60]; // 不同等级抓取技能的基础成功率
      
      public static var grabChanceExp:Number = 30; // 抓取技能经验对成功率的影响系数
      
      public static var grabReload:Number; // 抓取技能冷却计时
      
      public static var grabReloadTime:Number = 7; // 抓取技能冷却时间
      
      public static var grabWeapon:Weapon; // 抓取技能武器
      
      public static var grabUnit:UnitEnemy; // 被抓取的敌方单位
      
      public static var grabUnitProto:String; // 被抓取的敌方单位的原型名称
      
      public static var mercUnits:Vector.<Unit>; // 佣兵单位向量
      
      public static var mercAssist:Vector.<Boolean>; // 佣兵协助状态向量
      
      public static var cells:Array; // 技能快捷栏数组
      
      public static var curArmor:Object; // 当前装备的护甲
      
      public static var lastAbility:Object; // 上一个使用的技能
       
      
      public function PlayerAbility() // 构造函数
      {
         super(); // 调用父类的构造函数
      }
      
      public static function get hackerTime() : Number // 获取黑客破解时间
      {
         return hackerHackTime[hacker]; // 返回当前黑客等级对应的破解时间
      }
      
      public static function get hackerAnim() : String // 获取黑客破解动画名称
      {
         if(hacker == 3) // 如果黑客等级为3
         {
            return "playAttackLeg"; // 返回腿部攻击动画
         }
         return "playUse"; // 否则返回使用动画
      }
      
      public static function get agilityMoveSpeed() : Number // 获取敏捷移动速度
      {
         return agilityValues.speed[agility]; // 返回当前敏捷等级对应的移动速度
      }
      
      public static function get armorSExp() : Number // 获取 S 型护甲经验值
      {
         return abilities[numArmorS].exp; // 返回 S 型护甲的经验值
      }
      
      public static function set armorSExp(param1:Number) : void // 设置 S 型护甲经验值
      {
         if(param1 > 10) // 如果经验值超过10
         {
            param1 = 10; // 将经验值设为10
         }
         abilities[numArmorS].exp = param1; // 设置 S 型护甲的经验值
      }
      
      public static function get armorMExp() : Number // 获取 M 型护甲经验值
      {
         return abilities[numArmorM].exp; // 返回 M 型护甲的经验值
      }
      
      public static function set armorMExp(param1:Number) : void // 设置 M 型护甲经验值
      {
         if(param1 > 10) // 如果经验值超过10
         {
            param1 = 10; // 将经验值设为10
         }
         abilities[numArmorM].exp = param1; // 设置 M 型护甲的经验值
      }
      
      public static function get armorLExp() : Number // 获取 L 型护甲经验值
      {
         return abilities[numArmorL].exp; // 返回 L 型护甲的经验值
      }
      
      public static function set armorLExp(param1:Number) : void // 设置 L 型护甲经验值
      {
         if(param1 > 10) // 如果经验值超过10
         {
            param1 = 10; // 将经验值设为10
         }
         abilities[numArmorL].exp = param1; // 设置 L 型护甲的经验值
      }
      
      public static function get armorXExp() : Number // 获取 X 型护甲经验值
      {
         return abilities[numArmorX].exp; // 返回 X 型护甲的经验值
      }
      
      public static function set armorXExp(param1:Number) : void // 设置 X 型护甲经验值
      {
         if(param1 > 10) // 如果经验值超过10
         {
            param1 = 10; // 将经验值设为10
         }
         abilities[numArmorX].exp = param1; // 设置 X 型护甲的经验值
      }
      
      public static function get grabExp() : Number // 获取抓取技能经验值
      {
         return abilities[numGrab].exp; // 返回抓取技能的经验值
      }
      
      public static function set grabExp(param1:Number) : void // 设置抓取技能经验值
      {
         if(param1 > 10) // 如果经验值超过10
         {
            param1 = 10; // 将经验值设为10
         }
         abilities[numGrab].exp = param1; // 设置抓取技能的经验值
      }
      
      public static function get curArmorSafe() : Number // 获取当前护甲的减伤值
      {
         return curArmor.safe[curArmor.getValue()] + curArmor.expSafe * curArmor.exp / 10; // 返回基础减伤值 + 经验加成减伤值
      }
      
      public static function initAbility(param1:int, param2:Object) : void // 初始化单个技能
      {
         param2.num = param1; // 设置技能编号
         abilities[param1] = param2; // 将技能对象存入数组
         param2.setValue(0); // 设置技能初始等级为0
      }
      
      public static function resetGame() : void // 重置游戏状态
      {
         curArmor = null; // 清空当前护甲
         lastAbility = null; // 清空上一个使用的技能
         cells = []; // 清空技能快捷栏
         abilities = []; // 清空技能数组
         initAbility(numEngineering,{ // 初始化工程学技能
            "active":false, // 是否为主动技能
            "caption":Loc.ABILITY_ENGINEERING, // 技能标题
            "desc":getEngineeringDesc, // 技能描述获取函数
            "getValue":getEngineering, // 获取技能等级函数
            "setValue":setEngineering // 设置技能等级函数
         });
         initAbility(numStamina,{ // 初始化耐力技能
            "active":false,
            "caption":Loc.ABILITY_STAMINA,
            "desc":getStaminaDesc,
            "getValue":getStamina,
            "setValue":setStamina
         });
         initAbility(numMelee,{ // 初始化近战技能
            "active":false,
            "caption":Loc.ABILITY_MELEE,
            "desc":getMeleeDesc,
            "getValue":getMelee,
            "setValue":setMelee
         });
         initAbility(numRage,{ // 初始化狂暴技能
            "active":false,
            "shortcut":Shortcut.ABILITY_RAGE, // 快捷键
            "caption":Loc.ABILITY_RAGE,
            "desc":getRageDesc,
            "getValue":getRage,
            "setValue":setRage
         });
         initAbility(numStability,{ // 初始化稳定技能
            "active":true,
            "shortcut":Shortcut.ABILITY_STABILITY,
            "caption":Loc.ABILITY_STABILITY,
            "desc":getStabilityDesc,
            "getValue":getStability,
            "setValue":setStability
         });
         initAbility(numHacker,{ // 初始化黑客技能
            "active":false,
            "caption":Loc.ABILITY_HACKER,
            "desc":getHackerDesc,
            "getValue":getHacker,
            "setValue":setHacker
         });
         initAbility(numAgility,{ // 初始化敏捷技能
            "active":true,
            "shortcut":Shortcut.ABILITY_AGILITY,
            "caption":Loc.ABILITY_AGILITY,
            "desc":getAgilityDesc,
            "getValue":getAgility,
            "setValue":setAgility
         });
         initAbility(numTaunt,{ // 初始化嘲讽技能
            "active":true,
            "shortcut":Shortcut.ABILITY_TAUNT,
            "caption":Loc.ABILITY_TAUNT,
            "desc":Loc.ABILITY_TAUNT_DESC,
            "getValue":getTaunt,
            "setValue":setTaunt
         });
         initAbility(numNavigator,{ // 初始化导航员技能
            "active":true,
            "shortcut":Shortcut.ABILITY_NAVIGATOR,
            "caption":Loc.ABILITY_NAVIGATOR,
            "desc":getNavigatorDesc,
            "getValue":getNavigator,
            "setValue":setNavigator
         });
         initAbility(numRageInjection,{ // 初始化狂暴注射技能
            "active":true,
            "reloadTime":4, // 冷却时间
            "shortcut":Shortcut.ABILITY_RAGE_INJECTION,
            "caption":Loc.ABILITY_RAGE_INJECTION,
            "desc":Loc.ABILITY_RAGE_INJECTION_DESC,
            "getValue":getRageInj,
            "setValue":setRageInj
         });
         initAbility(numGrab,{ // 初始化抓取技能
            "active":true,
            "shortcut":Shortcut.ABILITY_GRAB,
            "exp":0, // 经验值
            "caption":Loc.ABILITY_GRAB,
            "desc":getGrabDesc,
            "getValue":getGrab,
            "setValue":setGrab
         });
         initAbility(numJump,{ // 初始化跳跃技能
            "active":true,
            "shortcut":Shortcut.ABILITY_JUMP,
            "caption":Loc.ABILITY_JUMP,
            "desc":getJumpDesc,
            "getValue":getJump,
            "setValue":setJump
         });
         initAbility(numRecruits,{ // 初始化招募技能
            "active":false,
            "caption":Loc.ABILITY_RECRUITS,
            "desc":getRecruitsDesc,
            "getValue":getRecruits,
            "setValue":setRecruits
         });
         initAbility(numSupply,{ // 初始化补给技能
            "active":false,
            "caption":Loc.ABILITY_SUPPLY,
            "desc":getSupplyDesc,
            "getValue":getSupply,
            "setValue":setSupply
         });
         initAbility(numElite,{ // 初始化精英技能
            "active":false,
            "caption":Loc.ABILITY_ELITE,
            "desc":Loc.ABILITY_ELITE_DESC,
            "getValue":getElite,
            "setValue":setElite
         });
         initAbility(numArmorS,{ // 初始化 S 型护甲
            "active":false,
            "exp":0,
            "safe":[0,0.05,0.1,0.2], // 各等级减伤值
            "expSafe":0.2, // 经验减伤系数
            "speedCoef":1.05, // 速度系数
            "animSymbols":GS.ARMOR_S, // 动画符号
            "caption":Loc.ABILITY_ARMOR_S,
            "desc":getArmorSDesc,
            "getValue":getArmorS,
            "setValue":setArmorS
         });
         initAbility(numArmorM,{ // 初始化 M 型护甲
            "active":false,
            "exp":0,
            "safe":[0,0.1,0.2,0.25],
            "expSafe":0.2,
            "speedCoef":0.9,
            "animSymbols":GS.ARMOR_M,
            "caption":Loc.ABILITY_ARMOR_M,
            "desc":getArmorMDesc,
            "getValue":getArmorM,
            "setValue":setArmorM
         });
         initAbility(numArmorL,{ // 初始化 L 型护甲
            "active":false,
            "exp":0,
            "safe":[0,0.15,0.3,0.4],
            "expSafe":0.2,
            "speedCoef":0.8,
            "animSymbols":GS.ARMOR_L,
            "caption":Loc.ABILITY_ARMOR_L,
            "desc":getArmorLDesc,
            "getValue":getArmorL,
            "setValue":setArmorL
         });
         initAbility(numArmorX,{ // 初始化 X 型护甲
            "active":false,
            "exp":0,
            "safe":[0,0.2,0.4,0.6],
            "expSafe":0.2,
            "speedCoef":0.7,
            "animSymbols":GS.ARMOR_XL,
            "caption":Loc.ABILITY_ARMOR_X,
            "desc":getArmorXDesc,
            "getValue":getArmorX,
            "setValue":setArmorX
         });
         abilities[numMelee].cost = [0,2500,5500,9000]; // 设置近战技能升级花费
         abilities[numEngineering].cost = [0,300,1500,3000]; // 设置工程学技能升级花费
         abilities[numNavigator].cost = [0,400,2000,4000]; // 设置导航员技能升级花费
         abilities[numHacker].cost = [0,450,2250,4500]; // 设置黑客技能升级花费
         abilities[numAgility].cost = [0,450,2700,4950]; // 设置敏捷技能升级花费
         abilities[numStamina].cost = [0,550,2750,5500]; // 设置耐力技能升级花费
         abilities[numJump].cost = [0,700,3500,7000]; // 设置跳跃技能升级花费
         abilities[numStability].cost = [0,800,4000,8000]; // 设置稳定技能升级花费
         abilities[numRage].cost = [0,1000,3000,6000]; // 设置狂暴技能升级花费
         abilities[numRageInjection].cost = [0,5000]; // 设置狂暴注射技能升级花费
         abilities[numTaunt].cost = [0,4000]; // 设置嘲讽技能升级花费
         abilities[numArmorS].cost = [0,500,3000,7000]; // 设置 S 型护甲升级花费
         abilities[numArmorM].cost = [0,1500,4500,9000]; // 设置 M 型护甲升级花费
         abilities[numArmorL].cost = [0,3000,7000,12000]; // 设置 L 型护甲升级花费
         abilities[numArmorX].cost = [0,2000,7000,18000]; // 设置 X 型护甲升级花费
         abilities[numElite].cost = [0,5000,7000,10000]; // 设置精英技能升级花费
         abilities[numGrab].cost = [0,1000,4000,10000]; // 设置抓取技能升级花费
         abilities[numRecruits].cost = [0,3000,7000,20000]; // 设置招募技能升级花费
         abilities[numSupply].cost = [0,2000,6000,10000]; // 设置补给技能升级花费
         grabExp = 0; // 重置抓取技能经验
         mercAssist = new <Boolean>[true,true,true]; // 重置佣兵协助状态
         if(Age.debug) // 如果是调试模式
         {
            debugSetAllAbilities(0); // 设置所有技能为0级
            checkCells(); // 检查技能快捷栏
         }
         if(meleeHandWeapon == null) // 如果徒手近战武器未初始化
         {
            meleeHandWeapon = PrototypeWeaponPlayer.HAND.createAndInit(); // 创建并初始化徒手近战武器
         }
         setArmorS(1); // 设置 S 型护甲等级为1
      }
      
      public static function saveGame() : void // 保存游戏
      {
         var _loc2_:int = 0; // 局部变量，循环计数器
         var _loc1_:Object = GV.saveGame.data; // 获取存档数据对象
         _loc1_.abilities = []; // 初始化存档中的技能数组
         _loc2_ = 0; // 重置计数器
         while(_loc2_ < abilities.length) // 遍历所有技能
         {
            if(abilities[_loc2_]) // 如果技能存在
            {
               _loc1_.abilities[_loc2_] = abilities[_loc2_].getValue(); // 保存技能等级
            }
            _loc2_++; // 计数器加一
         }
         var _loc3_:Array = []; // 局部变量，用于存储快捷栏技能编号
         _loc2_ = 0; // 重置计数器
         while(_loc2_ < cells.length) // 遍历技能快捷栏
         {
            if(cells[_loc2_]) // 如果快捷栏位置有技能
            {
               _loc3_[_loc2_] = cells[_loc2_].num; // 保存技能编号
            }
            else // 如果没有技能
            {
               _loc3_[_loc2_] = -1; // 保存-1
            }
            _loc2_++; // 计数器加一
         }
         _loc1_.cells = _loc3_; // 保存技能快捷栏
         if(curArmor) // 如果当前有装备护甲
         {
            _loc1_.armor = curArmor.num; // 保存护甲编号
         }
         else // 如果没有装备护甲
         {
            _loc1_.armor = null; // 保存 null
         }
         _loc1_.armorSExp = armorSExp; // 保存 S 型护甲经验
         _loc1_.armorMExp = armorMExp; // 保存 M 型护甲经验
         _loc1_.armorLExp = armorLExp; // 保存 L 型护甲经验
         _loc1_.armorXExp = armorXExp; // 保存 X 型护甲经验
         _loc1_.grabExp = grabExp; // 保存抓取技能经验
         _loc1_.grabUnitProto = grabUnitProto; // 保存抓取单位原型名称
         if(merc) // 如果有佣兵
         {
            _loc1_.mercAssist = AgeU.vecToArray(mercAssist); // 保存佣兵协助状态
         }
      }
      
      public static function loadGame(param1:Object) : void // 加载游戏
      {
         var _loc2_:int = 0; // 局部变量，循环计数器
         var _loc3_:Object = null; // 局部变量，用于存储技能对象
         if(param1.abilities) // 如果存档中有技能数据
         {
            _loc2_ = 0; // 重置计数器
            while(_loc2_ < abilities.length) // 遍历所有技能
            {
               if(param1.abilities[_loc2_] && abilities[_loc2_]) // 如果存档和当前游戏都存在该技能
               {
                  abilities[_loc2_].setValue(param1.abilities[_loc2_]); // 加载技能等级
               }
               _loc2_++; // 计数器加一
            }
         }
         cells = []; // 清空技能快捷栏
         if(param1.cells) // 如果存档中有快捷栏数据
         {
            _loc2_ = 0; // 重置计数器
            while(_loc2_ < param1.cells.length) // 遍历存档中的快捷栏
            {
               _loc3_ = abilities[param1.cells[_loc2_]]; // 获取技能对象
               if(_loc3_ && _loc3_.getValue() > 0 && cells.indexOf(_loc3_) == -1) // 如果技能有效且不在快捷栏中
               {
                  cells.push(_loc3_); // 将技能添加到快捷栏
               }
               _loc2_++; // 计数器加一
            }
         }
         else // 如果存档中没有快捷栏数据
         {
            _loc2_ = 0; // 重置计数器
            while(_loc2_ < abilities.length) // 遍历所有技能
            {
               _loc3_ = abilities[_loc2_]; // 获取技能对象
               if(_loc3_ && _loc3_.getValue() > 0 && _loc3_.active == true) // 如果技能有效且为主动技能
               {
                  cells.push(_loc3_); // 将技能添加到快捷栏
               }
               _loc2_++; // 计数器加一
            }
         }
         checkCells(); // 检查并更新快捷栏
         if(param1.armor != null && (param1.armor == numArmorS || param1.armor == numArmorM || param1.armor == numArmorL)) // 如果存档中有 S, M, L 型护甲
         {
            curArmor = abilities[param1.armor]; // 加载护甲
         }
         else if(armorX) // 否则如果拥有 X 型护甲
         {
            curArmor = abilities[numArmorX]; // 装备 X 型护甲
         }
         else if(armorL) // 否则如果拥有 L 型护甲
         {
            curArmor = abilities[numArmorL]; // 装备 L 型护甲
         }
         else if(armorM) // 否则如果拥有 M 型护甲
         {
            curArmor = abilities[numArmorM]; // 装备 M 型护甲
         }
         else if(armorS) // 否则如果拥有 S 型护甲
         {
            curArmor = abilities[numArmorS]; // 装备 S 型护甲
         }
         else // 否则
         {
            curArmor = null; // 没有护甲
         }
         if(param1.armorSExp) // 如果存档中有 S 型护甲经验
         {
            armorSExp = param1.armorSExp; // 加载经验
         }
         if(armorSExp > 10) // 如果经验超过上限
         {
            armorSExp = 10; // 设为上限
         }
         if(param1.armorMExp) // 如果存档中有 M 型护甲经验
         {
            armorMExp = param1.armorMExp; // 加载经验
         }
         if(armorMExp > 10) // 如果经验超过上限
         {
            armorMExp = 10; // 设为上限
         }
         if(param1.armorLExp) // 如果存档中有 L 型护甲经验
         {
            armorLExp = param1.armorLExp; // 加载经验
         }
         if(armorLExp > 10) // 如果经验超过上限
         {
            armorLExp = 10; // 设为上限
         }
         if(param1.armorXExp) // 如果存档中有 X 型护甲经验
         {
            armorXExp = param1.armorXExp; // 加载经验
         }
         if(armorXExp > 10) // 如果经验超过上限
         {
            armorXExp = 10; // 设为上限
         }
         if(param1.grabExp) // 如果存档中有抓取技能经验
         {
            grabExp = param1.grabExp; // 加载经验
         }
         if(grabExp > 10) // 如果经验超过上限
         {
            grabExp = 10; // 设为上限
         }
         if(param1.grabUnitProto) // 如果存档中有抓取单位原型
         {
            grabUnitProto = param1.grabUnitProto; // 加载原型名称
         }
         if(AgePrototype.getByName(grabUnitProto) == null) // 如果该原型不存在
         {
            grabUnitProto = null; // 清空
         }
         if(merc) // 如果有佣兵
         {
            mercAssist = new Vector.<Boolean>(); // 创建新的佣兵协助状态向量
            AgeU.copyArr(param1.mercAssist,mercAssist); // 从存档复制数据
         }
         Achieve.START_ALL_update(); // 更新 "START_ALL" 成就
         Achieve.ATHLETE_update(); // 更新 "ATHLETE" 成就
      }
      
      public static function update() : void // 每帧更新
      {
         if(meleeHandWeapon) // 如果徒手近战武器存在
         {
            meleeHandWeapon.update(); // 更新武器状态
         }
         if(meleeRoundWeapon) // 如果回旋近战武器存在
         {
            meleeRoundWeapon.update(); // 更新武器状态
         }
         if(meleeKarateWeapon) // 如果空手道近战武器存在
         {
            meleeKarateWeapon.update(); // 更新武器状态
         }
         if(jumpWeapon) // 如果跳跃攻击武器存在
         {
            jumpWeapon.update(); // 更新武器状态
         }
      }
      
      public static function getAbility(param1:int, param2:int = -1) : Object // 获取技能信息
      {
         var _loc3_:Object = abilities[param1]; // 获取技能对象
         if(_loc3_ == null) // 如果技能不存在
         {
            return null; // 返回 null
         }
         if(param2 == -1) // 如果未指定等级
         {
            param2 = _loc3_.getValue(); // 使用当前等级
         }
         return { // 返回技能信息对象
            "num":param1, // 技能编号
            "lvl":param2, // 技能等级
            "caption":getAbilityCaption(param1,param2), // 技能标题
            "desc":getAbilityDesc(param1,param2), // 技能描述
            "icon":getAbilityIcon(param1,param2), // 技能图标
            "cost":(param2 < 3 ? _loc3_.cost[param2 + 1] : Number.POSITIVE_INFINITY), // 升级花费
            "shortcut":_loc3_.shortcut, // 快捷键
            "exp":(!!_loc3_.hasOwnProperty("exp") ? _loc3_.exp : null) // 经验值
         };
      }
      
      public static function getAbilityExp(param1:int) : * // 获取技能经验
      {
         var _loc2_:Object = abilities[param1]; // 获取技能对象
         if(_loc2_ == null) // 如果技能不存在
         {
            return null; // 返回 null
         }
         return !!_loc2_.hasOwnProperty("exp") ? _loc2_.exp : null; // 返回经验值，如果存在的话
      }
      
      public static function getAbilityCost(param1:int, param2:int = -1) : Number // 获取技能升级花费
      {
         var _loc3_:Object = abilities[param1]; // 获取技能对象
         return _loc3_.cost[param2 != -1 ? param2 : _loc3_.getValue() + 1]; // 返回指定等级或下一等级的花费
      }
      
      public static function getAbilityCaption(param1:int, param2:int) : String // 获取技能标题
      {
         if(abilities[param1].caption is Function) // 如果标题是函数
         {
            return abilities[param1].caption(param2); // 调用函数获取标题
         }
         if(abilities[param1].caption is String) // 如果标题是字符串
         {
            return abilities[param1].caption; // 直接返回标题
         }
         return abilities[param1].caption[param2 > 0 ? param2 - 1 : param2]; // 从数组中获取标题
      }
      
      public static function getAbilityDesc(param1:int, param2:int) : String // 获取技能描述
      {
         if(abilities[param1].desc is Function) // 如果描述是函数
         {
            return abilities[param1].desc(param2); // 调用函数获取描述
         }
         if(abilities[param1].desc is String) // 如果描述是字符串
         {
            return abilities[param1].desc; // 直接返回描述
         }
         return abilities[param1].desc[param2 - 1]; // 从数组中获取描述
      }
      
      public static function getAbilityLevel(param1:int) : int // 获取技能等级
      {
         return abilities[param1].getValue(); // 返回技能当前等级
      }
      
      public static function getAbilityMaxLevel(param1:int) : int // 获取技能最大等级
      {
         return abilities[param1].cost.length - 1; // 根据花费数组长度计算最大等级
      }
      
      public static function getAbilityIcon(param1:int, param2:int = -1) : int // 获取技能图标
      {
         if(param2 == -1) // 如果未指定等级
         {
            param2 = abilities[param1].getValue(); // 使用当前等级
         }
         return GS.FRAME_ABILITY[param1] + (param2 > 0 ? param2 : 0); // 计算并返回图标帧数
      }
      
      public static function getAbilityShortcut(param1:int, param2:int) : int // 获取技能快捷键
      {
         if(param2 == -1) // 如果未指定等级
         {
            param2 = abilities[param1].getValue(); // 使用当前等级
         }
         var _loc3_:Object = abilities[param1]; // 获取技能对象
         if(_loc3_.shortcut && _loc3_.shortcut is Function) // 如果快捷键是函数
         {
            return _loc3_.shortcut(param2); // 调用函数获取快捷键
         }
         return _loc3_.shortcut; // 直接返回快捷键
      }
      
      public static function setAbility(param1:int, param2:int, param3:Boolean = false) : Boolean // 设置技能等级（升级）
      {
         var _loc5_:Number = NaN; // 局部变量，存储花费
         var _loc4_:Object = abilities[param1]; // 获取技能对象
         if(param3 == false) // 如果不是免费升级
         {
            _loc5_ = _loc4_.cost[param2]; // 获取升级花费
            if(GV.money < _loc5_) // 如果金钱不足
            {
               return false; // 返回 false
            }
            GV.money -= _loc5_; // 扣除金钱
            GV.score += GC.SCORE_ABILITY * _loc5_; // 增加分数
            lastAbility = _loc4_; // 记录为上一个使用的技能
         }
         _loc4_.setValue(param2); // 设置新的技能等级
         if(param2 > 0 && _loc4_.active && cells.indexOf(_loc4_) == -1) // 如果技能升级后变为可用主动技能且不在快捷栏
         {
            cells.push(_loc4_); // 添加到快捷栏
         }
         return true; // 返回 true
      }
      
      public static function setCellAbility(param1:int, param2:int) : Object // 设置快捷栏技能
      {
         var _loc3_:Object = cells[param1]; // 获取原快捷栏位置的技能
         cells[param1] = abilities[param2]; // 设置新的技能
         return _loc3_; // 返回被替换的技能
      }
      
      public static function swapCells(param1:int, param2:int) : void // 交换快捷栏技能位置
      {
         var _loc3_:Object = cells[param2]; // 临时存储技能
         cells[param2] = cells[param1]; // 交换
         cells[param1] = _loc3_; // 完成交换
      }
      
      public static function setArmorCell(param1:int) : void // 设置护甲
      {
         curArmor = abilities[param1]; // 将指定技能（护甲）设为当前护甲
      }
      
      public static function getEngineering() : int // 获取工程学等级
      {
         return engineering;
      }
      
      public static function getMelee() : int // 获取近战等级
      {
         return melee;
      }
      
      public static function getFling() : int // 获取投掷等级
      {
         return fling;
      }
      
      public static function getRage() : int // 获取狂暴等级
      {
         return rage;
      }
      
      public static function getStability() : int // 获取稳定等级
      {
         return stability;
      }
      
      public static function getTaunt() : int // 获取嘲讽等级
      {
         return taunt;
      }
      
      public static function getRageInj() : int // 获取狂暴注射等级
      {
         return rageInjection;
      }
      
      public static function getNavigator() : int // 获取导航员等级
      {
         return navigator;
      }
      
      public static function getHacker() : int // 获取黑客等级
      {
         return hacker;
      }
      
      public static function getGuards() : int // 获取守卫等级
      {
         return guards;
      }
      
      public static function getArmorS() : int // 获取 S 型护甲等级
      {
         return armorS;
      }
      
      public static function getArmorM() : int // 获取 M 型护甲等级
      {
         return armorM;
      }
      
      public static function getArmorL() : int // 获取 L 型护甲等级
      {
         return armorL;
      }
      
      public static function getArmorX() : int // 获取 X 型护甲等级
      {
         return armorX;
      }
      
      public static function getGrab() : int // 获取抓取等级
      {
         return grab;
      }
      
      public static function getMerc() : int // 获取佣兵等级
      {
         return merc;
      }
      
      public static function getRecruits() : int // 获取招募等级
      {
         return recruits;
      }
      
      public static function getFinder() : int // 获取寻宝者等级
      {
         return finder;
      }
      
      public static function getSupply() : int // 获取补给等级
      {
         return supply;
      }
      
      public static function getElite() : int // 获取精英等级
      {
         return elite;
      }
      
      public static function getJump() : int // 获取跳跃等级
      {
         return jump;
      }
      
      public static function getTaran() : int // 获取冲撞等级
      {
         return taran;
      }
      
      public static function getThunder() : int // 获取雷电等级
      {
         return thunder;
      }
      
      public static function getBurst() : int // 获取爆发等级
      {
         return burst;
      }
      
      public static function getCharge() : int // 获取冲锋等级
      {
         return charge;
      }
      
      public static function getStamina() : int // 获取耐力等级
      {
         return stamina;
      }
      
      public static function setStamina(param1:int) : void // 设置耐力等级
      {
         stamina = param1; // 更新耐力等级
         if(GV.difficulty == 0) // 如果难度为0
         {
            GV.difficulty = 1; // 设置为1
         }
         var _loc2_:Number = 0.4 / GV.difficulty + 0.6; // 计算难度系数
         GV.playerHealthMax = GC.PLAYER_DEF_HEALTH + staminaHealth[stamina]; // 计算最大生命值
         GV.playerRegeneration = GC.PLAYER_DEF_REGENERATION + staminaRegeneration[stamina]; // 计算生命恢复速度
         GV.playerHealthMax *= _loc2_; // 应用难度系数
         GV.playerRegeneration *= _loc2_; // 应用难度系数
      }
      
      public static function getStaminaDesc(param1:int) : String // 获取耐力技能描述
      {
         var _loc2_:int = GC.PLAYER_DEF_HEALTH + staminaHealth[param1]; // 计算该等级下的最大生命值
         var _loc3_:int = GC.PLAYER_DEF_REGENERATION + staminaRegeneration[param1]; // 计算该等级下的生命恢复速度
         return Loc.formatText(Loc.ABILITY_STAMINA_DESC,_loc2_,_loc3_); // 格式化并返回描述文本
      }
      
      public static function setEngineering(param1:int) : void // 设置工程学等级
      {
         engineering = param1; // 更新工程学等级
      }
      
      public static function setMelee(param1:int) : void // 设置近战等级
      {
         melee = param1; // 更新近战等级
         if(melee > 0) // 如果近战等级大于0
         {
            if(meleeHandWeapon == null) // 如果徒手武器未初始化
            {
               meleeHandWeapon = PrototypeWeaponPlayer.HAND.createAndInit(); // 创建并初始化
            }
            meleeHandWeapon.setLevel(melee); // 设置徒手武器等级
         }
         if(melee > 1) // 如果近战等级大于1
         {
            if(meleeRoundWeapon == null) // 如果回旋武器未初始化
            {
               meleeRoundWeapon = PrototypeWeaponPlayer.HAND_ROUND.createAndInit(); // 创建并初始化
            }
            meleeRoundWeapon.setLevel(melee - 1); // 设置回旋武器等级
         }
         if(melee > 2) // 如果近战等级大于2
         {
            if(meleeKarateWeapon == null) // 如果空手道武器未初始化
            {
               meleeKarateWeapon = PrototypeWeaponPlayer.KARATE.createAndInit(); // 创建并初始化
            }
         }
      }
      
      public static function getMeleeDesc(param1:int) : String // 获取近战技能描述
      {
         var _loc3_:Number = NaN; // 局部变量，存储伤害值1
         var _loc4_:Number = NaN; // 局部变量，存储伤害值2
         var _loc2_:String = Loc.ABILITY_MELEE_DESC; // 获取基础描述
         if(param1 == 0) // 如果等级为0
         {
            param1 == 1; // 视为1级计算描述
         }
         if(param1 == 1) // 如果等级为1
         {
            _loc3_ = PrototypeWeaponPlayer.getLevelProto(PrototypeWeaponPlayer.HAND,1).damage; // 获取1级徒手伤害
            return _loc2_ + ("\n\n" + Loc.formatText(Loc.WPN_DAMAGE,_loc3_)); // 返回格式化后的描述
         }
         if(param1 == 2) // 如果等级为2
         {
            _loc3_ = PrototypeWeaponPlayer.getLevelProto(PrototypeWeaponPlayer.HAND,2).damage; // 获取2级徒手伤害
            _loc4_ = PrototypeWeaponPlayer.getLevelProto(PrototypeWeaponPlayer.HAND_ROUND,1).damage; // 获取1级回旋伤害
            return _loc2_ + ("\n\n" + Loc.formatText(Loc.WPN_DAMAGE,_loc3_.toString() + " - " + _loc4_.toString())); // 返回格式化后的描述
         }
         _loc3_ = PrototypeWeaponPlayer.getLevelProto(PrototypeWeaponPlayer.HAND,3).damage; // 获取3级徒手伤害
         _loc4_ = PrototypeWeaponPlayer.KARATE.damage; // 获取空手道伤害
         return _loc2_ + ("\n\n" + Loc.formatText(Loc.WPN_DAMAGE,_loc3_.toString() + " - " + _loc4_.toString())); // 返回格式化后的描述
      }
      
      public static function getMeleeWeapon() : Weapon // 获取当前可用的近战武器
      {
         switch(melee) // 根据近战等级
         {
            case 0: // 0级
            case 1: // 1级
               return meleeHandWeapon; // 返回徒手武器
            case 2: // 2级
               return AgeU.rand() > 0.5 ? meleeHandWeapon : meleeRoundWeapon; // 随机返回徒手或回旋武器
            case 3: // 3级
               return AgeU.randFrom(meleeHandWeapon,meleeRoundWeapon,meleeKarateWeapon); // 随机返回三种武器之一
            default: // 其他情况
               return meleeHandWeapon; // 返回徒手武器
         }
      }
      
      public static function setFling(param1:int) : void // 设置投掷等级
      {
         fling = param1; // 更新投掷等级
         var _loc2_:* = fling; // 局部变量
         switch(0) // switch 语句，但内容为空
         {
         }
         flingWeapon = null; // 清空投掷武器
      }
      
      public static function setRage(param1:int) : void // 设置狂暴等级
      {
         rage = param1; // 更新狂暴等级
         if(rage > 0) // 如果等级大于0
         {
            rageReload = 0; // 重置冷却
            if(rage > 1) // 如果等级大于1
            {
               abilities[numRage].active = true; // 设为主动技能
            }
            else // 否则
            {
               abilities[numRage].active = false; // 设为被动技能
            }
         }
      }
      
      public static function setStability(param1:int) : void // 设置稳定等级
      {
         stability = param1; // 更新稳定等级
         stabilityThrow = stabilityThrowValues[param1]; // 更新投掷加成
         stabilityArmor = stabilityArmorValues[param1]; // 更新护甲加成
      }
      
      public static function setTaunt(param1:int) : void // 设置嘲讽等级
      {
         taunt = param1; // 更新嘲讽等级
         if(taunt > 0) // 如果等级大于0
         {
            tauntReload = 0; // 重置冷却
         }
      }
      
      public static function setRageInj(param1:int) : void // 设置狂暴注射等级
      {
         rageInjection = param1; // 更新狂暴注射等级
         if(rageInjection > 0) // 如果等级大于0
         {
            rageInjReload = 0; // 重置冷却
            rageInjReloadTime = abilities[numRageInjection].reloadTime; // 设置冷却时间
         }
      }
      
      public static function setNavigator(param1:int) : void // 设置导航员等级
      {
         navigator = param1; // 更新导航员等级
      }
      
      public static function setGuards(param1:int) : void // 设置守卫等级
      {
         guards = param1; // 更新守卫等级
      }
      
      public static function setHacker(param1:int) : void // 设置黑客等级
      {
         hacker = param1; // 更新黑客等级
      }
      
      public static function getAgility() : int // 获取敏捷等级
      {
         return agility;
      }
      
      public static function setAgility(param1:int) : void // 设置敏捷等级
      {
         agilityOn = false; // 关闭敏捷状态
         agility = param1; // 更新敏捷等级
         agilityDecreaseSpeed = agilityValues.decSpeed[param1]; // 更新减速值
         agilityIncreaseSpeed = agilityValues.incSpeed[param1]; // 更新加速值
         agilitySpeedCoef = agilityValues.speedCoef[param1]; // 更新速度系数
      }
      
      public static function getAgilityDesc(param1:int) : String // 获取敏捷技能描述
      {
         var _loc2_:int = AgeMath.round(agilityValues.speed[param1] * 100 / agilityValues.speed[0] / 10) * 10; // 计算速度提升百分比
         var _loc3_:String = Key.name(Shortcut.keyCode(abilities[numAgility].shortcut)); // 获取快捷键名称
         var _loc4_:int = AgeMath.round((agilityValues.speedCoef[param1] * 100 + _loc2_ - 100) / 10) * 10; // 计算冲刺速度提升百分比
         return Loc.formatText(Loc.ABILITY_AGILITY_DESC,_loc3_,_loc2_,_loc4_); // 格式化并返回描述
      }
      
      public static function setArmorS(param1:int) : void // 设置 S 型护甲等级
      {
         armorS = param1; // 更新等级
         var _loc2_:Object = abilities[numArmorS]; // 获取护甲对象
         if(param1 > 0 && curArmor == null) // 如果升级且当前无护甲
         {
            curArmor = abilities[numArmorS]; // 装备该护甲
         }
      }
      
      public static function setArmorM(param1:int) : void // 设置 M 型护甲等级
      {
         armorM = param1; // 更新等级
         if(param1 > 0 && curArmor == null) // 如果升级且当前无护甲
         {
            curArmor = abilities[numArmorM]; // 装备该护甲
         }
      }
      
      public static function setArmorL(param1:int) : void // 设置 L 型护甲等级
      {
         armorL = param1; // 更新等级
         if(param1 > 0 && curArmor == null) // 如果升级且当前无护甲
         {
            curArmor = abilities[numArmorL]; // 装备该护甲
         }
      }
      
      public static function setArmorX(param1:int) : void // 设置 X 型护甲等级
      {
         armorX = 0; // 先重置为0
         armorX = param1; // 更新等级
         if(param1 > 0 && curArmor == null) // 如果升级且当前无护甲
         {
            curArmor = abilities[numArmorX]; // 装备该护甲
         }
      }
      
      public static function setGrab(param1:int) : void // 设置抓取等级
      {
         grab = param1; // 更新等级
      }
      
      public static function setMerc(param1:int) : void // 设置佣兵等级
      {
         merc = param1; // 更新等级
      }
      
      public static function setJump(param1:int) : void // 设置跳跃等级
      {
         jump = param1; // 更新等级
         if(jump == 0) // 如果等级为0
         {
            jumpWeapon = null; // 清空跳跃武器
         }
         else // 否则
         {
            jumpWeapon = PrototypeWeaponPlayer.getLevelProto(PrototypeWeaponPlayer.JUMP,jump).createAndInit(); // 创建对应等级的跳跃武器
         }
      }
      
      public static function setRecruits(param1:int) : void // 设置招募等级
      {
         recruits = param1; // 更新等级
      }
      
      public static function setSupply(param1:int) : void // 设置补给等级
      {
         supply = param1; // 更新等级
      }
      
      public static function setElite(param1:int) : void // 设置精英等级
      {
         elite = param1; // 更新等级
      }
      
      public static function setFinder(param1:int) : void // 设置寻宝者等级
      {
         finder = param1; // 更新等级
      }
      
      public static function setThunder(param1:int) : void // 设置雷电等级
      {
         thunder = param1; // 更新等级
         if(thunder) // 如果等级大于0
         {
            thunderWeapon = PrototypeWeaponPlayer.THUNDER.createAndInit(); // 创建雷电武器
            thunderDamageCoef = thunderDamageCoefValues[thunder]; // 设置伤害系数
         }
      }
      
      public static function setTaran(param1:int) : void // 设置冲撞等级
      {
         taran = param1; // 更新等级
         if(taran == 0) // 如果等级为0
         {
            taranWeapon = null; // 清空冲撞武器
         }
         else // 否则
         {
            taranWeapon = PrototypeWeaponPlayer.getLevelProto(PrototypeWeaponPlayer.TARAN,taran).createAndInit(); // 创建对应等级的冲撞武器
         }
         taranEnemyCount = taranEnemyCountValues[param1]; // 设置影响的敌人数量
      }
      
      public static function setBurst(param1:int) : void // 设置爆发等级
      {
         burst = 0; // 直接设为0，可能此技能未实现或已废弃
      }
      
      public static function setCharge(param1:int) : void // 设置冲锋等级
      {
         charge = param1; // 更新等级
         chargePower = chargePowerValues[param1]; // 更新威力
         chargeDist = chargeDistValues[param1]; // 更新距离
      }
      
      public static function getRageDesc(param1:int) : String // 获取狂暴技能描述
      {
         var _loc2_:String = Loc.ABILITY_RAGE_DESC[0]; // 获取基础描述
         if(param1 >= 2) // 如果等级大于等于2
         {
            _loc2_ += Loc.ABILITY_RAGE_DESC[1]; // 添加额外描述
         }
         if(param1 == 3) // 如果等级为3
         {
            _loc2_ += Loc.ABILITY_RAGE_DESC[2]; // 添加额外描述
         }
         return Loc.formatText2(_loc2_,["%shortcut",Key.name(Shortcut.keyCode(Shortcut.ABILITY_RAGE))],["%cooldown",rageReloadTime]); // 格式化并返回
      }
      
      public static function getBurstDesc(param1:int) : String // 获取爆发技能描述
      {
         return Loc.formatText(Loc.ABILITY_BURST_DESC,burstPowerValues[param1] + 1); // 格式化并返回
      }
      
      public static function getChargeDesc(param1:int) : String // 获取冲锋技能描述
      {
         return Loc.formatText(Loc.ABILITY_CHARGE_DESC,int(chargePowerValues[param1] * 100 - 100),chargeDistValues[param1]); // 格式化并返回
      }
      
      public static function getStabilityDesc(param1:int) : String // 获取稳定技能描述
      {
         return Loc.formatText(Loc.ABILITY_STABILITY_DESC + (param1 == 3 ? Loc.ABILITY_STABILITY_DESC2 : ""),stabilityArmorValues[param1] * 100,stabilityThrowValues[param1] * 100); // 格式化并返回
      }
      
      public static function getNavigatorDesc(param1:int) : String // 获取导航员技能描述
      {
         return Loc.ABILITY_NAVIGATOR_DESC1 + Loc.ABILITY_NAVIGATOR_DESC2[param1 - 1] + Loc.formatText(Loc.ABILITY_NAVIGATOR_DESC3,Key.name(Shortcut.keyCode(Shortcut.ABILITY_NAVIGATOR))); // 拼接、格式化并返回
      }
      
      public static function getEngineeringDesc(param1:int) : String // 获取工程学技能描述
      {
         return Loc.formatText(Loc.ABILITY_ENGINEERING_DESC,Loc.ABILITY_ENGINEERING[param1 - 1]) + Loc.formatText(Loc.ABILITY_ENGINEERING_REQ[param1 - 1]); // 拼接、格式化并返回
      }
      
      public static function getThunderDesc(param1:int) : String // 获取雷电技能描述
      {
         return Loc.formatText(Loc.ABILITY_THUNDER_DESC,thunderDamageCoefValues[param1] * 100 - 100); // 格式化并返回
      }
      
      public static function getHackerDesc(param1:int) : String // 获取黑客技能描述
      {
         return Loc.formatText(Loc.ABILITY_HACKER_DESC,param1,param1); // 格式化并返回
      }
      
      public static function getRecruitsDesc(param1:int) : String // 获取招募技能描述
      {
         return Loc.formatText(Loc.ABILITY_RECRUITS_DESC,recruitsCount[param1]); // 格式化并返回
      }
      
      public static function getSupplyDesc(param1:int) : String // 获取补给技能描述
      {
         return Loc.formatText(Loc.ABILITY_SUPPLY_DESC,param1 * 10,param1 * 15); // 格式化并返回
      }
      
      public static function getJumpDesc(param1:int) : String // 获取跳跃技能描述
      {
         var _loc2_:AgePrototype = PrototypeWeaponPlayer.getLevelProto(PrototypeWeaponPlayer.JUMP,param1); // 获取跳跃武器原型
         return Loc.formatText(Loc.ABILITY_JUMP_DESC,_loc2_.damage,_loc2_.cooldown); // 格式化并返回
      }
      
      public static function getTaranDesc(param1:int) : String // 获取冲撞技能描述
      {
         var _loc2_:AgePrototype = PrototypeWeaponPlayer.getLevelProto(PrototypeWeaponPlayer.TARAN,param1); // 获取冲撞武器原型
         return Loc.formatText(Loc.ABILITY_TARAN_DESC,_loc2_.damage,taranEnemyCountValues[param1]); // 格式化并返回
      }
      
      public static function getGrabDesc(param1:int) : String // 获取抓取技能描述
      {
         var _loc2_:Object = abilities[numGrab]; // 获取抓取技能对象
         var _loc3_:int = grabChanceExp * grabExp / 10; // 计算经验带来的成功率加成
         var _loc4_:* = grabChance[param1].toString() + "%"; // 基础成功率
         var _loc5_:String = ""; // 经验加成文本
         if(_loc3_ > 0) // 如果有经验加成
         {
            _loc5_ = Loc.formatText(Loc.FONT_EXP," +" + _loc3_ + "%"); // 格式化加成文本
         }
         return Loc.formatText(Loc.ABILITY_GRAB_DESC,_loc4_,_loc5_); // 格式化并返回最终描述
      }
      
      public static function getArmorSDesc(param1:int) : String // 获取 S 型护甲描述
      {
         var _loc2_:Object = abilities[numArmorS]; // 获取护甲对象
         return armorDesc(_loc2_,param1,Loc.ABILITY_ARMOR_DESC_S); // 调用通用护甲描述函数
      }
      
      public static function getArmorMDesc(param1:int) : String // 获取 M 型护甲描述
      {
         var _loc2_:Object = abilities[numArmorM]; // 获取护甲对象
         return armorDesc(_loc2_,param1,Loc.ABILITY_ARMOR_DESC_M); // 调用通用护甲描述函数
      }
      
      public static function getArmorLDesc(param1:int) : String // 获取 L 型护甲描述
      {
         var _loc2_:Object = abilities[numArmorL]; // 获取护甲对象
         return armorDesc(_loc2_,param1,Loc.ABILITY_ARMOR_DESC_L); // 调用通用护甲描述函数
      }
      
      public static function getArmorXDesc(param1:int) : String // 获取 X 型护甲描述
      {
         var _loc2_:Object = abilities[numArmorX]; // 获取护甲对象
         return armorDesc(_loc2_,param1,Loc.ABILITY_ARMOR_DESC_X); // 调用通用护甲描述函数
      }
      
      protected static function armorDesc(param1:Object, param2:int, param3:String) : String // 通用护甲描述函数
      {
         var _loc4_:* = "" + int(param1.safe[param2] * 100) + "%"; // 基础减伤百分比
         if(int(100 * param1.expSafe * param1.exp / 10) > 0) // 如果有经验减伤加成
         {
            _loc4_ += Loc.formatText(Loc.FONT_EXP,"+" + int(100 * param1.expSafe * param1.exp / 10).toString() + "%"); // 添加经验加成文本
         }
         var _loc5_:* = (param1.speedCoef > 1 ? "+" : "-") + AgeMath.abs(int(param1.speedCoef * 100 - 100)) + "%"; // 速度影响百分比
         return param3 + "\n\n" + Loc.formatText(Loc.ABILITY_ARMOR_DESC,_loc4_,_loc5_); // 格式化并返回最终描述
      }
      
      public static function get armorAnimSymbol() : Class // 获取护甲动画符号
      {
         if(curArmor && curArmor.getValue() > 0) // 如果有护甲且等级大于0
         {
            return curArmor.animSymbols[curArmor.getValue() - 1]; // 返回对应等级的动画符号
         }
         return GS.HERO_UNARMORED; // 否则返回无甲动画符号
      }
      
      public static function onPlayerInit() : void // 玩家初始化时调用
      {
      }
      
      public static function createCompanions(param1:Trigger) : void // 创建同伴
      {
         var _loc2_:AgePrototype = null; // 局部变量，原型
         var _loc3_:int = 0; // 局部变量，x坐标
         var _loc4_:int = 0; // 局部变量，y坐标
         var _loc5_:UnitEnemy = null; // 局部变量，抓取的敌人单位
         var _loc6_:int = 0; // 局部变量，循环计数器
         var _loc7_:UnitMercenary = null; // 局部变量，招募的单位
         if(grab > 0 && grabUnitProto) // 如果有抓取技能且有抓取单位
         {
            _loc2_ = AgePrototype.getByName(grabUnitProto); // 获取原型
            if(_loc2_) // 如果原型存在
            {
               _loc3_ = AgeU.rand(param1.boundBox.x,param1.boundBox.x + param1.boundBox.width); // 随机x坐标
               _loc4_ = AgeU.rand(param1.boundBox.y,param1.boundBox.y + param1.boundBox.height); // 随机y坐标
               if(_loc5_ = _loc2_.createAndInit({ // 创建并初始化单位
                  "isPet":true, // 设为宠物
                  "x":_loc3_,
                  "y":_loc4_
               }) as UnitEnemy)
               {
                  GV.gameStatePlay.addEntity(_loc5_); // 添加到游戏场景
                  grabUnit = _loc5_; // 设为当前抓取单位
                  Age.dispatchEvent(GameEvent.ON_GRAB); // 派发抓取事件
               }
            }
         }
         if(GV.recruits.length > 0) // 如果有招募的单位
         {
            if(GV.recruitUnits == null) // 如果招募单位向量未初始化
            {
               GV.recruitUnits = new Vector.<Unit>(); // 初始化
            }
            else // 否则
            {
               GV.recruitUnits.length = 0; // 清空
            }
            for each(_loc6_ in GV.recruits) // 遍历招募列表
            {
               if(PlayerAbility.elite > 0) // 如果有精英技能
               {
                  _loc2_ = PrototypeNPC.RECRUITS_UP[_loc6_]; // 使用升级后的原型
               }
               else // 否则
               {
                  _loc2_ = PrototypeNPC.RECRUITS[_loc6_]; // 使用普通原型
               }
               _loc3_ = AgeU.rand(param1.boundBox.x,param1.boundBox.x + param1.boundBox.width); // 随机x坐标
               _loc4_ = AgeU.rand(param1.boundBox.y,param1.boundBox.y + param1.boundBox.height); // 随机y坐标
               if(_loc7_ = _loc2_.createAndInit({ // 创建并初始化单位
                  "x":_loc3_,
                  "y":_loc4_,
                  "health":_loc2_.healths[PlayerAbility.supply] // 根据补给等级设置生命值
               }) as UnitMercenary)
               {
                  GV.gameStatePlay.addEntity(_loc7_); // 添加到游戏场景
                  GV.recruitUnits.push(_loc7_); // 添加到招募单位向量
                  _loc7_.weapon.setLevel(PlayerAbility.supply); // 根据补给等级设置武器等级
               }
            }
            GV.gameInterface.addMercs(); // 在游戏界面上添加佣兵显示
         }
         if(merc > 0) // 如果有佣兵技能
         {
         }
      }
      
      public static function onPlayerHaveDamage(param1:Number) : void // 玩家受到伤害时调用
      {
         if(curArmor) // 如果有护甲
         {
            curArmor.lvlExp += param1 / 1000; // 增加护甲经验
         }
      }
      
      public static function onLevelBegin() : void // 关卡开始时调用
      {
         agilityOn = false; // 关闭敏捷状态
         if(curArmor) // 如果有护甲
         {
            curArmor.lvlExp = 0; // 重置本关获得的护甲经验
         }
      }
      
      public static function onLevelEnd() : void // 关卡结束时调用
      {
      }
      
      public static function onLevelComplete() : void // 关卡完成时调用
      {
         if(curArmor) // 如果有护甲
         {
            curArmor.exp += curArmor.lvlExp; // 将本关经验加到总经验
            if(curArmor.exp > 10) // 如果超过上限
            {
               curArmor.exp = 10; // 设为上限
            }
         }
         if(grabUnit) // 如果有抓取单位
         {
            if(!grabUnit.isAlive) // 如果单位已死亡
            {
               grabUnit = null; // 清空
               grabUnitProto = null; // 清空原型
            }
         }
      }
      
      public static function onLevelLose() : void // 关卡失败时调用
      {
      }
      
      public static function makeGrab(param1:UnitEnemy) : Boolean // 执行抓取
      {
         grabWeapon = null; // 清空抓取武器
         if(grab == 0) // 如果没有抓取技能
         {
            return false; // 返回 false
         }
         if(grabExp < (param1.prototype.level - 6) / 250 * 5) // 如果经验不足
         {
            View.showHelpText(Loc.HELP_GRAB_NEED_EXP,2); // 显示提示
            return false; // 返回 false
         }
         if(param1.prototype.poisonImmune) // 如果目标免疫毒
         {
            View.showHelpText(Loc.HELP_POISON_IMMUNE,3); // 显示提示
            return false; // 返回 false
         }
         var _loc2_:Number = 1 - param1.prototype.level / 200; // 计算等级惩罚系数
         if(AgeU.rand(0,100) < (grabChance[grab] + grabExp * grabChanceExp / 10) * _loc2_) // 计算成功率并判定
         {
            if(grabUnit && grabUnit.isAlive) // 如果已有抓取单位且存活
            {
               if(param1.prototype.level > grabUnit.prototype.level) // 如果新目标等级更高
               {
                  grabUnit = param1; // 替换
                  grabUnitProto = param1.prototype.name; // 替换原型
               }
            }
            else // 如果没有抓取单位
            {
               grabUnit = param1; // 设为新目标
               grabUnitProto = param1.prototype.name; // 记录原型
            }
            param1.turnOnPet(); // 将目标变为宠物
            if(grab > 1) // 如果抓取等级大于1
            {
               param1.health += param1.maxHealth / 2; // 恢复一半生命
            }
            grabExp += AgeU.rand(0.1,0.3) / _loc2_; // 增加抓取经验
            if(Age.debug) // 如果是调试模式
            {
               grabExp += Debug.getVar("exp",1.3); // 额外增加经验
            }
            param1.onGrabbed(); // 调用目标的被抓取处理函数
            View.showHelpText(Loc.HELP_GRAB_DONE,2); // 显示成功提示
            Age.dispatchEvent(GameEvent.ON_GRAB); // 派发抓取事件
            return true; // 返回 true
         }
         View.showHelpText(Loc.HELP_GRAB_FAILED,2); // 显示失败提示
         grabExp += AgeU.rand(0.1,0.3) / _loc2_; // 增加少量经验
         return false; // 返回 false
      }
      
      public static function getGrabUnitIcon() : int // 获取抓取单位的图标
      {
         if(!grabUnitProto) // 如果没有抓取单位
         {
            return 0; // 返回0
         }
         var _loc1_:AgePrototype = AgePrototype.getByName(grabUnitProto); // 获取原型
         if(_loc1_ && _loc1_.icon) // 如果原型和图标存在
         {
            return _loc1_.icon; // 返回图标
         }
         return 1; // 否则返回1
      }
      
      public static function getGrabUnitTitle() : String // 获取抓取单位的标题
      {
         if(!grabUnitProto) // 如果没有抓取单位
         {
            return ""; // 返回空字符串
         }
         var _loc1_:AgePrototype = AgePrototype.getByName(grabUnitProto); // 获取原型
         if(_loc1_ && _loc1_.title) // 如果原型和标题存在
         {
            return _loc1_.title; // 返回标题
         }
         return ""; // 否则返回空字符串
      }
      
      public static function turnRageOn() : void // 开启狂暴
      {
         if(meleeHandWeapon) // 如果有徒手武器
         {
            meleeHandWeapon.turnOnRage(); // 开启武器狂暴状态
         }
         if(meleeRoundWeapon) // 如果有回旋武器
         {
            meleeRoundWeapon.turnOnRage(); // 开启武器狂暴状态
         }
         if(meleeKarateWeapon) // 如果有空手道武器
         {
            meleeKarateWeapon.turnOnRage(); // 开启武器狂暴状态
         }
      }
      
      public static function turnRageOff() : void // 关闭狂暴
      {
         if(meleeHandWeapon) // 如果有徒手武器
         {
            meleeHandWeapon.turnOffRage(); // 关闭武器狂暴状态
         }
         if(meleeRoundWeapon) // 如果有回旋武器
         {
            meleeRoundWeapon.turnOffRage(); // 关闭武器狂暴状态
         }
         if(meleeKarateWeapon) // 如果有空手道武器
         {
            meleeKarateWeapon.turnOffRage(); // 关闭武器狂暴状态
         }
      }
      
      public static function showAbilityIcon(param1:MovieClip) : void // 在UI上显示可升级技能图标
      {
         var _loc4_:Object = null; // 局部变量，技能对象
         param1.upgradeAbility.visible = false; // 默认隐藏升级提示
         var _loc2_:Object = lastAbility; // 获取上一个升级的技能
         var _loc3_:int = 0; // 循环计数器
         while(_loc3_ < abilities.length) // 遍历所有技能
         {
            if((_loc4_ = abilities[_loc3_]) && PlayerInventory.isPlaceForNewItem && _loc4_.cost[_loc4_.getValue() + 1] && GV.money > _loc4_.cost[_loc4_.getValue() + 1]) // 如果技能可升级且金钱足够
            {
               _loc2_ = _loc4_; // 记录该技能
               param1.upgradeAbility.visible = true; // 显示升级提示
               break; // 退出循环
            }
            _loc3_++; // 计数器加一
         }
         if(_loc2_) // 如果有可升级的技能
         {
            View.setPic(param1.iconAbility,GS.ICON_ABILITY,_loc2_.icon + (_loc2_.getValue() == 0 ? 0 : _loc2_.getValue() - 1)); // 设置图标
         }
      }
      
      public static function checkCells() : void // 检查并更新技能快捷栏
      {
         var _loc1_:Object = null; // 局部变量，技能对象
         for each(_loc1_ in abilities) // 遍历所有技能
         {
            if(_loc1_) // 如果技能存在
            {
               if(_loc1_.getValue() > 0 && _loc1_.active) // 如果技能已学习且是主动技能
               {
                  if(cells.indexOf(_loc1_) == -1) // 如果不在快捷栏中
                  {
                     cells.push(_loc1_); // 添加到快捷栏
                  }
               }
               else if(cells.indexOf(_loc1_) != -1) // 如果技能不满足条件但在快捷栏中
               {
                  AgeU.removeFromArray(cells,_loc1_); // 从快捷栏移除
               }
            }
         }
      }
      
      public static function getAbilityCellNum(param1:int) : int // 获取技能在快捷栏中的位置
      {
         var _loc2_:int = 0; // 循环计数器
         while(_loc2_ < cells.length) // 遍历快捷栏
         {
            if(cells[_loc2_].num == param1) // 如果找到对应技能
            {
               return _loc2_; // 返回位置索引
            }
            _loc2_++; // 计数器加一
         }
         return -1; // 未找到则返回-1
      }
      
      public static function debugSetAllAbilities(param1:int) : void // 调试函数：设置所有技能等级
      {
         var _loc3_:Object = null; // 局部变量，技能对象
         var _loc2_:int = 0; // 循环计数器
         while(_loc2_ < abilities.length) // 遍历所有技能
         {
            _loc3_ = abilities[_loc2_]; // 获取技能对象
            if(_loc3_) // 如果技能存在
            {
               if(_loc3_.cost.length - 1 < param1) // 如果目标等级超过最大等级
               {
                  setAbility(_loc2_,_loc3_.cost.length - 1,true); // 设置为最大等级
               }
               else // 否则
               {
                  setAbility(_loc2_,param1,true); // 设置为目标等级
               }
            }
            _loc2_++; // 计数器加一
         }
         checkCells(); // 检查并更新快捷栏
      }
      
      public static function get abilitiesHaveCount() : int // 获取已学习的技能数量
      {
         var _loc1_:int = 0; // 计数器
         var _loc2_:int = 0; // 循环计数器
         while(_loc2_ < abilities.length) // 遍历所有技能
         {
            if(abilities[_loc2_] && abilities[_loc2_].getValue() > 0) // 如果技能已学习
            {
               _loc1_++; // 计数器加一
            }
            _loc2_++; // 循环计数器加一
         }
         return _loc1_; // 返回数量
      }
      
      public static function get abilitiesSum() : int // 获取所有技能等级之和
      {
         var _loc1_:int = 0; // 总和
         var _loc2_:int = 0; // 循环计数器
         while(_loc2_ < abilities.length) // 遍历所有技能
         {
            if(abilities[_loc2_]) // 如果技能存在
            {
               _loc1_ += abilities[_loc2_].getValue(); // 累加等级
            }
            _loc2_++; // 循环计数器加一
         }
         return _loc1_; // 返回总和
      }
      
      public static function get abilitiesSumMax() : int // 获取所有技能最大等级之和
      {
         var _loc1_:int = 0; // 总和
         var _loc2_:int = 0; // 循环计数器
         while(_loc2_ < abilities.length) // 遍历所有技能
         {
            if(abilities[_loc2_]) // 如果技能存在
            {
               _loc1_ += abilities[_loc2_].cost.length - 1; // 累加最大等级
            }
            _loc2_++; // 循环计数器加一
         }
         return _loc1_; // 返回总和
      }
      
      public static function get availableAbilitiesPercent() : int // 获取技能学习完成度百分比
      {
         return abilitiesSum / abilitiesSumMax * 100; // 计算并返回百分比
      }
   }
}

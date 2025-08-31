package
{
   import age.utils.Key;
   import flash.geom.Point;
   
   /**
    * GC (Game Constants) 类
    * 存储游戏中使用的所有静态常量。
    */
   public class GC
   {
      
      // --- 平台和广告 ---
      /** @private 是否为Spil Games平台版本 */
      public static const SPIL:Boolean = false;
      /** @private Cpmstar广告ID - 预加载广告 */
      public static const CPMSTAR_PREROLL:String = "13052Q217807AB";
      /** @private Cpmstar广告ID - 关卡间广告 */
      public static const CPMSTAR_INTERLEVEL:String = "13053Q7AC5E94C";
      
      // --- 基础常量 ---
      /** @private 零点坐标 (0,0) */
      public static const POINT_ZERO:Point = new Point(0,0);
      
      // --- 玩家和宠物属性 ---
      /** @private 玩家默认生命值 */
      public static const PLAYER_DEF_HEALTH:Number = 15000;
      /** @private 玩家默认生命恢复速度 */
      public static const PLAYER_DEF_REGENERATION:Number = 6;
      /** @private 宠物生命恢复速度 */
      public static const PET_REGENERATION:Number = 50;
      
      // --- 行为/动作ID ---
      public static const ACTION_RECON:int = 0;                  // 侦察
      public static const ACTION_CLEANUP:int = 1;                // 清理
      public static const ACTION_ASSAULT:int = 2;                // 攻击
      public static const ACTION_TOWER_CAPTURE:int = 3;          // 占领塔
      public static const ACTION_TOWER_UPGRADE:int = 4;          // 升级塔
      public static const ACTION_FACTORY_CAPTURE:int = 8;        // 占领工厂
      public static const ACTION_FACTORY_UPGRADE:int = 9;        // 升级工厂
      public static const ACTION_FIRST:int = 10;                 // 第一个动作
      public static const ACTION_WALK:int = 11;                  // 行走
      public static const ACTION_TURN:int = 12;                  // 转向
      public static const ACTION_DEFEND:int = 15;                // 防御
      public static const ACTION_OUTSIDE_1:int = 16;             // 外部动作1
      public static const ACTION_TAVERN_UPGRADE:int = 17;        // 升级酒馆
      public static const ACTION_OUTSIDE_2:int = 18;             // 外部动作2
      public static const ACTION_WALKTHROUGH:int = 19;           // 穿过
      public static const ACTION_TAVERN_CAPTURE:int = 20;        // 占领酒馆
      public static const ACTION_RESERVE:int = 21;               // 保留/预备
      public static const ACTION_SIEGE:int = 22;                 // 围攻
      public static const ACTION_MAX:int = 22;                   // 最大动作ID
      public static const ACTION_EDITOR:int = 23;                // 编辑器动作
      
      // --- 图层深度 ---
      public static const LAYER_ROOT:int = 0;                    // 根图层
      public static const LAYER_BG:int = 1;                      // 背景图层
      public static const LAYER_FIELD:int = 2;                   // 场地/战场图层
      public static const LAYER_ENVIRONMENT:int = 3;             // 环境图层
      public static const LAYER_EFFECT:int = 4;                  // 特效图层
      public static const LAYER_GUI:int = 5;                     // GUI图层 (用户界面)
      public static const LAYER_CURSOR:int = 6;                  // 光标图层
      
      // --- 排列/布局 ---
      public static const ARRANGE_TOP:int = 1;                   // 顶部
      public static const ARRANGE_MIDDLE:int = 2;                // 中部
      public static const ARRANGE_BOTTOM:int = 3;                // 底部
      public static const ARRANGE_UNDER_ALL:int = 4;             // 所有之下
      
      // --- 非玩家角色 (NPC) 类型 ---
      public static const NP_ENEMY:int = 1;                      // 敌人
      public static const NP_ENEMY_TROLL:int = 2;                // 敌人 - 巨魔
      public static const NP_ALLY:int = 3;                       // 盟友
      public static const NP_LOOT:int = 4;                       // 战利品
      public static const NP_SECRET:int = 5;                     // 秘密/隐藏物品
      public static const NP_CHEST:int = 6;                      // 箱子
      public static const NP_TRIGGER:int = 7;                    // 触发器
      public static const NP_BUILDING:int = 8;                   // 建筑
      public static const NP_MAIN_HERO:int = 9;                  // 主英雄
      
      // --- 武器类型 ---
      public static const WPN_PISTOL:int = 0;                    // 手枪
      public static const WPN_SHOTGUN:int = 1;                   // 霰弹枪
      public static const WPN_MACHINEGUN:int = 2;                // 机枪
      public static const WPN_RIFLE:int = 3;                     // 步枪
      public static const WPN_MINIGUN:int = 4;                   // 加特林机枪
      public static const WPN_RPG:int = 5;                       // 火箭筒
      public static const WPN_GRENADE:int = 6;                   // 手榴弹
      public static const WPN_MINE:int = 7;                      // 地雷
      public static const WPN_ROKS:int = 8;                      // ROKS (可能是某种特定武器)
      public static const WPN_KNIFE:int = 9;                     // 刀
      public static const WPN_SHIELD:int = 10;                   // 盾牌
      public static const WPN_BOW:int = 11;                      // 弓
      public static const WPN_AXE:int = 12;                      // 斧
      public static const WPN_LONGSWORD:int = 13;                // 长剑
      public static const WPN_LONGAXE:int = 14;                  // 长柄斧
      public static const WPN_CROSSBOW:int = 15;                 // 弩
      public static const WPN_MACE:int = 16;                     // 钉头锤
      public static const WPN_TRAP:int = 17;                     // 陷阱
      public static const WPN_SWORD:int = 18;                    // 剑
      public static const WPN_ARMOR_SWORD:int = 19;              // 盔甲剑 (可能是重剑)
      
      // --- 实体分组/阵营 (使用位掩码进行物理和逻辑分组) ---
      public static const ALL:uint = -1;                         // 所有
      public static const GRP_ANY:uint = 1 << 1;                 // 任何组
      public static const GRP_PLAYER:uint = 1 << 2;              // 玩家组
      public static const GRP_ALLY:uint = 1 << 3;                // 盟友组
      public static const GRP_AGAINST_ALL:uint = 1 << 4;         // 与所有为敌组
      public static const GRP_ENEMY:uint = 1 << 5;               // 敌方组
      public static const GRP_MUTANT:uint = 1 << 6;              // 变种人组
      public static const GRP_ZOMBIE:uint = 1 << 7;              // 僵尸组
      public static const GRP_ENVIRONMENT:uint = 1 << 8;         // 环境组 (如可破坏的桶)
      public static const GRP_SHELL:uint = 1 << 9;               // 炮弹/子弹组
      public static const GRP_OBSTACLE:uint = 1 << 10;           // 障碍物组
      public static const GRP_CORPSE:uint = 1 << 11;             // 尸体组
      public static const GRP_BASE:uint = 1 << 12;               // 基地组
      public static const GRP_MINE:uint = 1 << 13;               // 地雷组
      public static const GRP_TROLL_THROW:uint = 1 << 14;        // 巨魔投掷物组
      public static const GRP_UNIT_THROW:uint = 1 << 15;         // 单位投掷物组
      public static const GRP_PLAYER_SHOOT_EXCEPT:uint = 1 << 16; // 玩家射击排除组 (射击时忽略这些组)
      public static const GRP_TROLL:uint = 1 << 17;              // 巨魔组
      public static const GRP_WOLF:uint = 1 << 18;               // 狼组
      public static const GRP_SHELL_EXCEPT:uint = 1 << 19;       // 炮弹/子弹排除组
      public static const GRP_CURSOR_FAKE_ENEMY:uint = 1 << 20;  // 光标下的假想敌组 (用于AI判断)
      public static const GRP_DRILL_TARGET:uint = 1 << 21;       // 钻探目标组
      
      /** @private 阵营组 (变种人, 僵尸, 盟友的集合) */
      public static const GRP_SIDE:uint = GRP_MUTANT | GRP_ZOMBIE | GRP_ALLY;
      /** @private 攻击时排除盟友的组 (攻击目标不包括盟友、玩家、炮弹等) */
      public static const GRP_ATTACK_EXCEPT_ALLY:uint = GC.GRP_ALLY | GC.GRP_PLAYER | GC.GRP_SHELL | GC.GRP_UNIT_THROW | GC.GRP_MINE;
      
      // --- 单位专精/职业 ---
      public static const SPEC_SOLDIER:int = 1;                  // 士兵
      public static const SPEC_CAPTAIN:int = 2;                  // 队长
      public static const SPEC_RANGER:int = 3;                   // 游侠
      public static const SPEC_ENGINEER:int = 4;                 // 工程师
      public static const SPEC_BUILDER:int = 5;                  // 建造者
      public static const SPEC_CITIZEN:int = 6;                  // 平民
      public static const SPEC_QUESTER:int = 7;                  // 任务发布者
      
      /** @private 所有专精的数组 */
      public static const SPEC_ALL:Array = [SPEC_SOLDIER,SPEC_CAPTAIN,SPEC_RANGER,SPEC_ENGINEER,SPEC_BUILDER,SPEC_CITIZEN];
      /** @private 平民类专精 */
      public static const SPEC_CIVIL:Array = [SPEC_CITIZEN,SPEC_BUILDER,SPEC_ENGINEER];
      /** @private 战斗类专精 */
      public static const SPEC_WAR:Array = [SPEC_SOLDIER,SPEC_RANGER,SPEC_CAPTAIN];
      
      /** @private 每个酒馆可容纳的专精单位数量 */
      public static const SPEC_PER_TAVERN:int = 4;
      /** @private 每个商店的物资数量 */
      public static const MATERIAL_PER_STORE:int = 30;
      
      /** @private 可招募单位的信息 (专精和维护费) */
      public static const RECRUITS:Array = [{
         "spec":SPEC_SOLDIER,
         "upkeep":100
      },{
         "spec":SPEC_RANGER,
         "upkeep":100
      },{
         "spec":SPEC_CAPTAIN,
         "upkeep":150
      }];
      
      // --- 实体状态/属性 (使用位掩码) ---
      public static const COLLIDE_TRIGGER:uint = 1 << 4;         // 触发器
      public static const COLLIDE_ENTITY:uint = 1 << 5;          // 实体
      public static const COLLIDE_BG:uint = 1 << 6;              // 背景
      public static const DAMAGABLE:uint = 1 << 7;               // 可被伤害
      public static const DEAD:uint = 1 << 8;                    // 已死亡
      public static const IMPASSABLE:uint = 1 << 9;              // 不可通过
      public static const UNIT_TEST:uint = 1 << 12;              // 测试单位
      public static const UNIT_NEST:uint = 1 << 13;              // 巢穴单位
      public static const SEPARATABLE:uint = 1 << 18;            // 可分离 (用于避免单位重叠)
      public static const ON_SCREEN:uint = 1 << 19;              // 在屏幕上
      public static const NEAR_SCREEN:uint = 1 << 20;            // 在屏幕附近
      public static const PLAYER:uint = 1 << 21;                 // 玩家
      public static const UNIT_BOSS:uint = 1 << 25;              // BOSS单位
      public static const DIST_TO_PLAYER:uint = 1 << 26;         // 到玩家的距离 (可能是一个标志位)
      public static const FALL:uint = 1 << 27;                   // 坠落
      public static const DEAD_OR_FALL:uint = DEAD | FALL;       // 死亡或坠落
      public static const UNIT_IN_RAGE:uint = 1 << 28;           // 单位处于狂暴状态
      public static const WAS_SEPARATED:uint = 1 << 29;          // 已被分离过
      
      // --- 游戏逻辑和奖励 ---
      /** @private 对玩家构成威胁的单位组 */
      public static const PLAYER_THREAT_UNITS_1:uint = GRP_ENEMY;
      /** @private 威胁距离 */
      public static const PLAYER_THREAT_DIST:Number = 200;
      /** @private 狂暴值上限 (根据不同等级或情况) */
      public static const RAGE_MAX:Array = [0,200,400,400,500,900,100000];
      /** @private 狂暴值下降时间 */
      public static const RAGE_DOWN_TIME:Number = 6;
      /** @private 狂暴持续时间 */
      public static const RAGE_TIME:Number = 6;
      /** @private 敌人奖励迭代器 (可能用于计算奖励) */
      public static const ENEMY_REWARD_ITERATOR:Number = 8;
      /** @private 侦察商店的奖励 */
      public static const REWARD_RECON_STORE:Number = 200;
      /** @private 工厂工人的奖励 */
      public static const REWARD_FACTORY_WORKER:Number = 100;
      /** @private 救援平民的奖励 */
      public static const REWARD_CIVILIAN_RESCUE:Number = 100;
      /** @private 大师数量 */
      public static const MASTERS_COUNT:Number = 6;
      /** @private 箱子奖励 (根据不同等级) */
      public static const REWARD_CHEST:Array = [150,200,300,500];
      /** @private 守门任务的奖励 */
      public static const REWARD_TASK_KEEP_GATE:Array = [100,1500];
      /** @private 物资奖励 */
      public static const REWARD_MATERIAL:Array = [4,6,7,9,11,13,15,15,15];
      /** @private 仓库奖励 */
      public static const REWARD_STOREHOUSE:Array = [300,500,800,1200,1700,2000,2300,2600,3000];
      
      // --- 分数计算 ---
      public static const SCORE_ENRAGE:Number = 1000;            // 激怒得分
      public static const SCORE_LEVEL_COMPLETE:Number = 2;       // 关卡完成得分
      public static const SCORE_ABILITY:Number = 1;              // 技能得分
      public static const SCORE_WEAPON:Number = 1;               // 武器得分
      
      // --- 键盘映射到图标 ---
      /** @private 用于在UI上显示按键对应的图标 */
      public static const KEY_ICON:Array = [];
      
      // 静态初始化块, 设置键盘码和图标索引的映射关系
      {
         KEY_ICON[Key.DIGIT_1] = 1;
         KEY_ICON[Key.DIGIT_2] = 2;
         KEY_ICON[Key.DIGIT_3] = 3;
         KEY_ICON[Key.DIGIT_4] = 4;
         KEY_ICON[Key.DIGIT_5] = 5;
         KEY_ICON[Key.DIGIT_6] = 6;
         KEY_ICON[Key.DIGIT_7] = 7;
         KEY_ICON[Key.DIGIT_8] = 8;
         KEY_ICON[Key.DIGIT_9] = 9;
         KEY_ICON[Key.DIGIT_0] = 10;
         KEY_ICON[Key.Q] = 11;
         KEY_ICON[Key.W] = 12;
         KEY_ICON[Key.E] = 13;
         KEY_ICON[Key.R] = 14;
         KEY_ICON[Key.T] = 15;
         KEY_ICON[Key.I] = 16;
         KEY_ICON[Key.A] = 17;
         KEY_ICON[Key.S] = 18;
         KEY_ICON[Key.D] = 19;
         KEY_ICON[Key.F] = 20;
         KEY_ICON[Key.G] = 21;
         KEY_ICON[Key.H] = 22;
         KEY_ICON[Key.Z] = 23;
         KEY_ICON[Key.X] = 24;
         KEY_ICON[Key.C] = 25;
         KEY_ICON[Key.V] = 26;
         KEY_ICON[Key.B] = 27;
         KEY_ICON[Key.N] = 28;
         KEY_ICON[Key.M] = 29;
         KEY_ICON[Key.SPACE] = 30;
         KEY_ICON[Key.SHIFT] = 31;
      }
      
      /**
       * 构造函数
       */
      public function GC()
      {
         super();
      }
   }
}

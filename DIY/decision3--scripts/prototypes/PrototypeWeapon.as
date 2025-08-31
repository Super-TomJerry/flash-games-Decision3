// 定义一个包，用于存放原型类
package prototypes
{
   // 导入所需的类
   import age.AgeMask; // 导入 AgeMask 类，用于定义掩码类型
   import age.AgePrototype; // 导入 AgePrototype 类，用于创建原型对象
   import game.Shortcut; // 导入 Shortcut 类，用于定义快捷键
   import game.Tower; // 导入 Tower 类，用于防御塔
   import game.Weapon; // 导入 Weapon 类，作为武器的基类
   import game.WeaponPlayer; // 导入 WeaponPlayer 类，用于玩家武器
   import game.WeaponWithCursor; // 导入 WeaponWithCursor 类，用于带光标的武器
   import graphics.Frames; // 导入 Frames 类，用于定义动画帧
   import units.EntityShell; // 导入 EntityShell 类，用于炮弹实体
   import units.EntityShellFling; // 导入 EntityShellFling 类，用于投掷物实体
   import units.EntityShellGrenade; // 导入 EntityShellGrenade 类，用于手榴弹实体
   import units.EntityShellItem; // 导入 EntityShellItem 类，用于物品实体
   import units.EntityShellMine; // 导入 EntityShellMine 类，用于地雷实体
   import units.EntitySplash; // 导入 EntitySplash 类，用于溅射效果实体
   
   // 定义一个公共类，用于存放武器的原型
   public class PrototypeWeapon
   {
      
      // 定义一个公共静态常量数组，表示子弹击中环境的声音
      public static const SND_BULLET_HIT_ENV:Array = [Snd_Bullet_Wall1,Snd_Bullet_Wall2,Snd_Bullet_Wall3,Snd_Bullet_Wall4,Snd_Ricochet];
      
      // 定义一个公共静态常量，表示僵尸近战的原型
      public static const ZOMBIE_MELEE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MELEE, // 武器类型
         "animSet":Frames.SET_ZOMBIE_MELEE, // 动画集
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "distance":30, // 攻击距离
         "throwOffForce":10, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndAttack":[Snd_Zombie_Hit1,Snd_Zombie_Hit2,Snd_Zombie_Hit3,Snd_Zombie_Hit4,Snd_Zombie_Hit5], // 攻击声音
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[10,20,40], // 伤害值
            "cooldown":[3,2,1.5], // 冷却时间
            "throwChance":[0.1,0.3,0.4] // 投掷几率
         }
      });
      
      // 定义一个公共静态常量，表示僵尸煤气罐爆炸的原型
      public static const ZOMBIE_GAS_CAN_BLOW:AgePrototype = new AgePrototype({
         "name":"PrototypeWeapon.ZOMBIE_GAS_CAN_BLOW", // 名称
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BLOW, // 武器类型
         "screenShake":[1,4], // 屏幕震动
         "groundMark":[25,36], // 地面标记
         "signShadow":true, // 是否有阴影
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "effectBlow":EFire_Blow_M_01, // 爆炸效果
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "distance":20, // 攻击距离
         "hitRadius":70, // 命中半径
         "damageDist":70, // 伤害距离
         "damage":100, // 伤害值
         "profit":0, // 收益
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "blowup":true, // 是否爆炸
         "sndHit":Snd_Blow_1 // 命中声音
      });
      
      // 定义一个公共静态常量，表示单手武器的原型
      public static const WPN_1HAND:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "animSet":Frames.SET_1HAND, // 动画集
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":10, // 命中半径
         "distance":20, // 攻击距离
         "throwOffForce":15, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndAttack":[Snd_Zombie_Hit1,Snd_Zombie_Hit2,Snd_Zombie_Hit3,Snd_Zombie_Hit4,Snd_Zombie_Hit5], // 攻击声音
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[15,25,50], // 伤害值
            "cooldown":[2,1.7,1.5], // 冷却时间
            "throwChance":[0.1,0.3,0.4] // 投掷几率
         }
      });
      
      // 定义一个公共静态常量，表示弓的原型
      public static const BOW:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BOW, // 武器类型
         "animSet":Frames.SET_BOW, // 动画集
         "shell":EntityShellFling.ARROW, // 炮弹
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":10, // 命中半径
         "minDistance":80, // 最小攻击距离
         "throwChance":0.1, // 投掷几率
         "throwOffForce":10, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndAttack":Snd_Bow1, // 攻击声音
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[15,20,30], // 伤害值
            "cooldown":[2.3,1.9,1.7], // 冷却时间
            "distance":[300,400,500] // 攻击距离
         }
      });
      
      // 定义一个公共静态常量，表示NPC近战的原型
      public static const NPC_MELEE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MELEE, // 武器类型
         "animSet":Frames.SET_NPC_MELEE, // 动画集
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":10, // 命中半径
         "damage":5, // 伤害值
         "distance":50, // 攻击距离
         "cooldown":1.5, // 冷却时间
         "throwOffForce":7, // 投掷力
         "throwOffFade":25, // 投掷衰减
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[3,10,20], // 伤害值
            "cooldown":[2,1.5,1.3] // 冷却时间
         }
      });
      
      // 定义一个公共静态常量，表示手枪的原型
      public static const PISTOL:AgePrototype = new AgePrototype({
         "name":"PISTOL", // 名称
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_PISTOL, // 武器类型
         "animSet":Frames.SET_PISTOL, // 动画集
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "distance":250, // 攻击距离
         "minDistance":100, // 最小攻击距离
         "dispersion":6, // 散射
         "shootPoint":[4,-26], // 射击点
         "waitForAnimation":false, // 是否等待动画
         "headshot":true, // 是否可以爆头
         "cooldown":0.5, // 冷却时间
         "clip":10, // 弹夹容量
         "reload":4, // 装弹时间
         "reactChance":0.3, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":3, // 投掷力
         "sndFire":Snd_Pistol_S, // 开火声音
         "sndEnv":SND_BULLET_HIT_ENV, // 环境声音
         "sndReload":Snd_Pistol_Reload, // 装弹声音
         "levelVars":{"damage":[5,10,20,30,40]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示霰弹枪的原型
      public static const SHOTGUN:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_SHOTGUN, // 武器类型
         "animSet":Frames.SET_GUN, // 动画集
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "distance":250, // 攻击距离
         "minDistance":100, // 最小攻击距离
         "dispersion":60, // 散射
         "shootPoint":[9,-38], // 射击点
         "bulletQuantity":3, // 子弹数量
         "cooldown":0.4, // 冷却时间
         "clip":2, // 弹夹容量
         "reload":3, // 装弹时间
         "headshot":true, // 是否可以爆头
         "reactChance":0.3, // 反应几率
         "throwChance":0.3, // 投掷几率
         "throwOffForce":20, // 投掷力
         "sndAttack":Snd_Shotgun, // 攻击声音
         "sndEnv":SND_BULLET_HIT_ENV, // 环境声音
         "sndReload":Snd_Rifle_Reload, // 装弹声音
         "levelVars":{"damage":[3,5,10,15]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示MP5的原型
      public static const MP5:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "animSet":Frames.SET_RIFLE, // 动画集
         "bulletSymbol":E_Bullet_2, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "effectOnGroundChance":0.5, // 地面效果几率
         "shootPoint":[8,-28], // 射击点
         "waitForAnimation":false, // 是否等待动画
         "type":Weapon.TYPE_MACHINEGUN, // 武器类型
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "distance":300, // 攻击距离
         "minDistance":150, // 最小攻击距离
         "dispersion":6, // 散射
         "cooldown":0.15, // 冷却时间
         "clip":15, // 弹夹容量
         "reload":4, // 装弹时间
         "reactChance":0.2, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":8, // 投掷力
         "headshot":true, // 是否可以爆头
         "sndFire":Snd_Pistol_S, // 开火声音
         "sndEnv":SND_BULLET_HIT_ENV, // 环境声音
         "sndReload":Snd_Rifle_Reload, // 装弹声音
         "levelVars":{"damage":[5,10,20]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示AK47的原型
      public static const AK47:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "animSet":Frames.SET_GUN, // 动画集
         "bulletSymbol":E_Bullet_2, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "effectOnGroundChance":0.5, // 地面效果几率
         "shootPoint":[10,-30], // 射击点
         "waitForAnimation":false, // 是否等待动画
         "type":Weapon.TYPE_RIFLE, // 武器类型
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "minDistance":150, // 最小攻击距离
         "dispersion":6, // 散射
         "cooldown":0.3, // 冷却时间
         "clip":20, // 弹夹容量
         "reload":4, // 装弹时间
         "reactChance":0.2, // 反应几率
         "throwChance":0.3, // 投掷几率
         "throwOffForce":17, // 投掷力
         "headshot":true, // 是否可以爆头
         "sndFire":Snd_AK47, // 开火声音
         "sndEnv":SND_BULLET_HIT_ENV, // 环境声音
         "sndReload":Snd_Rifle_Reload, // 装弹声音
         "levelVars":{ // 等级变量
            "damage":[15,20,30], // 伤害值
            "distance":[350,450,500] // 攻击距离
         }
      });
      
      // 定义一个公共静态常量，表示步枪的原型
      public static const RIFLE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "animSet":Frames.SET_RIFLE, // 动画集
         "bulletSymbol":E_Bullet_3, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_M, // 地面效果
         "shootPoint":[2,-62], // 射击点
         "waitForAnimation":false, // 是否等待动画
         "type":Weapon.TYPE_RIFLE, // 武器类型
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "minDistance":150, // 最小攻击距离
         "dispersion":6, // 散射
         "cooldown":1, // 冷却时间
         "clip":8, // 弹夹容量
         "reload":2, // 装弹时间
         "reactChance":0.5, // 反应几率
         "throwChance":0.3, // 投掷几率
         "throwOffForce":8, // 投掷力
         "headshot":true, // 是否可以爆头
         "sndFire":Snd_Rifle_M, // 开火声音
         "sndEnv":SND_BULLET_HIT_ENV, // 环境声音
         "sndReload":Snd_Rifle_Reload, // 装弹声音
         "levelVars":{ // 等级变量
            "damage":[15,25,35], // 伤害值
            "distance":[400,500,600] // 攻击距离
         }
      });
      
      // 定义一个公共静态常量，表示RPG的原型
      public static const RPG:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_RPG, // 武器类型
         "animSet":Frames.SET_BAZOOKA, // 动画集
         "animSymbol":GS.WPN_BAZOOKA, // 动画符号
         "screenShake":[2,6], // 屏幕震动
         "groundMark":[25,36], // 地面标记
         "shell":EntityShell.ROCKET_ENEMY, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":100, // 命中半径
         "distance":350, // 攻击距离
         "minDistance":100, // 最小攻击距离
         "shootPoint":[10,-30], // 射击点
         "dispersion":20, // 散射
         "reload":4, // 装弹时间
         "clip":1, // 弹夹容量
         "waitForAnimation":true, // 是否等待动画
         "reactChance":1, // 反应几率
         "throwChance":0.9, // 投掷几率
         "throwOffForce":25, // 投掷力
         "shotFromOwner":false, // 是否从拥有者处射击
         "noKickBack":false, // 是否无后坐力
         "gory":false, // 是否血腥
         "blowup":true, // 是否爆炸
         "speedCoef":0.6, // 速度系数
         "sndAttack":Snd_Rocket, // 攻击声音
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[20,40,60], // 伤害值
            "effectOnGround":[ESmoke_Blow_01_S,ESmoke_Blow_01_M,ESmoke_Blow_01_L], // 地面效果
            "blowSymbol":[EFire_Blow_S_01,EFire_Blow_M_01,EFire_Blow_L_01], // 爆炸符号
            "blowSideSymbol":[EFire_SideBlow_S,EFire_SideBlow_M,EFire_SideBlow_L] // 侧面爆炸符号
         }
      });
      
      // 定义一个公共静态常量，表示手榴弹的原型
      public static const GRENADE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_GRENADE, // 武器类型
         "screenShake":[2,10], // 屏幕震动
         "blowup":true, // 是否爆炸
         "shell":EntityShell.PINAPLE, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "damageDistToTarget":200, // 对目标的伤害距离
         "reload":3, // 装弹时间
         "clip":1, // 弹夹容量
         "dispersion":20, // 散射
         "minDistance":100, // 最小攻击距离
         "distance":600, // 攻击距离
         "signShadow":true, // 是否有阴影
         "reactChance":1, // 反应几率
         "throwChance":2, // 投掷几率
         "throwOffForce":25, // 投掷力
         "sndFire":Snd_Throw, // 开火声音
         "sndBlow":Snd_Blow_2, // 爆炸声音
         "sndAttack":Snd_Zombie_Hit3, // 攻击声音
         "sndTake":Snd_Take, // 拾取声音
         "noKickBack":true, // 是否无后坐力
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "blowSymbol":[EFire_Blow_S_01,EFire_Blow_M_01,EFire_CircleBlow_M], // 爆炸符号
            "damage":[20,40,60], // 伤害值
            "hitRadius":[100,130,150] // 命中半径
         }
      });
      
      // 定义一个公共静态常量，表示狼人的原型
      public static const WEREWOLF:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":15, // 命中半径
         "damage":20, // 伤害值
         "distance":50, // 攻击距离
         "cooldown":1.9, // 冷却时间
         "throwChance":0.4, // 投掷几率
         "throwOffForce":14, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndAttack":[Snd_Wolf_Hit_01,Snd_Wolf_Hit_02,Snd_Wolf_Hit_03], // 攻击声音
         "levelCount":2, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[20,50], // 伤害值
            "cooldown":[1.9,1.7] // 冷却时间
         }
      });
      
      // 定义一个公共静态常量，表示狼人跳跃攻击的原型
      public static const WEREWOLF_JUMP:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BLOW, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "screenShake":[3,6], // 屏幕震动
         "groundMark":[19,24], // 地面标记
         "hitRadius":40, // 命中半径
         "clip":1, // 弹夹容量
         "reload":5, // 装弹时间
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "effectOnGround":ESmoke_Blow_01_M, // 地面效果
         "throwChance":0.7, // 投掷几率
         "throwOffForce":17, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndHit":Snd_Wolf_Jump, // 命中声音
         "debugDraw":false, // 是否调试绘制
         "levelCount":2, // 等级数量
         "levelVars":{"damage":[50,100]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示巨魔手榴弹的原型
      public static const TROLL_GRENADE:AgePrototype = AgePrototype.createCopy(GRENADE,{
         "shell":EntityShell.MK2, // 炮弹
         "reload":6, // 装弹时间
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[70,130,200], // 伤害值
            "reload":[7,6,5] // 装弹时间
         }
      });
      
      // 定义一个公共静态常量，表示巨魔跳跃攻击的原型
      public static const TROLL_JUMP:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BLOW, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "screenShake":[4,8], // 屏幕震动
         "groundMark":[37,44], // 地面标记
         "clip":1, // 弹夹容量
         "reload":9, // 装弹时间
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "effectOnGround":ESmoke_Blow_01_L, // 地面效果
         "effectSplash":EntitySplash.GROUND_BLOW_M, // 溅射效果
         "throwChance":2, // 投掷几率
         "throwOffForce":35, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndHit":Snd_Boss_Earthquake, // 命中声音
         "debugDraw":true, // 是否调试绘制
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[60,100,150], // 伤害值
            "hitRadius":[110,150,180] // 命中半径
         }
      });
      
      // 定义一个公共静态常量，表示巨魔地雷的原型
      public static const TROLL_MINE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_LAUNCHER, // 武器类型
         "screenShake":[1,7], // 屏幕震动
         "blowSymbol":EFire_Blow_L_01, // 爆炸符号
         "reload":5, // 装弹时间
         "clip":1, // 弹夹容量
         "shell":EntityShellMine.TOWER_MINE, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_ALL, // 掩码类型
         "hitRadius":50, // 命中半径
         "distance":900, // 攻击距离
         "damage":200, // 伤害值
         "dispersion":7, // 散射
         "minDistance":300, // 最小攻击距离
         "blowup":true, // 是否爆炸
         "reactChance":1, // 反应几率
         "throwChance":2, // 投掷几率
         "throwOffForce":25, // 投掷力
         "profit":1, // 收益
         "distSoundFade":2500, // 声音衰减距离
         "sndFire":Snd_Throw, // 开火声音
         "sndBlow":Snd_Blow_1 // 爆炸声音
      });
      
      // 定义一个公共静态常量，表示Boss近战的原型
      public static const BOSS_MELEE:AgePrototype = AgePrototype.createCopy(ZOMBIE_MELEE,{
         "hitRadius":50, // 命中半径
         "damage":90, // 伤害值
         "cooldown":2.3, // 冷却时间
         "throwOffFade":25, // 投掷衰减
         "throwOffDist":300, // 投掷距离
         "sndAttack":[Snd_Boss_Hit1,Snd_Boss_Hit2,Snd_Boss_Hit3], // 攻击声音
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[90,100,150], // 伤害值
            "cooldown":[2.3,2,1.5], // 冷却时间
            "distance":[40,50,60], // 攻击距离
            "reactChance":[1,2,3], // 反应几率
            "throwChance":[0.8,1.5,2], // 投掷几率
            "throwOffForce":[25,30,35] // 投掷力
         }
      });
      
      // 定义一个公共静态常量，表示Boss脚步的原型
      public static const BOSS_STEP:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "screenShake":[1,2], // 屏幕震动
         "groundMark":[19,24], // 地面标记
         "hitRadius":30, // 命中半径
         "distance":10, // 攻击距离
         "mute":true, // 是否静音
         "blowup":true, // 是否爆炸
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "throwOffForce":12, // 投掷力
         "throwOffFade":25, // 投掷衰减
         "levelCount":3, // 等级数量
         "levelVars":{"damage":[20,30,50]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示Boss冲刺脚步的原型
      public static const BOSS_STEP_SPRINT:AgePrototype = AgePrototype.createCopy(BOSS_STEP,{
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":60, // 命中半径
         "throwChance":3, // 投掷几率
         "throwOffForce":30 // 投掷力
      });
      
      // 定义一个公共静态常量，表示Boss地震的原型
      public static const BOSS_QUAKE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_ALL, // 掩码类型
         "screenShake":[4,8], // 屏幕震动
         "groundMark":[37,42], // 地面标记
         "effectOnGround":ESmoke_Blow_01_L, // 地面效果
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "hitRadius":250, // 命中半径
         "damageDist":400, // 伤害距离
         "damage":80, // 伤害值
         "clip":1, // 弹夹容量
         "reload":15, // 装弹时间
         "throwChance":0.5, // 投掷几率
         "throwOffForce":40, // 投掷力
         "throwOffFade":17, // 投掷衰减
         "throwOffDist":500, // 投掷距离
         "sndFire":Snd_Boss_Earthquake // 开火声音
      });
      
      // 定义一个公共静态常量，表示Boss木桶的原型
      public static const BOSS_BARREL:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_LAUNCHER, // 武器类型
         "screenShake":[2,6], // 屏幕震动
         "signShadow":true, // 是否有阴影
         "shell":EntityShell.BARREL, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":50, // 命中半径
         "damage":50, // 伤害值
         "cooldown":3, // 冷却时间
         "throwOffForce":10, // 投掷力
         "throwOffFade":25, // 投掷衰减
         "distance":150, // 攻击距离
         "sndFire":Snd_Throw, // 开火声音
         "sndBlow":Snd_Blow_1 // 爆炸声音
      });
      
      // 定义一个公共静态常量，表示僵尸狗的原型
      public static const ZOMBIE_DOG:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":15, // 命中半径
         "damage":17, // 伤害值
         "distance":50, // 攻击距离
         "cooldown":1.5, // 冷却时间
         "throwOffForce":10, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndAttack":[Snd_Dog_Hit1,Snd_Dog_Hit2,Snd_Dog_Hit3], // 攻击声音
         "levelCount":2, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[20,50], // 伤害值
            "cooldown":[1.5,1.2] // 冷却时间
         }
      });
      
      // 定义一个公共静态常量，表示僵尸手榴弹的原型
      public static const ZOMBIE_GRENADE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_LAUNCHER, // 武器类型
         "screenShake":[2,6], // 屏幕震动
         "shell":EntityShell.PINAPLE, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":50, // 命中半径
         "damage":50, // 伤害值
         "cooldown":3, // 冷却时间
         "throwOffForce":10, // 投掷力
         "throwOffFade":25, // 投掷衰减
         "distance":120, // 攻击距离
         "sndFire":Snd_Throw, // 开火声音
         "sndBlow":Snd_Blow_1 // 爆炸声音
      });
      
      // 定义一个公共静态常量，表示僵尸毒气的原型
      public static const ZOMBIE_GAS:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BLOW, // 武器类型
         "groundMark":[52,57], // 地面标记
         "screenShake":[4,8], // 屏幕震动
         "signShadow":true, // 是否有阴影
         "effectBlow":EFire_Blow_L_01, // 爆炸效果
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":120, // 命中半径
         "damageDist":180, // 伤害距离
         "damage":200, // 伤害值
         "blowup":true, // 是否爆炸
         "throwOffForce":15, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndBlow":Snd_Blow_2 // 爆炸声音
      });
      
      // 定义一个公共静态常量，表示新兵手枪的原型
      public static const RECRUIT_PISTOL:AgePrototype = AgePrototype.createCopy(PISTOL,{"levelVars":{
         "damage":[5,15,20], // 伤害值
         "distance":[350,400,450] // 攻击距离
      }});
      
      // 定义一个公共静态常量，表示新兵霰弹枪的原型
      public static const RECRUIT_SHOTGUN:AgePrototype = AgePrototype.createCopy(SHOTGUN,{"levelVars":{
         "damage":[3,5,7,10], // 伤害值
         "distance":[350,400,450] // 攻击距离
      }});
      
      // 定义一个公共静态常量，表示新兵MP5的原型
      public static const RECRUIT_MP5:AgePrototype = AgePrototype.createCopy(MP5,{"levelVars":{
         "damage":[5,15,25,35], // 伤害值
         "distance":[350,400,450] // 攻击距离
      }});
      
      // 定义一个公共静态常量，表示新兵步枪的原型
      public static const RECRUIT_RIFLE:AgePrototype = AgePrototype.createCopy(RIFLE,{"levelVars":{
         "damage":[10,20,30,40], // 伤害值
         "distance":[400,450,500] // 攻击距离
      }});
      
      // 定义一个公共静态常量，表示新兵迷你机枪的原型
      public static const RECRUIT_MINIGUN:AgePrototype = new AgePrototype({
         "name":"MINIGUN", // 名称
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MINIGUN, // 武器类型
         "animSet":Frames.SET_GUN, // 动画集
         "animSymbol":GS.WPN_BROWNING, // 动画符号
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "effectOnGroundChance":0.3, // 地面效果几率
         "shootPoint":[10,-30], // 射击点
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":5, // 命中半径
         "minDistance":5, // 最小攻击距离
         "dispersion":30, // 散射
         "cooldown":0.1, // 冷却时间
         "waitForAnimation":false, // 是否等待动画
         "clip":100, // 弹夹容量
         "reload":5, // 装弹时间
         "profit":0.6, // 收益
         "reactChance":0.3, // 反应几率
         "throwChance":0.01, // 投掷几率
         "throwOffForce":8, // 投掷力
         "headshot":true, // 是否可以爆头
         "speedCoef":0.8, // 速度系数
         "shotFromOwner":true, // 是否从拥有者处射击
         "noKickBack":true, // 是否无后坐力
         "sndAttack":Snd_Minigun, // 攻击声音
         "sndTake":Snd_Take, // 拾取声音
         "sndReload":Snd_Rifle_Reload, // 装弹声音
         "sndReloaded":Snd_Wpn_Ready, // 装弹完成声音
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[5,15,30], // 伤害值
            "distance":[400,450,500] // 攻击距离
         }
      });
      
      // 定义一个公共静态常量，表示升级版新兵霰弹枪的原型
      public static const RECRUIT_SHOTGUN_UP:AgePrototype = AgePrototype.createCopy(RECRUIT_SHOTGUN,{
         "distance":400, // 攻击距离
         "levelVars":{ // 等级变量
            "damage":[6,10,14,20], // 伤害值
            "distance":[400,450,450] // 攻击距离
         }
      });
      
      // 定义一个公共静态常量，表示升级版新兵手枪的原型
      public static const RECRUIT_PISTOL_UP:AgePrototype = AgePrototype.createCopy(PISTOL,{
         "distance":400, // 攻击距离
         "reload":2, // 装弹时间
         "levelVars":{ // 等级变量
            "damage":[20,35,50], // 伤害值
            "distance":[400,450,450] // 攻击距离
         }
      });
      
      // 定义一个公共静态常量，表示升级版新兵RPG的原型
      public static const RECRUIT_RPG_UP:AgePrototype = AgePrototype.createCopy(RPG,{
         "dispersion":5, // 散射
         "reload":3, // 装弹时间
         "distance":450, // 攻击距离
         "levelVars":{"damage":[30,50,80]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示守卫1手枪的原型
      public static const GUARD_1_PISTOL:AgePrototype = AgePrototype.createCopy(PISTOL,{
         "reactChance":0.1, // 反应几率
         "levelVars":{"damage":[7,18,25]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示守卫2 AK47的原型
      public static const GUARD_2_AK47:AgePrototype = AgePrototype.createCopy(AK47,{
         "reactChance":0.05, // 反应几率
         "levelVars":{"damage":[8,18,25]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示守卫3步枪的原型
      public static const GUARD_3_RIFLE:AgePrototype = AgePrototype.createCopy(RIFLE,{
         "reactChance":0.2, // 反应几率
         "levelVars":{"damage":[10,20,30]} // 等级变量
      });
      
      // 定义一个公共静态常量，表示砖块的原型
      public static const BRICK:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_LAUNCHER, // 武器类型
         "shell":EntityShellItem.BRICK, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "damage":40, // 伤害值
         "cooldown":1, // 冷却时间
         "distance":400 // 攻击距离
      });
      
      // 定义一个公共静态常量，表示石块的原型
      public static const ROCK:AgePrototype = AgePrototype.createCopy(BRICK,{"shell":EntityShellItem.ROCK});
      
      // 定义一个公共静态常量，表示木块的原型
      public static const WOOD:AgePrototype = AgePrototype.createCopy(BRICK,{"shell":EntityShellItem.WOOD});
      
      // 定义一个公共静态常量，表示轮子的原型
      public static const WHEEL:AgePrototype = AgePrototype.createCopy(BRICK,{
         "shell":EntityShellItem.WHEEL, // 炮弹
         "effectOnGround":ESmoke_Blow_01_M, // 地面效果
         "damage":60 // 伤害值
      });
      
      // 定义一个公共静态常量，表示木材的原型
      public static const LUMBER:AgePrototype = AgePrototype.createCopy(BRICK,{
         "shell":EntityShellItem.LUMBER, // 炮弹
         "effectOnGround":ESmoke_Blow_01_M, // 地面效果
         "sndBlow":Snd_Blow_Wood_M, // 爆炸声音
         "damage":80 // 伤害值
      });
      
      // 定义一个公共静态常量，表示地雷爆炸的原型
      public static const MINE_BLOW:AgePrototype = new AgePrototype({
         "name":"PrototypeWeapon.MINE_BLOW", // 名称
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MINE, // 武器类型
         "screenShake":[1,4], // 屏幕震动
         "groundMark":[25,36], // 地面标记
         "signShadow":false, // 是否有阴影
         "blowup":true, // 是否爆炸
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":100, // 命中半径
         "damageDist":100, // 伤害距离
         "profit":0.5, // 收益
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "reactChance":1, // 反应几率
         "throwChance":2, // 投掷几率
         "throwOffForce":25, // 投掷力
         "levelCount":4, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[100,200,400,800], // 伤害值
            "effectOnGround":[ESmoke_Blow_01_S,ESmoke_Blow_01_M], // 地面效果
            "effectBlow":[EFire_Blow_S_01,EFire_Blow_M_01] // 爆炸效果
         }
      });
      
      // 定义一个公共静态常量，表示玩家地雷爆炸的原型
      public static const PLAYER_MINE_BLOW:AgePrototype = new AgePrototype({
         "name":"PrototypeWeapon.PLAYER_MINE_BLOW", // 名称
         "objClass":WeaponPlayer, // 对象类
         "frame":GS.FRAME_WPN[GC.WPN_MINE], // 帧
         "type":Weapon.TYPE_MINE, // 武器类型
         "screenShake":[1,4], // 屏幕震动
         "groundMark":[25,36], // 地面标记
         "signShadow":false, // 是否有阴影
         "blowup":true, // 是否爆炸
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":100, // 命中半径
         "damageDist":100, // 伤害距离
         "profit":0.5, // 收益
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "effectOnGround":[ESmoke_Blow_01_S,null,null,ESmoke_Blow_01_M,null,null,ESmoke_Blow_01_L], // 地面效果
            "effectBlow":[EFire_Blow_S_01,null,null,EFire_Blow_M_01,null,null,EFire_Blow_L_01] // 爆炸效果
         }
      });
      
      // 定义一个公共静态常量，表示木桶爆炸的原型
      public static const BARREL_BLOW:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BLOW, // 武器类型
         "groundMark":[52,57], // 地面标记
         "screenShake":[4,8], // 屏幕震动
         "signShadow":true, // 是否有阴影
         "effectBlow":EFire_Blow_L_01, // 爆炸效果
         "groundFire":3, // 地面火焰
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "profit":0.6, // 收益
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":100, // 命中半径
         "damageDist":100, // 伤害距离
         "damage":100, // 伤害值
         "blowup":true, // 是否爆炸
         "throwChance":1, // 投掷几率
         "throwOffForce":15, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "sndBlow":Snd_Blow_2 // 爆炸声音
      });
      
      // 定义一个公共静态常量，表示箱子炮弹的原型
      public static const BOX_SHELL:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_LAUNCHER, // 武器类型
         "shell":EntityShellItem.BOX, // 炮弹
         "effectOnGround":ESmoke_Blow_01_L, // 地面效果
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "profit":0.6, // 收益
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":30, // 命中半径
         "damageDist":50, // 伤害距离
         "damage":50, // 伤害值
         "throwChance":0.6, // 投掷几率
         "throwOffForce":15, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "distance":600, // 攻击距离
         "sndBlow":Snd_Blow_Wood_M // 爆炸声音
      });
      
      // 定义一个公共静态常量，表示木桶炮弹的原型
      public static const BARREL_SHELL:AgePrototype = AgePrototype.createCopy(BARREL_BLOW,{
         "type":Weapon.TYPE_LAUNCHER, // 武器类型
         "shell":EntityShellItem.BARREL, // 炮弹
         "distance":600 // 攻击距离
      });
      
      // 定义一个公共静态常量，表示大木桶爆炸的原型
      public static const BARREL_BIG_BLOW:AgePrototype = AgePrototype.createCopy(BARREL_BLOW,{
         "screenShake":[9,14], // 屏幕震动
         "hitRadius":260, // 命中半径
         "damageDist":300, // 伤害距离
         "damage":600, // 伤害值
         "profit":0.6, // 收益
         "throwChance":2, // 投掷几率
         "throwOffForce":14, // 投掷力
         "throwOffFade":23, // 投掷衰减
         "groundFire":7 // 地面火焰
      });
      
      // 定义一个公共静态常量，表示瞭望塔爆炸的原型
      public static const WATCHTOWER_BLOW:AgePrototype = AgePrototype.createCopy(BARREL_BLOW,{
         "effectBlow":ESmoke_Blow_01_L, // 爆炸效果
         "groundFire":null, // 地面火焰
         "groundMark":[61,63], // 地面标记
         "damageDist":200, // 伤害距离
         "throwChance":2, // 投掷几率
         "throwOffForce":16 // 投掷力
      });
      
      // 定义一个公共静态常量，表示塔楼士兵的原型
      public static const TOWER_SOLDIER:AgePrototype = new AgePrototype({
         "objClass":WeaponWithCursor, // 对象类
         "type":Weapon.TYPE_MACHINEGUN, // 武器类型
         "bulletSymbol":E_Bullet_2, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "effectOnGroundChance":0.5, // 地面效果几率
         "shootPoint":[2,-62], // 射击点
         "blowup":false, // 是否爆炸
         "damage":60, // 伤害值
         "profit":0.3, // 收益
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":20, // 命中半径
         "distance":1100, // 攻击距离
         "minDistance":50, // 最小攻击距离
         "dispersion":6, // 散射
         "cooldown":0.7, // 冷却时间
         "clip":8, // 弹夹容量
         "reload":1.5, // 装弹时间
         "reactChance":0.5, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":8, // 投掷力
         "distSoundFade":2500, // 声音衰减距离
         "sndFires":[Snd_Rifle_S,Snd_Rifle_M], // 开火声音
         "sndEnv":SND_BULLET_HIT_ENV // 环境声音
      });
      
      // 定义一个公共静态常量，表示塔楼迷你机枪的原型
      public static const TOWER_MINIGUN:AgePrototype = new AgePrototype({
         "objClass":WeaponWithCursor, // 对象类
         "type":Weapon.TYPE_MACHINEGUN, // 武器类型
         "symbol":GS.NEST_MINIGUN, // 符号
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "effectOnGroundChance":0.3, // 地面效果几率
         "shootPoint":[0,-40], // 射击点
         "blowup":false, // 是否爆炸
         "damage":15, // 伤害值
         "profit":0.3, // 收益
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":20, // 命中半径
         "distance":4000, // 攻击距离
         "minDistance":150, // 最小攻击距离
         "dispersion":15, // 散射
         "cooldown":0.1, // 冷却时间
         "reactChance":0.5, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":8, // 投掷力
         "distSoundFade":2500, // 声音衰减距离
         "sndFire":Snd_Minigun, // 开火声音
         "sndEnv":SND_BULLET_HIT_ENV // 环境声音
      });
      
      // 定义一个公共静态常量，表示塔楼机枪的原型
      public static const TOWER_GUN:AgePrototype = new AgePrototype({
         "objClass":WeaponWithCursor, // 对象类
         "type":Weapon.TYPE_MACHINEGUN, // 武器类型
         "symbol":GS.NEST_GUN, // 符号
         "bulletSymbol":E_Bullet_4, // 子弹符号
         "effectBlow":EFire_Blow_S_01, // 爆炸效果
         "groundMark":[25,30], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "shootPoint":[0,-40], // 射击点
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "blowup":true, // 是否爆炸
         "damage":90, // 伤害值
         "profit":0.3, // 收益
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":30, // 命中半径
         "distance":4000, // 攻击距离
         "minDistance":150, // 最小攻击距离
         "dispersion":6, // 散射
         "cooldown":1, // 冷却时间
         "reactChance":0.7, // 反应几率
         "throwChance":1, // 投掷几率
         "throwOffForce":20, // 投掷力
         "distSoundFade":2500, // 声音衰减距离
         "sndFire":Snd_Tower_Cannon_1, // 开火声音
         "sndHit":Snd_Blow_1 // 命中声音
      });
      
      // 定义一个公共静态常量，表示塔楼步枪的原型
      public static const TOWER_RIFLE:AgePrototype = new AgePrototype({
         "objClass":WeaponWithCursor, // 对象类
         "type":Weapon.TYPE_MACHINEGUN, // 武器类型
         "symbol":GS.NEST_RIFLE, // 符号
         "bulletSymbol":E_Bullet_3, // 子弹符号
         "groundMark":[19,24], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "shootPoint":[0,-45], // 射击点
         "damage":120, // 伤害值
         "profit":0.3, // 收益
         "autoAim":100, // 自动瞄准
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":5, // 命中半径
         "distance":4000, // 攻击距离
         "minDistance":150, // 最小攻击距离
         "dispersion":6, // 散射
         "cooldown":1, // 冷却时间
         "reactChance":0.5, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":20, // 投掷力
         "distSoundFade":2500, // 声音衰减距离
         "sndFire":Snd_Rifle_L, // 开火声音
         "sndEnv":SND_BULLET_HIT_ENV // 环境声音
      });
      
      // 定义一个公共静态常量，表示塔楼火箭的原型
      public static const TOWER_ROCKET:AgePrototype = new AgePrototype({
         "objClass":WeaponWithCursor, // 对象类
         "type":Weapon.TYPE_LAUNCHER, // 武器类型
         "symbol":GS.NEST_ROCKET, // 符号
         "effectBlow":ESmoke_Blow_01_L, // 爆炸效果
         "blowSymbol":EFire_Blow_L_01, // 爆炸符号
         "blowSideSymbol":EFire_SideBlow_L, // 侧面爆炸符号
         "screenShake":[1,3], // 屏幕震动
         "groundMark":[20,23], // 地面标记
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "shootPoint":[0,-40], // 射击点
         "blowup":true, // 是否爆炸
         "distance":4000, // 攻击距离
         "minDistance":150, // 最小攻击距离
         "profit":0.3, // 收益
         "cooldown":1, // 冷却时间
         "shell":EntityShell.TOWER_ROCKET, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "shotFromOwner":false, // 是否从拥有者处射击
         "hitRadius":70, // 命中半径
         "damageDist":70, // 伤害距离
         "damage":170, // 伤害值
         "dispersion":10, // 散射
         "reactChance":3, // 反应几率
         "throwChance":2, // 投掷几率
         "throwOffForce":25, // 投掷力
         "throwOffFade":25, // 投掷衰减
         "debugDraw":true, // 是否调试绘制
         "distSoundFade":2500, // 声音衰减距离
         "sndFire":Snd_Rocket // 开火声音
      });
      
      // 定义一个公共静态常量，表示塔楼大门的原型
      public static const TOWER_GATE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_ROKS, // 武器类型
         "caption":Loc.GUI_TOWER_GATE_WPN, // 标题
         "frame":GS.FRAME_TOWER[Tower.UPG_DEFENCE_FLAME], // 帧
         "shortcut":Shortcut.ABILITY_STABILITY, // 快捷键
         "shell":EntityShellFling.GATE_FLAME, // 炮弹
         "maskType":AgeMask.LINE | AgeMask.H_M_B, // 掩码类型
         "shootPoint":[0,0], // 射击点
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "cooldown":0.1, // 冷却时间
         "hitRadius":50, // 命中半径
         "distance":150, // 攻击距离
         "damageDist":250, // 伤害距离
         "throwOffForce":0, // 投掷力
         "throwOffFade":0, // 投掷衰减
         "gory":false, // 是否血腥
         "shotFromOwner":true, // 是否从拥有者处射击
         "distSoundFade":2500, // 声音衰减距离
         "sndAttack":Snd_Rocket, // 攻击声音
         "levelVars":{ // 等级变量
            "damage":[400,600,800], // 伤害值
            "reload":[7,6,5], // 装弹时间
            "clip":[20,30,40] // 弹夹容量
         }
      });
      
      // 定义一个公共静态常量，表示塔楼地雷的原型
      public static const TOWER_MINE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_LAUNCHER, // 武器类型
         "caption":Loc.GUI_TOWER_MINES_WPN, // 标题
         "frame":GS.FRAME_TOWER[Tower.UPG_ADD_MINES], // 帧
         "shortcut":Shortcut.WEAPON_TRAP, // 快捷键
         "screenShake":[1,7], // 屏幕震动
         "blowSymbol":EFire_Blow_L_01, // 爆炸符号
         "reload":1.2, // 装弹时间
         "clip":1, // 弹夹容量
         "shell":EntityShellMine.TOWER_MINE, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_ALL, // 掩码类型
         "hitRadius":70, // 命中半径
         "damage":800, // 伤害值
         "dispersion":7, // 散射
         "minDistance":300, // 最小攻击距离
         "blowup":true, // 是否爆炸
         "throwOffForce":15, // 投掷力
         "throwOffFade":35, // 投掷衰减
         "profit":1, // 收益
         "distSoundFade":2500, // 声音衰减距离
         "sndFire":Snd_GrenadeLauncher, // 开火声音
         "sndBlow":Snd_Blow_1 // 爆炸声音
      });
      
      // 定义一个公共静态常量，表示塔楼地雷命中的原型
      public static const TOWER_MINE_HIT:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_ALL, // 掩码类型
         "screenShake":[3,6], // 屏幕震动
         "groundMark":[19,24], // 地面标记
         "hitRadius":20, // 命中半径
         "damage":20, // 伤害值
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "throwOffForce":15, // 投掷力
         "throwOffFade":25, // 投掷衰减
         "throwOffDist":100 // 投掷距离
      });
      
      // 定义一个公共静态常量，表示塔楼手榴弹的原型
      public static const TOWER_GRENADE:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "caption":Loc.GUI_TOWER_GRENADES_WPN, // 标题
         "shortcut":Shortcut.WEAPON_GRENADE, // 快捷键
         "frame":GS.FRAME_TOWER[Tower.UPG_ADD_GRENADES], // 帧
         "useCursorDistance":true, // 是否使用光标距离
         "screenShake":[3,15], // 屏幕震动
         "signShadow":true, // 是否有阴影
         "shell":EntityShellGrenade.GRENADE, // 炮弹
         "blowSymbol":EFire_CircleBlow_M, // 爆炸符号
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "distance":3000, // 攻击距离
         "damageDistToTarget":600, // 对目标的伤害距离
         "reload":4, // 装弹时间
         "clip":1, // 弹夹容量
         "dispersion":30, // 散射
         "blowup":true, // 是否爆炸
         "fireAtOnce":true, // 是否立即开火
         "reloadIndie":true, // 是否独立装弹
         "showReloadBar":false, // 是否显示装弹条
         "reactChance":3, // 反应几率
         "throwChance":2, // 投掷几率
         "throwOffForce":35, // 投掷力
         "profit":1, // 收益
         "distSoundFade":2500, // 声音衰减距离
         "sndFire":Snd_GrenadeLauncher, // 开火声音
         "sndBlow":Snd_Blow_2, // 爆炸声音
         "levelCount":2, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[900,1400], // 伤害值
            "hitRadius":[100,120] // 命中半径
         }
      });
      
      // 定义一个公共静态常量，表示巢穴迷你机枪的原型
      public static const NEST_MINIGUN:AgePrototype = AgePrototype.createCopy(TOWER_MINIGUN,{
         "shootPoint":[0,-60], // 射击点
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "cursor1":GS.CURSOR_GUN_1, // 光标1
         "cursor2":GS.CURSOR_GUN_2, // 光标2
         "damage":40 // 伤害值
      });
      
      // 定义一个公共静态常量，表示巢穴火箭的原型
      public static const NEST_ROCKET:AgePrototype = AgePrototype.createCopy(TOWER_ROCKET,{
         "cursor1":GS.CURSOR_BLOW_1, // 光标1
         "cursor2":GS.CURSOR_BLOW_2, // 光标2
         "hitRadius":100, // 命中半径
         "damage":200 // 伤害值
      });
      
      // 定义一个公共静态常量，表示测试爆炸的原型
      public static const TEST_BLOW:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BLOW, // 武器类型
         "screenShake":[4,8], // 屏幕震动
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":50, // 命中半径
         "damageDist":50, // 伤害距离
         "damage":30, // 伤害值
         "blowup":true, // 是否爆炸
         "throwChance":2, // 投掷几率
         "throwOffForce":22, // 投掷力
         "throwOffFade":30 // 投掷衰减
      });
       
      
      // 构造函数
      public function PrototypeWeapon()
      {
         // 调用父类的构造函数
         super();
      }
   }
}

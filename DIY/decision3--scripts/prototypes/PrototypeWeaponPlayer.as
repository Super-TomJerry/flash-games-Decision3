// 定义一个包，用于存放原型类
package prototypes
{
   // 导入所需的类
   import age.AgeMask; // 导入 AgeMask 类，用于定义掩码类型
   import age.AgePrototype; // 导入 AgePrototype 类，用于创建原型对象
   import game.Shortcut; // 导入 Shortcut 类，用于定义快捷键
   import game.Weapon; // 导入 Weapon 类，作为武器的基类
   import game.WeaponPlayer; // 导入 WeaponPlayer 类，用于玩家武器
   import graphics.Frames; // 导入 Frames 类，用于定义动画帧
   import graphics.GraphicUnitPlayer; // 导入 GraphicUnitPlayer 类，用于玩家图形单位
   import units.EntityShell; // 导入 EntityShell 类，用于炮弹实体
   import units.EntityShellFling; // 导入 EntityShellFling 类，用于投掷物实体
   import units.EntitySplash; // 导入 EntitySplash 类，用于溅射效果实体
   
   // 定义一个公共类，用于存放玩家武器的原型
   public class PrototypeWeaponPlayer
   {
      
      // 定义一个公共静态常量，表示武器的最大等级
      public static const MAX_LVL:int = 7;
      
      // 定义一个公共静态常量，表示小刀的原型
      public static const KNIFE:AgePrototype = new AgePrototype({
         "name":"KNIFE", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "frame":GS.FRAME_WPN[GC.WPN_KNIFE], // 武器的帧
         "descParams":Loc.WPN_KNIFE_PARAMS, // 描述参数
         "descRate":Loc.GUI_V_FAST, // 描述速率
         "animSymbol":GS.WPN_KNIFE, // 动画符号
         "animSet":Frames.SET_1HAND, // 动画集
         "cursor1":GS.CURSOR_BLADE_1, // 光标1
         "cursor2":null, // 光标2
         "useCursorDistance":false, // 是否使用光标距离
         "type":Weapon.TYPE_KNIFE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE | AgeMask.H_BOTTOM, // 掩码类型
         "hitRadius":20, // 命中半径
         "damageDist":30, // 伤害距离
         "damage":5, // 伤害值
         "distance":40, // 攻击距离
         "minDistance":30, // 最小攻击距离
         "cooldown":1, // 冷却时间
         "profit":3, // 收益
         "manualShot":true, // 是否手动射击
         "throwChance":0.1, // 投掷几率
         "throwOffForce":10, // 投掷力
         "sndAttack":[Snd_HitHalfHand1,Snd_HitHalfHand2,Snd_HitHalfHand3], // 攻击声音
         "levelCount":9, // 等级数量
         "levelVars":{ // 等级变量
            "animAttackSpeed":[1,null,null,1.5,null,null,1.9,null,null], // 攻击动画速度
            "caption":Loc.WPN_KNIFES, // 标题
            "desc":Loc.WPN_KNIFE_DESC // 描述
         }
      });
      
      // 定义一个公共静态常量，表示手枪的原型
      public static const PISTOL:AgePrototype = new AgePrototype({
         "name":"PISTOL", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_PISTOL, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_PISTOL], // 武器的帧
         "descParams":Loc.WPN_PISTOL_PARAMS, // 描述参数
         "descRate":Loc.GUI_AVERAGE, // 描述速率
         "cursor1":GS.CURSOR_PISTOL_1, // 光标1
         "cursor2":GS.CURSOR_PISTOL_2, // 光标2
         "animSet":Frames.SET_PISTOL, // 动画集
         "animSymbol":GS.WPN_PISTOL, // 动画符号
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "damage":5, // 伤害值
         "minDistance":30, // 最小攻击距离
         "dispersion":6, // 散射
         "shootPoint":[5,-10], // 射击点
         "cooldown":0.9, // 冷却时间
         "waitForAnimation":false, // 是否等待动画
         "reload":2, // 装弹时间
         "profit":1, // 收益
         "screenMoveCoef":1, // 屏幕移动系数
         "continuousShot":true, // 是否连续射击
         "manualShot":true, // 是否手动射击
         "reactChance":0.5, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":4, // 投掷力
         "headshot":true, // 是否可以爆头
         "shotFromOwner":true, // 是否从拥有者处射击
         "noKickBack":true, // 是否无后坐力
         "sndTake":Snd_Take, // 拾取声音
         "sndReload":Snd_Pistol_Reload, // 装弹声音
         "sndReloaded":Snd_Wpn_Ready, // 装弹完成声音
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "clip":[7,null,null,10,null,null,15], // 弹夹容量
            "distance":[300,370,430,500,550,600,650,700,750,800], // 攻击距离
            "sndAttack":[Snd_Pistol_S,null,null,Snd_Pistol_M,null,null,Snd_Pistol_L], // 攻击声音
            "caption":Loc.WPN_PISTOL, // 标题
            "desc":Loc.WPN_PISTOL_DESC // 描述
         }
      });
      
      // 定义一个公共静态常量，表示霰弹枪的原型
      public static const SHOTGUN:AgePrototype = new AgePrototype({
         "name":"SHOTGUN", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_SHOTGUN, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_SHOTGUN], // 武器的帧
         "descParams":Loc.WPN_SHOTGUN_PARAMS, // 描述参数
         "descRate":Loc.GUI_AVERAGE, // 描述速率
         "cursor1":GS.CURSOR_SHOTGUN_1, // 光标1
         "cursor2":GS.CURSOR_SHOTGUN_2, // 光标2
         "animSet":Frames.SET_SHOTGUN, // 动画集
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "effectOnGroundChance":0.5, // 地面效果几率
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "damage":5, // 伤害值
         "minDistance":150, // 最小攻击距离
         "dispersion":60, // 散射
         "shootPoint":[5,-10], // 射击点
         "bulletQuantity":4, // 子弹数量
         "cooldown":0.8, // 冷却时间
         "waitForAnimation":true, // 是否等待动画
         "clip":2, // 弹夹容量
         "reload":2, // 装弹时间
         "profit":0.7, // 收益
         "screenMoveCoef":1, // 屏幕移动系数
         "continuousShot":true, // 是否连续射击
         "manualShot":true, // 是否手动射击
         "headshot":true, // 是否可以爆头
         "reactChance":0.5, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":4, // 投掷力
         "shotFromOwner":true, // 是否从拥有者处射击
         "noKickBack":true, // 是否无后坐力
         "sndAttack":Snd_Shotgun, // 攻击声音
         "sndTake":Snd_Take, // 拾取声音
         "sndReload":Snd_Rifle_Reload, // 装弹声音
         "sndReloaded":Snd_Wpn_Ready, // 装弹完成声音
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "clip":[2,null,null,6,null,null,12], // 弹夹容量
            "reload":[2,null,null,3], // 装弹时间
            "distance":[300,null,null,350,null,null,400], // 攻击距离
            "animSymbol":[GS.WPN_SHOTGUN,null,null,GS.WPN_RIFLE], // 动画符号
            "caption":Loc.WPN_SHOTGUN, // 标题
            "desc":Loc.WPN_SHOTGUN_DESC // 描述
         }
      });
      
      // 定义一个公共静态常量，表示机枪的原型
      public static const MACHINEGUN:AgePrototype = new AgePrototype({
         "name":"MACHINEGUN", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_MACHINEGUN, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_MACHINEGUN], // 武器的帧
         "descParams":Loc.WPN_MACHINEGUN_PARAMS, // 描述参数
         "descRate":Loc.GUI_FAST, // 描述速率
         "cursor1":GS.CURSOR_GUN_1, // 光标1
         "cursor2":GS.CURSOR_GUN_2, // 光标2
         "animSet":Frames.SET_GUN, // 动画集
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "effectOnGroundChance":0.4, // 地面效果几率
         "shootPoint":[10,-30], // 射击点
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "damage":1, // 伤害值
         "minDistance":5, // 最小攻击距离
         "dispersion":6, // 散射
         "cooldown":0.25, // 冷却时间
         "waitForAnimation":false, // 是否等待动画
         "headshot":true, // 是否可以爆头
         "profit":0.7, // 收益
         "screenMoveCoef":1, // 屏幕移动系数
         "continuousShot":true, // 是否连续射击
         "manualShot":false, // 是否手动射击
         "reactChance":0.5, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":8, // 投掷力
         "shotFromOwner":true, // 是否从拥有者处射击
         "noKickBack":true, // 是否无后坐力
         "sndTake":Snd_Take, // 拾取声音
         "sndReload":Snd_Rifle_Reload, // 装弹声音
         "sndReloaded":Snd_Wpn_Ready, // 装弹完成声音
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "distance":[400,null,null,500,null,null,700], // 攻击距离
            "clip":[15,null,null,30,null,null,40], // 弹夹容量
            "reload":[3,null,null,4,null,null,3], // 装弹时间
            "animSymbol":[GS.WPN_MP5,null,null,GS.WPN_AK47], // 动画符号
            "caption":Loc.WPN_MACHINEGUN, // 标题
            "desc":Loc.WPN_MACHINEGUN_DESC, // 描述
            "sndAttack":[Snd_Pistol_M,null,null,Snd_AK47,null,null,Snd_M60] // 攻击声音
         }
      });
      
      // 定义一个公共静态常量，表示迷你机枪的原型
      public static const MINIGUN:AgePrototype = new AgePrototype({
         "name":"MINIGUN", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_MINIGUN, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_MINIGUN], // 武器的帧
         "descParams":Loc.WPN_MINIGUN_PARAMS, // 描述参数
         "descRate":Loc.GUI_V_FAST, // 描述速率
         "cursor1":GS.CURSOR_GUN_1, // 光标1
         "cursor2":GS.CURSOR_GUN_2, // 光标2
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
         "hitRadius":20, // 命中半径
         "damage":10, // 伤害值
         "distance":450, // 攻击距离
         "minDistance":5, // 最小攻击距离
         "dispersion":30, // 散射
         "cooldown":0.1, // 冷却时间
         "waitForAnimation":false, // 是否等待动画
         "clip":100, // 弹夹容量
         "reload":5, // 装弹时间
         "profit":0.6, // 收益
         "screenMoveCoef":1, // 屏幕移动系数
         "continuousShot":true, // 是否连续射击
         "manualShot":false, // 是否手动射击
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
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "caption":Loc.WPN_MINIGUN, // 标题
            "desc":Loc.WPN_MINIGUN_DESC, // 描述
            "distance":[300,330,370,400,450,500,600] // 攻击距离
         }
      });
      
      // 定义一个公共静态常量，表示步枪的原型
      public static const RIFLE:AgePrototype = new AgePrototype({
         "name":"RIFLE", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_RIFLE, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_RIFLE], // 武器的帧
         "descParams":Loc.WPN_RIFLE_PARAMS, // 描述参数
         "descRate":Loc.GUI_SLOW, // 描述速率
         "cursor1":GS.CURSOR_GUN_1, // 光标1
         "cursor2":GS.CURSOR_GUN_2, // 光标2
         "cursorStay":GS.CURSOR_SNIPER, // 停留光标
         "animSet":Frames.SET_RIFLE, // 动画集
         "animSymbol":GS.WPN_SNIPER, // 动画符号
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "shootPoint":[10,-30], // 射击点
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "damage":1, // 伤害值
         "minDistance":5, // 最小攻击距离
         "dispersion":6, // 散射
         "headshot":true, // 是否可以爆头
         "autoCursorAim":100, // 自动光标瞄准
         "waitForAnimation":true, // 是否等待动画
         "clip":10, // 弹夹容量
         "cooldown":0.9, // 冷却时间
         "reload":2, // 装弹时间
         "profit":0.7, // 收益
         "continuousShot":true, // 是否连续射击
         "manualShot":false, // 是否手动射击
         "reactChance":0.5, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":8, // 投掷力
         "shotFromOwner":true, // 是否从拥有者处射击
         "noKickBack":true, // 是否无后坐力
         "sndTake":Snd_Take, // 拾取声音
         "sndReload":Snd_Rifle_Reload, // 装弹声音
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "distance":[800,850,900,1000,1100,1200,1300,1400,1500,1700], // 攻击距离
            "screenMoveCoef":[2,null,null,2.5,null,null,3], // 屏幕移动系数
            "caption":Loc.WPN_RIFLE, // 标题
            "desc":Loc.WPN_RIFLE_DESC, // 描述
            "sndAttack":[Snd_Rifle_S,null,null,Snd_Rifle_M,null,null,Snd_Rifle_L] // 攻击声音
         }
      });
      
      // 定义一个公共静态常量，表示火箭筒的原型
      public static const RPG:AgePrototype = new AgePrototype({
         "name":"RPG", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_RPG, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_RPG], // 武器的帧
         "descParams":Loc.WPN_RPG_PARAMS, // 描述参数
         "descRate":Loc.GUI_SLOW, // 描述速率
         "cursor1":GS.CURSOR_BLOW_1, // 光标1
         "cursor2":GS.CURSOR_BLOW_2, // 光标2
         "animSet":Frames.SET_BAZOOKA, // 动画集
         "animSymbol":GS.WPN_BAZOOKA, // 动画符号
         "screenShake":[2,6], // 屏幕震动
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "shell":EntityShell.ROCKET, // 炮弹
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":100, // 命中半径
         "damage":50, // 伤害值
         "distance":700, // 攻击距离
         "minDistance":150, // 最小攻击距离
         "shootPoint":[10,-30], // 射击点
         "dispersion":6, // 散射
         "reload":4, // 装弹时间
         "clip":1, // 弹夹容量
         "waitForAnimation":true, // 是否等待动画
         "profit":0.7, // 收益
         "screenMoveCoef":2, // 屏幕移动系数
         "continuousShot":true, // 是否连续射击
         "manualShot":false, // 是否手动射击
         "reactChance":0.8, // 反应几率
         "throwChance":0.7, // 投掷几率
         "throwOffForce":20, // 投掷力
         "shotFromOwner":false, // 是否从拥有者处射击
         "noKickBack":false, // 是否无后坐力
         "gory":false, // 是否血腥
         "blowup":true, // 是否爆炸
         "speedCoef":0.8, // 速度系数
         "sndAttack":Snd_Rocket, // 攻击声音
         "sndTake":Snd_Take, // 拾取声音
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "caption":Loc.WPN_RPG, // 标题
            "desc":Loc.WPN_RPG_DESC, // 描述
            "effectOnGround":[ESmoke_Blow_01_S,null,null,ESmoke_Blow_01_M,null,null,ESmoke_Blow_01_L], // 地面效果
            "blowSymbol":[EFire_Blow_S_01,null,null,EFire_Blow_M_01,null,null,EFire_Blow_L_01], // 爆炸符号
            "blowSideSymbol":[EFire_SideBlow_S,null,null,EFire_SideBlow_M,null,null,EFire_SideBlow_L], // 侧面爆炸符号
            "sndBlow":[Snd_Blow_1,null,null,Snd_Blow_2,null,null,Snd_Blow_3] // 爆炸声音
         }
      });
      
      // 定义一个公共静态常量，表示火焰喷射器的原型
      public static const ROKS:AgePrototype = new AgePrototype({
         "name":"ROKS", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_ROKS, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_ROKS], // 武器的帧
         "descParams":Loc.WPN_ROKS_PARAMS, // 描述参数
         "descRate":Loc.GUI_AVERAGE, // 描述速率
         "cursor1":GS.CURSOR_FLAME_1, // 光标1
         "cursor2":GS.CURSOR_FLAME_2, // 光标2
         "animSet":Frames.SET_FLAME_THROWER, // 动画集
         "animSymbol":G_ROKS, // 动画符号
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "shell":EntityShellFling.FLAME, // 炮弹
         "maskType":AgeMask.LINE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":20, // 命中半径
         "distance":150, // 攻击距离
         "distanceKeep":170, // 保持距离
         "distanceKeepMin":120, // 最小保持距离
         "minDistance":150, // 最小攻击距离
         "shootPoint":[10,-30], // 射击点
         "dispersion":6, // 散射
         "cooldown":0.2, // 冷却时间
         "clip":50, // 弹夹容量
         "waitForAnimation":false, // 是否等待动画
         "profit":0.7, // 收益
         "screenMoveCoef":1, // 屏幕移动系数
         "continuousShot":true, // 是否连续射击
         "manualShot":false, // 是否手动射击
         "reactChance":0, // 反应几率
         "throwChance":0, // 投掷几率
         "throwOffForce":0, // 投掷力
         "speedCoef":0.8, // 速度系数
         "shotFromOwner":true, // 是否从拥有者处射击
         "noKickBack":false, // 是否无后坐力
         "gory":false, // 是否血腥
         "sndAttack":[Snd_Flame01,Snd_Flame02,Snd_Flame03,Snd_Flame04], // 攻击声音
         "sndTake":Snd_Take, // 拾取声音
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "caption":Loc.WPN_ROKS, // 标题
            "desc":Loc.WPN_ROKS_DESC, // 描述
            "reload":[6,null,null,5,null,null,4,null,null,3] // 装弹时间
         }
      });
      
      // 定义一个公共静态常量，表示手榴弹的原型
      public static const GRENADE:AgePrototype = new AgePrototype({
         "name":"GRENADE", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_GRENADE, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_GRENADE], // 武器的帧
         "descParams":Loc.WPN_GRENADE_PARAMS, // 描述参数
         "animSet":Frames.SET_GRENADE, // 动画集
         "calcRotation":false, // 是否计算旋转
         "descRate":Loc.GUI_V_SLOW, // 描述速率
         "screenShake":[2,10], // 屏幕震动
         "useCursorDistance":true, // 是否使用光标距离
         "blowup":true, // 是否爆炸
         "fireAtOnce":true, // 是否立即开火
         "reloadIndie":true, // 是否独立装弹
         "shortcut":Shortcut.WEAPON_GRENADE, // 快捷键
         "showReloadBar":false, // 是否显示装弹条
         "profit":0.3, // 收益
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":120, // 命中半径
         "damageDistToTarget":200, // 对目标的伤害距离
         "clip":1, // 弹夹容量
         "dispersion":20, // 散射
         "throwOffForce":13, // 投掷力
         "minDistance":100, // 最小攻击距离
         "distance":400, // 攻击距离
         "signShadow":true, // 是否有阴影
         "sndFire":Snd_Throw, // 开火声音
         "sndTake":Snd_Take, // 拾取声音
         "noKickBack":true, // 是否无后坐力
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "caption":Loc.WPN_GRENADE, // 标题
            "desc":Loc.WPN_GRENADE_DESC, // 描述
            "shell":[EntityShell.PINAPLE,null,null,EntityShell.PIPE_BOMB,null,null,EntityShell.NAPALM], // 炮弹
            "reload":[5,null,null,4,null,null,3], // 装弹时间
            "blowSymbol":[EFire_Blow_M_01,null,null,EFire_Blow_L_01,null,null,EFire_CircleBlow_M], // 爆炸符号
            "effectSplash":[null,null,null,EntitySplash.GROUND_BLOW_S,null,null,EntitySplash.GROUND_BLOW_M], // 溅射效果
            "sndBlow":[Snd_Blow_1,null,null,Snd_Blow_2,null,null,Snd_Blow_3] // 爆炸声音
         }
      });
      
      // 定义一个公共静态常量，表示地雷的原型
      public static const MINE:AgePrototype = new AgePrototype({
         "name":"PrototypeWeaponPlayer.MINE", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_MINE, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_MINE], // 武器的帧
         "animSet":GraphicUnitPlayer.SET_PLACE_TRAP, // 动画集
         "moveSpeedCoef":0, // 移动速度系数
         "calcRotation":false, // 是否计算旋转
         "caption":Loc.WPN_MINE, // 标题
         "desc":Loc.WPN_MINE_DESC, // 描述
         "descParams":Loc.WPN_MINE_PARAMS, // 描述参数
         "descRate":Loc.GUI_V_SLOW, // 描述速率
         "fireAtOnce":true, // 是否立即开火
         "reloadIndie":true, // 是否独立装弹
         "shortcut":Shortcut.WEAPON_TRAP, // 快捷键
         "showReloadBar":false, // 是否显示装弹条
         "shell":Prototype.PLAYER_MINE, // 炮弹
         "reload":1.5, // 装弹时间
         "clip":1, // 弹夹容量
         "profit":0.7, // 收益
         "levelCount":10, // 等级数量
         "levelVars":PrototypeWeapon.PLAYER_MINE_BLOW.levelVars // 等级变量
      });
      
      // 定义一个公共静态常量，表示弓的原型
      public static const BOW:AgePrototype = new AgePrototype({
         "name":"BOW", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_BOW, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_BOW], // 武器的帧
         "caption":Loc.WPN_BOW, // 标题
         "desc":Loc.WPN_BOW_DESC, // 描述
         "descParams":Loc.WPN_BOW_PARAMS, // 描述参数
         "descRate":Loc.GUI_AVERAGE, // 描述速率
         "cursor1":GS.CURSOR_GUN_1, // 光标1
         "cursor2":GS.CURSOR_GUN_2, // 光标2
         "animSet":Frames.SET_BOW, // 动画集
         "animSymbol":GS.WPN_BOW, // 动画符号
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "shell":EntityShell.BLOW_ARROW, // 炮弹
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":15, // 命中半径
         "damage":15, // 伤害值
         "minDistance":40, // 最小攻击距离
         "dispersion":5, // 散射
         "profit":0.7, // 收益
         "screenMoveCoef":2, // 屏幕移动系数
         "manualShot":false, // 是否手动射击
         "reactChance":0.4, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":8, // 投掷力
         "headshot":true, // 是否可以爆头
         "debugDraw":true, // 是否调试绘制
         "shotFromOwner":true, // 是否从拥有者处射击
         "noKickBack":true, // 是否无后坐力
         "sndAttack":Snd_Bow1, // 攻击声音
         "sndTake":Snd_Take, // 拾取声音
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "cooldown":[1.8,null,null,1.5,null,null,1.2,null,null], // 冷却时间
            "distance":[800,850,900,1000,1050,1100,1200,1300,1400,1500], // 攻击距离
            "screenMoveCoef":[2,null,null,2.5,null,null,3,null,null] // 屏幕移动系数
         }
      });
      
      // 定义一个公共静态常量，表示盾牌的原型
      public static const SHIELD:AgePrototype = new AgePrototype({
         "name":"SHIELD", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "type":Weapon.TYPE_PISTOL, // 武器类型
         "frame":GS.FRAME_WPN[GC.WPN_SHIELD], // 武器的帧
         "caption":Loc.WPN_SHIELD, // 标题
         "desc":Loc.WPN_SHIELD_DESC, // 描述
         "descParams":Loc.WPN_SHIELD_PARAMS, // 描述参数
         "descRate":Loc.GUI_AVERAGE, // 描述速率
         "animSet":Frames.SET_PISTOL, // 动画集
         "animSymbol":GS.WPN_SHIELD, // 动画符号
         "bulletSymbol":E_Bullet_1, // 子弹符号
         "groundMark":[1,9], // 地面标记
         "effectOnGround":ESmoke_Blow_01_S, // 地面效果
         "stayInPlaceCursor":false, // 光标是否停留在原地
         "useCursorDistance":true, // 是否使用光标距离
         "maskType":AgeMask.LINE | AgeMask.H_MIDDLE, // 掩码类型
         "hitRadius":20, // 命中半径
         "damage":5, // 伤害值
         "minDistance":30, // 最小攻击距离
         "dispersion":6, // 散射
         "shootPoint":[5,-10], // 射击点
         "headshot":true, // 是否可以爆头
         "cooldown":0.9, // 冷却时间
         "waitForAnimation":false, // 是否等待动画
         "clip":10, // 弹夹容量
         "reload":2, // 装弹时间
         "profit":1, // 收益
         "screenMoveCoef":1, // 屏幕移动系数
         "continuousShot":true, // 是否连续射击
         "manualShot":true, // 是否手动射击
         "reactChance":0.5, // 反应几率
         "throwChance":0.1, // 投掷几率
         "throwOffForce":4, // 投掷力
         "shotFromOwner":true, // 是否从拥有者处射击
         "noKickBack":true, // 是否无后坐力
         "sndAttack":Snd_Pistol_L, // 攻击声音
         "sndTake":Snd_Take, // 拾取声音
         "levelCount":10, // 等级数量
         "levelVars":{ // 等级变量
            "armor":[0.1,0.15,0.2,0.3,0.35,0.4,0.5,0.6,0.7,0.8], // 护甲
            "distance":[300,370,430,500,550,600,700,800] // 攻击距离
         }
      });
      
      // 定义一个公共静态常量，表示徒手的原型
      public static const HAND:AgePrototype = new AgePrototype({
         "objClass":WeaponPlayer, // 对象类
         "animSet":Frames.SET_EMPTY, // 动画集
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":18, // 命中半径
         "damage":15, // 伤害值
         "damageRage":40, // 伤害范围
         "distance":35, // 攻击距离
         "cooldown":1, // 冷却时间
         "profit":3, // 收益
         "throwChance":0.1, // 投掷几率
         "throwOffForce":9, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "throwOffDist":500, // 投掷距离
         "sndAttack":[Snd_Hero_HitHand1,Snd_Hero_HitHand2,Snd_Hero_HitHand3], // 攻击声音
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[15,20,30], // 伤害值
            "animSet":[Frames.SET_EMPTY,[Frames.SET_EMPTY,Frames.SET_LEG],null] // 动画集
         }
      });
      
      // 定义一个公共静态常量，表示回旋拳的原型
      public static const HAND_ROUND:AgePrototype = new AgePrototype({
         "name":"HAND_ROUND", // 武器名称
         "objClass":WeaponPlayer, // 对象类
         "animSet":Frames.SET_HAND_ROUND, // 动画集
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE | AgeMask.H_BOTTOM, // 掩码类型
         "hitRadius":50, // 命中半径
         "damageDist":100, // 伤害距离
         "distance":45, // 攻击距离
         "cooldown":2, // 冷却时间
         "profit":3, // 收益
         "throwOffForce":10, // 投掷力
         "levelCount":2, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[30,40], // 伤害值
            "throwChance":[0.5,0.7] // 投掷几率
         }
      });
      
      // 定义一个公共静态常量，表示空手道的原型
      public static const KARATE:AgePrototype = new AgePrototype({
         "objClass":WeaponPlayer, // 对象类
         "animSet":Frames.SET_KARATE, // 动画集
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "hitRadius":23, // 命中半径
         "damage":50, // 伤害值
         "damageRage":90, // 伤害范围
         "distance":50, // 攻击距离
         "cooldown":2, // 冷却时间
         "profit":3, // 收益
         "throwChance":1, // 投掷几率
         "throwOffForce":17, // 投掷力
         "throwOffFade":28, // 投掷衰减
         "throwOffDist":400, // 投掷距离
         "sndAttack":[Snd_Hero_HitLeg1,Snd_Hero_HitLeg2,Snd_Hero_HitLeg3] // 攻击声音
      });
      
      // 定义一个公共静态常量，表示跳跃攻击的原型
      public static const JUMP:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BLOW, // 武器类型
         "animSet":Frames.SET_JUMP, // 动画集
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "screenShake":[4,7], // 屏幕震动
         "hitRadius":120, // 命中半径
         "damageDist":180, // 伤害距离
         "profit":2, // 收益
         "blowup":true, // 是否爆炸
         "throwChance":3, // 投掷几率
         "throwOffForce":16, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "throwOffDist":300, // 投掷距离
         "sndAttack":Snd_Throw, // 攻击声音
         "sndFire":Snd_Boss_Earthquake, // 开火声音
         "groundMark":[37,42], // 地面标记
         "effectOnGround":ESmoke_Blow_01_L, // 地面效果
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[30,70,100], // 伤害值
            "cooldown":[10,8,6] // 冷却时间
         },
         "getLevel":KNIFE.getLevel // 获取等级的方法
      });
      
      // 定义一个公共静态常量，表示雷电攻击的原型
      public static const THUNDER:AgePrototype = new AgePrototype({
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_BLOW, // 武器类型
         "animSet":Frames.SET_THUNDER, // 动画集
         "maskType":AgeMask.CIRCLE | AgeMask.H_M_B, // 掩码类型
         "screenShake":[2,5], // 屏幕震动
         "hitRadius":55, // 命中半径
         "profit":0.5, // 收益
         "throwOffForce":16, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "throwOffDist":300, // 投掷距离
         "effectOnGround":ESmoke_Blow_01_L, // 地面效果
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "sndFire":Snd_Boss_Earthquake // 开火声音
      });
      
      // 定义一个公共静态常量，表示冲撞攻击的原型
      public static const TARAN:AgePrototype = new AgePrototype({
         "name":"TARAN", // 武器名称
         "objClass":Weapon, // 对象类
         "type":Weapon.TYPE_MELEE, // 武器类型
         "maskType":AgeMask.CIRCLE | AgeMask.H_MIDDLE, // 掩码类型
         "screenShake":[2,8], // 屏幕震动
         "hitRadius":25, // 命中半径
         "distance":20, // 攻击距离
         "profit":1, // 收益
         "throwChance":100, // 投掷几率
         "throwOffForce":16, // 投掷力
         "throwOffFade":30, // 投掷衰减
         "effectOnGround":ESmoke_Blow_01_L, // 地面效果
         "anyCaseEffects":true, // 是否有任何情况下的效果
         "debugDraw":false, // 是否调试绘制
         "sndAttack":[Snd_Hero_HitLeg1,Snd_Hero_HitLeg2,Snd_Hero_HitLeg3], // 攻击声音
         "levelCount":3, // 等级数量
         "levelVars":{ // 等级变量
            "damage":[30,50,80], // 伤害值
            "cooldown":[20,15,8] // 冷却时间
         },
         "getLevel":KNIFE.getLevel // 获取等级的方法
      });
      
      // 定义一个公共静态常量，表示武器数组
      public static const WEAPONS:Array = [];
      
      // 定义一个公共静态常量，表示花费数组
      public static const COSTS:Array = [];
      
      // 静态初始化块
      {
         // 初始化武器数组
         WEAPONS[GC.WPN_KNIFE] = KNIFE;
         WEAPONS[GC.WPN_BOW] = BOW;
         WEAPONS[GC.WPN_SHOTGUN] = SHOTGUN;
         WEAPONS[GC.WPN_MACHINEGUN] = MACHINEGUN;
         WEAPONS[GC.WPN_RIFLE] = RIFLE;
         WEAPONS[GC.WPN_RPG] = RPG;
         WEAPONS[GC.WPN_MINIGUN] = MINIGUN;
         WEAPONS[GC.WPN_GRENADE] = GRENADE;
         WEAPONS[GC.WPN_MINE] = MINE;
         WEAPONS[GC.WPN_SHIELD] = SHIELD;
         WEAPONS[GC.WPN_ROKS] = ROKS;
         WEAPONS[GC.WPN_PISTOL] = PISTOL;
         // 初始化各种武器的伤害值
         KNIFE.levelVars.damage = [20,30,60,90,120,140,190,220,250,280];
         PISTOL.levelVars.damage = [12,18,27,40,48,56,65,72,80,100];
         SHOTGUN.levelVars.damage = [7,10,15,20,25,30,35,40,45,50];
         MACHINEGUN.levelVars.damage = [9,15,20,30,35,40,50,55,60,70];
         RIFLE.levelVars.damage = [20,30,45,80,100,120,150,160,180,210];
         MINIGUN.levelVars.damage = [9,15,20,30,35,40,50,55,60,70];
         RPG.levelVars.damage = [65,75,84,104,113,123,143,156,170,185];
         GRENADE.levelVars.damage = [25,35,45,60,65,75,85,100,110,130];
         BOW.levelVars.damage = [20,30,40,55,65,75,90,100,110,130];
         ROKS.levelVars.damage = [12,18,27,40,48,56,65,72,80,100];
         PrototypeWeapon.PLAYER_MINE_BLOW.levelVars.damage = [80,90,100,130,140,150,180,190,220,250];
         SHIELD.levelVars.damage = [12,18,27,40,48,56,65,72,80,120];
         // 初始化各种武器的花费
         COSTS[GC.WPN_KNIFE] = [0,100,200,500,1100,1200,1500,2100,2400,3000,5000];
         COSTS[GC.WPN_PISTOL] = [0,500,700,1200,2400,2600,3000,4200,4700,6000,10000];
         COSTS[GC.WPN_MACHINEGUN] = [0,1000,1300,1900,3700,3900,4600,6400,7100,9000,13000];
         COSTS[GC.WPN_RIFLE] = [0,550,850,1350,2750,2950,3450,4850,5450,7000,9000];
         COSTS[GC.WPN_SHOTGUN] = [0,1000,1300,1900,3700,3900,4600,6400,7100,9000,12000];
         COSTS[GC.WPN_MINIGUN] = [0,2500,3000,3500,5000,5500,6000,7000,8000,10000,15000];
         COSTS[GC.WPN_RPG] = [0,1100,1400,2100,3900,4100,4900,6700,7400,9500,12000];
         COSTS[GC.WPN_ROKS] = [0,3000,3300,3800,5400,5600,6200,7700,8300,10000,15000];
         COSTS[GC.WPN_BOW] = [0,1000,1300,1800,3400,3600,4200,5700,6300,8000,10000];
         COSTS[GC.WPN_GRENADE] = [0,2000,2200,2700,4000,4200,4700,6000,6500,8000,10000];
         COSTS[GC.WPN_MINE] = [0,1000,1200,1500,2400,2500,2900,3700,4100,5000,7000];
         COSTS[GC.WPN_SHIELD] = [0,1000,1200,1600,2700,2900,3300,4400,4800,6000,8000];
      }
      
      // 构造函数
      public function PrototypeWeaponPlayer()
      {
         // 调用父类的构造函数
         super();
      }
      
      // 获取武器数量的静态方法
      public static function get WEAPONS_COUNT() : int
      {
         // 返回武器数组的长度
         return WEAPONS.length;
      }
      
      // 获取指定等级原型的静态方法
      public static function getLevelProto(param1:AgePrototype, param2:int) : AgePrototype
      {
         var _loc4_:* = undefined; // 局部变量4
         var _loc5_:* = undefined; // 局部变量5
         var _loc6_:int = 0; // 局部变量6
         var _loc3_:AgePrototype = param1.protoCopy; // 局部变量3，原型的副本
         if(_loc3_ == null) // 如果副本为空
         {
            _loc3_ = new AgePrototype(null); // 创建一个新的原型对象
            for(_loc5_ in param1) // 遍历原型
            {
               _loc3_[_loc5_] = param1[_loc5_]; // 复制属性
            }
            param1.protoCopy = _loc3_; // 保存副本
            _loc3_.level = -1; // 设置等级为-1
         }
         if(_loc3_.level == param2) // 如果等级相同
         {
            return _loc3_; // 返回副本
         }
         _loc3_.level = param2; // 设置等级
         if(param2 != 0) // 如果等级不为0
         {
            param2--; // 等级减1
         }
         for(_loc4_ in param1.levelVars) // 遍历等级变量
         {
            if(param1.levelVars[_loc4_][param2]) // 如果存在该等级的变量
            {
               _loc3_[_loc4_] = param1.levelVars[_loc4_][param2]; // 设置变量
            }
            else
            {
               _loc6_ = param2 - 1; // 等级减1
               while(_loc6_ > 0 && param1.levelVars[_loc4_][_loc6_] == null) // 循环查找上一个存在的变量
               {
                  _loc6_--; // 等级减1
               }
               _loc3_[_loc4_] = param1.levelVars[_loc4_][_loc6_]; // 设置变量
            }
         }
         return _loc3_; // 返回副本
      }
      
      // 获取指定原型和等级的原型的静态方法
      public static function getProto(param1:int, param2:int) : AgePrototype
      {
         // 返回指定等级的原型
         return getLevelProto(WEAPONS[param1],param2);
      }
      
      // 获取指定原型和等级的帧的静态方法
      public static function getProtoFrame(param1:int, param2:int) : int
      {
         var _loc3_:AgePrototype = WEAPONS[param1]; // 获取原型
         if(_loc3_.levelVars.frame && _loc3_.levelVars.frame.length > param2 - 1) // 如果存在该等级的帧
         {
            return _loc3_.levelVars.frame[param2 > 0 ? param2 - 1 : 0]; // 返回帧
         }
         return _loc3_.frame + param2; // 返回默认帧
      }
      
      // 获取指定原型和等级的标题的静态方法
      public static function getProtoCaption(param1:int, param2:int) : String
      {
         var _loc3_:AgePrototype = WEAPONS[param1]; // 获取原型
         if(_loc3_.levelVars.caption) // 如果存在标题
         {
            if(param2 != 0) // 如果等级不为0
            {
               param2--; // 等级减1
            }
            while(_loc3_.levelVars.caption[param2] == null && param2 > 0) // 循环查找上一个存在的标题
            {
               param2--; // 等级减1
            }
            return _loc3_.levelVars.caption[param2]; // 返回标题
         }
         return _loc3_.caption; // 返回默认标题
      }
   }
}

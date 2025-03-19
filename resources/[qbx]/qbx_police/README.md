# qbx_policejob
QBOX 警察职业 :police_officer:

## 依赖
- [qbx_core](https://github.com/Qbox-project/qbx_core)
- [ox_lib](https://github.com/overextended/ox_lib) - 用于 UI 元素和缓存数据

## 截图
*我们需要新的截图*

## 功能
- 经典需求，如执勤/下班、服装、车辆、储物等
- 基于公民 ID 的军械库（白名单）
- 指纹测试
- 证据储物柜（存放处）
- 白名单车辆
- 遍布地图的测速雷达
- 破门工具
- 扣押玩家车辆（永久/支付一定金额后取回）
- 集成的监狱系统
- 弹壳
- 枪击残留物检测
- 血迹
- 证据袋和钱袋
- 警察雷达
- 手铐作为物品（也可以通过命令使用。请查看命令部分。）
- 紧急服务人员可以在地图上看到彼此

### 命令
- /spikestrip - 在地面上放置路障钉带
- /grantlicense - 授予用户执照
- /revokelicense - 吊销用户执照
- /pobject [cone/barrier/roadsign/tent/light/delete] - 在地面上放置或删除对象
- /cuff - 铐住/解开附近玩家
- /escort - 护送附近玩家
- /callsign [text] - 为玩家设置呼号并存储在数据库中
- /clearcasings - 清除附近的弹壳
- /jail [id] [time] - 将玩家送进监狱
- /unjail [id] - 将玩家从监狱释放
- /clearblood - 清除附近的血迹
- /seizecash - 没收附近玩家的现金（放入钱袋）
- /sc - 对附近玩家使用软铐
- /cam [cam] - 显示选定的监控摄像头画面
- /flagplate [plate] [reason] - 标记车辆
- /unflagplate [plate] - 取消标记车辆
- /plateinfo [plate] - 显示车辆是否被标记
- /depot [price] - 扣押附近车辆。玩家支付费用后可以取回
- /impound - 永久扣押附近车辆
- /paytow [id] - 向拖车司机支付费用
- /paylawyer [id] - 向律师支付费用
- /anklet - 为附近玩家佩戴脚环（追踪设备）
- /ankletlocation [citizenId] - 获取指定公民 ID 玩家的位置
- /takedna [id] - 从玩家身上提取 DNA 样本
- /911p [message] - 向警察发送报告

## 安装
### 手动安装
- 下载脚本并将其放入 `[qbx]` 目录
- 将以下代码添加到你的 server.cfg/resouces.cfg 文件中

```
ensure qbx_core
ensure qbx_policejob
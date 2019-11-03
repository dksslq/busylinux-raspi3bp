## Raspberry Pi 3B Plus BusyLinux

* #### 使用方法:

* --使用setup.sh安装

* ##### >>启动<<

* 默认ssh-server端口:22, root密码:1234
* 默认ap热点服务开机自启 WPA
* ESSID=busylinux
* PASSWD=12345678 

* 如果你的SD卡还未进行分区,可以使用mkpart脚本帮助分区

* 大部分软件和库搬运自debian

* ##### 由于ffmpeg bcm2835 mmal v4l2录制视频时, 有一定几率导致内核恐慌, 继而ffmpeg进程被冻结,
  ##### 所以暂停使用5.x主线内核, 现内核已使用rpi官方源码4.19.y构建。相关bug记录详见logs/5.2.20-bug.txt

* ##### ...未完待续...

## 联系方式

* QQ: 1578756762

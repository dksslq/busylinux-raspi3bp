#!/bin/sh
set -e

echo "警告! 进行安装操作将会清除目标安装目录中的旧文件!"
echo

BOOT="$PWD/boot"

ROOTBASIC="$PWD/root-basic.cpio"
LIBS="$PWD/software/basic/lib"
ETCS="$PWD/software/basic/etc"

INITD="$PWD/software/basic/init.d.tar.xz"

SOFT="$PWD/software"

while [ -z "$SD_BOOTDIR" -o ! -d "$SD_BOOTDIR" ];do
	printf "输入SD卡boot分区挂载点: ";read SD_BOOTDIR
done

while [ -z "$SD_ROOTDIR" -o ! -d "$SD_ROOTDIR" ];do
	printf "输入SD卡root分区挂载点: ";read SD_ROOTDIR
done

# clean old files
find "$SD_BOOTDIR" -maxdepth 1 -! -path "$SD_BOOTDIR" -exec rm -rf {} \;
find "$SD_ROOTDIR" -maxdepth 1 -! -path "$SD_ROOTDIR" -exec rm -rf {} \;
sync

cp -rfa "$BOOT/." $SD_BOOTDIR

#search and install *.tar.xz from $1 depth 1
dist_install_xzs(){
	for package in `find $1 -maxdepth 1 -type f -name "*.tar.xz"`; do
		dist_install_xz $package
	done
	wait
}
dist_install_xz(){
	tar -k -xJvf $1 -C $SD_ROOTDIR
	wait
}


cd "$SD_ROOTDIR"
cpio -i < $ROOTBASIC
cd -

dist_install_xzs $LIBS
dist_install_xzs $ETCS

dist_install_xz $INITD

dist_install_xzs $SOFT

sync

echo
echo "All Done."


#!/bin/sh

echo "警告!进行安装操作将会清除目标安装目录中的旧文件!"
echo

BOOT="$PWD/boot/*"

ROOTBASIC="$PWD/root-basic.cpio"
LIBS="$PWD/software/basic/lib"

INITD="$PWD/software/basic/init.d.tar.xz"
USER="$PWD/software/basic/user.tar.xz"
NCURTERM="$PWD/software/basic/ncurses-term-6.1.tar.xz"

SOFT="$PWD/software"

#stat $LIBS $SOFT $INITD $USER $NCURTERM
printf "输入SD卡boot分区挂载点: ";read BOOTDIR
printf "输入SD卡root分区挂载点: ";read ROOTDIR

set -e

rm -rf "$BOOTDIR/*"
rm -rf "$ROOTDIR/*"
sync

cp -rfa $BOOT $BOOTDIR

#search and install *.tar.xz from $1 depth 1
dist_install_xzs(){
	find $1 -maxdepth 1 -type f -name "*.tar.xz" -exec tar xJvf {} -C $ROOTDIR \;
	wait
}
dist_install_xz(){
	tar xJvf $1 -C $ROOTDIR
	wait
}


cd $ROOTDIR
cpio -i < $ROOTBASIC
cd -

dist_install_xzs $LIBS

dist_install_xz $INITD
dist_install_xz $USER
dist_install_xz $NCURTERM

dist_install_xzs $SOFT

sync

echo
echo "All Done."


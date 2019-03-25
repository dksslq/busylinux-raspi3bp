# set cmdline for kernel
env set bootargs "console=ttyS1,115200 noinitrd root=/dev/mmcblk0p2 rw rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait init=/sbin/init"

MMC_DEV_PART="mmc 0:1"
KERNEL_FILE="/linux/Image"
FDT_FILE="/linux/bcm2837-rpi-3-b-plus.dtb"

# load blobs to mem from fs
load ${MMC_DEV_PART} ${kernel_addr_r} ${KERNEL_FILE}
load ${MMC_DEV_PART} ${fdt_addr_r} ${FDT_FILE}

# kernel fdt
fdt addr ${fdt_addr_r}
fdt resize

booti ${kernel_addr_r} - ${fdt_addr_r}











# TO generate boot.scr file. Run:
# mkimage -Cnone -Aarm -Tscript -dboot.cmd boot.scr

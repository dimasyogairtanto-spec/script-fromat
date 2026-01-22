#!/bin/sh
ROOT_PART="/dev/sda1"
BOOT_PART="/dev/sda2"
DATA_PART="/dev/sda3"

umount -R /mnt
echo "==> Format root"
mkfs.ext4 -b 4096 ${ROOT_PART} && 
mount $ROOT_PART /mnt &&
echo "==> Format boot"
mkdir /mnt/boot &&
mkfs.vfat -F32 -S 4096 -n BOOT ${BOOT_PART} &&
mount $BOOT_PART /mnt/boot &&
echo "==> Format data"
mkdir /mnt/home &&
mkfs.ext4 -b 4096 ${BOOT_PART} &&
mount $DATA_PART /mnt/home &&
genfstab -U /mnt >> /mnt/etc/fstab

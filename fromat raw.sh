mkfs.ext4 -b 4096 /dev/sda1 &&
mount /dev/sda1 /mnt &&
mkfs.vfat -F32 -S 4096 -n BOOT /dev/sda2 &&
mount -o uid=0,gid=0,fmask=0077,dmask=0077 /dev/sda2 /mnt &&
mkdir /dev/home
mkfs.ext4 -b 4096 /dev/sda3
mount /dev/sda3 /mnt/home &&
genfstab -U /mnt >> /mnt/etc/fstab

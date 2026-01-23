#!/bin/sh
read -p "partisi boot: " boot
read -p "partisi fd: " fd

echo "==> Format boot"
mkfs.vfat -F32 -S 4096 -n BOOT ${boot} &&
mount -o uid=0,gid=0,fmask=0077,dmask=0077 "$boot" /mnt &&
mount "$fd" /opt &&
mkdir /mnt/{efi,loader,kernel} &&
mkdir /mnt/efi/{linux,boot,recovery,systemd} &&
bootctl --path=/mnt install &&
cp /opt/arch/boot/x86_64/* /mnt/efi/recovery &&
cp -r /opt/arch/x86_64 /mnt/efi/recovery &&
sed <<EOF
    'title      recovery
     versions   archiso
     linux      /efi/recovery/vmlinuz-linux
     initrd     /efi/recovery/initramfs-linux.img
     options    archisobasedir=efi/recovery archisolabel=BOOT copytoram' /mnt/loader/entries/recovery.conf
     
     EOF


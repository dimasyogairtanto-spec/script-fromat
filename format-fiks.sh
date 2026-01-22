read -p "partisi root: " root
read -p "partisi boot: " boot
read -p "partisi data: " data

echo "==> Format root"
mkfs.ext4 -b 4096 ${root} && 
mount "$root" /mnt &&
echo "==> Format boot"
mkdir /mnt/boot &&
mkfs.vfat -F32 -S 4096 -n BOOT ${boot} &&
mount "$boot" /mnt/boot &&
echo "==> Format data"
mkdir /mnt/home &&
mkfs.ext4 -b 4096 ${data} &&
mount "$data" /mnt/home &&
pacstrap /mnt base linux &&
genfstab -U /mnt > /mnt/etc/fstab

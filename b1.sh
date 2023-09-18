#!/bin/bash
# для BIOS Intel Nvidia

timedatectl set-ntp true
wipefs --all /dev/sda
cfdisk /dev/sda

mkfs.btrfs -f /dev/sda3
mkfs.ext4 /dev/sda2
# или mkfs.fat -F32 /dev/sda2 − создать fat32 фс
mount /dev/sda3 /mnt
cd /mnt

btrfs subvolume create ./@
btrfs subvolume create ./@home

cd
umount /mnt -R

mount -o rw,noatime,compress=zstd:3,ssd,ssd_spread,discard=async,space_cache=v2,subvol=/@ /dev/sda3 /mnt #для SSD
# mount -o rw,noatime,autodefrag,compress=zstd:3,space_cache=v2,subvol=/@ /dev/sda3 /mnt #для HDD
mkdir /mnt/home
mount -o rw,noatime,compress=zstd:3,ssd,ssd_spread,discard=async,space_cache=v2,subvol=/@home /dev/sda3 /mnt/home

mkdir /mnt/boot
mount /dev/sda2 /mnt/boot

pacstrap /mnt base base-devel linux-zen linux-zen-headers nano btrfs-progs plasma plasma-wayland-session egl-wayland sddm nftables iptables-nft realtime-privileges dbus-broker intel-ucode linux-firmware nvidia-dkms nvidia-utils lib32-nvidia-utils opencl-nvidia lib32-opencl-nvidia nvidia-settings networkmanager konsole dolphin kate

genfstab -U /mnt >> /mnt/etc/fstab

btrfs filesystem label /mnt "arch_os"

umount /usb

arch-chroot /mnt

# Liberty − 2023.09.07 07:43


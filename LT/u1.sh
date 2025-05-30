#!/bin/bash
# для UEFI Intel Nvidia

timedatectl set-ntp true
wipefs --all /dev/sda
cfdisk /dev/sda

mkfs.btrfs -f /dev/sda2
mkfs.fat -F32 /dev/sda1
mount /dev/sda2 /mnt
cd /mnt

btrfs subvolume create ./@
btrfs subvolume create ./@home

cd
umount /mnt -R

mount -o rw,noatime,compress=zstd:3,ssd,ssd_spread,discard=async,space_cache=v2,subvol=/@ /dev/sda2 /mnt #для SSD
# mount -o rw,noatime,autodefrag,compress=zstd:3,space_cache=v2,subvol=/@ /dev/sda2 /mnt #для HDD
mkdir /mnt/home
mount -o rw,noatime,compress=zstd:3,ssd,ssd_spread,discard=async,space_cache=v2,subvol=/@home /dev/sda2 /mnt/home

mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt base base-devel linux linux-headers nano btrfs-progs plasma sddm nftables iptables-nft realtime-privileges dbus-broker intel-ucode linux-firmware networkmanager konsole dolphin kate

genfstab -U /mnt >> /mnt/etc/fstab

btrfs filesystem label /mnt "arch_os"

umount /usb

arch-chroot /mnt

# Liberty − 2023.06.30 16:48


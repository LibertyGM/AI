#!/bin/bash
# для BIOS EXT4

timedatectl set-ntp true
wipefs --all /dev/sda
cfdisk /dev/sda

mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda2
# или mkfs.fat -F32 /dev/sda2 − создать fat32 фс


mount -o defaults,noatime /dev/sda3 /mnt

mkdir /mnt/boot
mount /dev/sda2 /mnt/boot

pacstrap /mnt base base-devel linux-zen linux-zen-headers nano btrfs-progs plasma plasma-wayland-session egl-wayland sddm nftables iptables-nft realtime-privileges dbus-broker intel-ucode linux-firmware nvidia-dkms nvidia-utils lib32-nvidia-utils opencl-nvidia lib32-opencl-nvidia nvidia-settings networkmanager konsole dolphin kate

genfstab -U /mnt >> /mnt/etc/fstab

e2label /dev/sda3 "arch_os"

umount /usb

arch-chroot /mnt

# Liberty − 2023.09.07 07:44


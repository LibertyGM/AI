#!/bin/bash
# для BIOS Intel Nvidia

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen

echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf

locale-gen

echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf

echo "Alex-PC" >> /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 Alex-PC" >> /etc/hosts

passwd

useradd -mG realtime,wheel liberty
passwd liberty

systemctl enable NetworkManager sddm
systemctl mask NetworkManager-wait-online

pacman -S grub
grub-install /dev/sda

grub-mkconfig -o /boot/grub/grub.cfg

# Liberty − 2024.03.03 23:03

#!/bin/bash
# для UEFI Intel Nvidia

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

bootctl install

echo "default linux.conf" > /boot/loader/loader.conf
echo "timeout 0" >> /boot/loader/loader.conf
echo "console-mode auto" >> /boot/loader/loader.conf
echo "editor no" >> /boot/loader/loader.conf

echo "title linux" >> /boot/loader/entries/linux.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/linux.conf
echo "initrd /amd-ucode.img" >> /boot/loader/entries/linux.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/linux.conf
echo 'options root="LABEL=arch_os" rw rootflags=subvol=@ nowatchdog modprobe.blacklist=iTCO_wdt loglevel=6 rootfstype=btrfs nvidia.NVreg_EnablePCIeGen3=1 nvidia.NVreg_UsePageAttributeTable=1 nvidia-drm.modeset=1' >> /boot/loader/entries/linux.conf

# Liberty − 2025.05.06 11:40

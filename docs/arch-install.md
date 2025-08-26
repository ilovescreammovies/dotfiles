# Installing Arch Linux and configuring it the way I like

## Pre-installation

1. Set keyboard layout

```bash
loadkeys br-abnt2
```

2. Connect to the internet

```bash
iwctl --passphrase <passphrase> station <name> connect <SSID>
```

3. Set machine date and hour

```bash
timedatectl set-timezone America/Sao_Paulo
```

4. Partition the disk

| Mount point | Capacity | GPT UUID code |
| ----------- | -------- | ------------- |
| efi         | 1G       | EF00          |
| swap        | 16G      | 8200          |
| /           | ...      | 8304          |

```bash
gdisk </dev/the_disk_to_be_partitioned>
```

5. Format the partitions

```bash
mkfs.ext4 </dev/root_partition>
mkswap </dev/swap_partition>
mkfs.fat -F 32 </dev/efi_system_partition>
```

6. Mount the file systems

```bash
mount </dev/root_partition> /mnt
mount --mkdir </dev/efi_partition> /mnt/boot
swapon </dev/swap_partition>
```

## Installing the system

1.  Select best pacman mirrors

```bash
sudo reflector --country BR,US --protocol https --sort rate --connection-timeout 3 --download-timeout 3 --threads 20 --save /etc/pacman.d/mirrorlist
```

2. Install essential packages

```bash
pacstrap -K /mnt base base-devel linux linux-firmware intel-ucode grub efibootmgr networkmanager firewalld openssh openssl openvpn man-db man-pages curl wget reflector tmux helix zsh zsh-completions git
```

3. Generate a fstab file

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

4. Change root into the new system

```bash
arch-chroot /mnt
```

5. Change default shell

```bash
chsh /usr/bin/zsh
```

6. Change shell and configure

```bash
zsh
```

7. Persist the time zone

```bash
ln -sf /usr/share/zoneinfo/<Region/City> /etc/localtime
```

7. Run `hwclock` to generate `/etc/adjtime`

```bash
hwclock --systohc
```

6. Edit `/etc/locale.gen`, uncomment `en_US.UTF-8 UTF-8` and generate the locales

```bash
helix /etc/locale.gen
locale-gen
```

7. Create the `locale.conf` file, and set the `LANG` variable accordingly

```bash
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
```

8. Make keyboard layout changes persistent

```bash
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
```

9. Configure the host name of the machine

```bash
echo "ex-machina" >> /etc/hostname
```

10. Enable necessary services

- `systemctl enable NetworkManager.service`
- `systemctl enable firewalld.service`

11. Set root password

```bash
passwd
```

14. Build the initcpio image

```bash
mkinitcpio -p linux
```

15. Configure the bootloader

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

16. Exit and reboot machine

```bash
exit
umount -R /mnt
reboot
```

## Installing and configuring desktop environment

1. Update `vconsole.conf`

```bash
localectl set-keymap br-abnt2
```

2. Create and configure the user

```bash
useradd --create-home --groups wheel --shell /usr/bin/zsh username
visudo # open sudoers file and uncomment wheel group configuration
passwd username
```

3. Exit root account and login into user account

```bash
exit
```

4. Insert USB and copy dotfiles directory to $HOME

```bash
cp /run/media/goofytux/usbname/dotfiles ~/dotfiles
```

5. Go througth the steps in [Setup Dotfiles](/README.md#setup-dotfiles) and [Dependencies installation](/README.md#dependencies-installation) to have a fully integrated editor and shell.

6. Configure pacman

```bash
sudoedit /etc/pacman.conf

# add to /etc/pacman.conf:
# Color=True
# VerbosePkgLists=True
# ParallelDownloads=20
# ILoveCandy=True
```

7. Configure NVIDIA drivers

```bash
sudo pacman -Syu nvidia-open
```

8. Remove `kms` from the `HOOKS` array in `/etc/mkinitcpio.conf` and regenerate the initramfs

```bash
sudo mkinitcpio -p linux
```

9. Configure NVIDIA modeset in kernel parameters located at `/etc/default/grub`

```bash
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia_drm.NVreg_PreserveVideoMemoryAllocations=1"
```

10. Install desktop environment and other packages

```bash
sudo pacman -Syu \
  sway \
  brightnessctl \
  foot \
  grim \
  libpulse \
  mako \
  udiskie \
  polkit \
  swaybg \
  swayidle \
  swaylock \
  i3status \
  wmenu \
  xorg-xwayland \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-wlr
```

11. Reboot system.

## Configure ASUS tools

_Reference:_ [Arch Setup Guide - Asus](https://asus-linux.org/guides/arch-guide)

1. Add asus-linux keys to pacman

```bash
sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
```

2. Add to the end of the `/etc/pacman.conf` file

```bash
[g14]
Server = https://arch.asus-linux.org
```

3. Update the repository and install asus tools

```bash
pacman -Syu asusctl power-profiles-daemon rog-control-center supergfxctl switcheroo-control
```

4. Enable power daemon and the other tools

```bash
systemctl enable --now power-profiles-daemon supergfxd switcheroo-control
```

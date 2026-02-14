# Installing Arch Linux and configuring it the way I like

**Content:**

- [Pre-installation](#pre-installation)
- [Installing the system](#installing-the-system)
- [Installing and configuring desktop environment](#installing-and-configuring-desktop-environment)
- [Configure ASUS tools](#configure-asus-tools)

## Pre-installation

1. Set keyboard layout

```shell
loadkeys br-abnt2
```

2. Connect to the internet

```shell
iwctl --passphrase <passphrase> station <name> connect <SSID>
```

3. Set machine date and hour

```shell
timedatectl set-timezone America/Sao_Paulo
```

4. Partition the disk

| Mount point | Capacity | GPT UUID code |
| ----------- | -------- | ------------- |
| efi         | 1G       | EF00          |
| swap        | 16G      | 8200          |
| /           | ...      | 8304          |

```shell
gdisk </dev/the_disk_to_be_partitioned>
```

5. Format the partitions

```shell
mkfs.ext4 </dev/root_partition>
mkswap </dev/swap_partition>
mkfs.fat -F 32 </dev/efi_system_partition>
```

6. Mount the filesystems

```shell
mount </dev/root_partition> /mnt
mount --mkdir </dev/efi_partition> /mnt/boot
swapon </dev/swap_partition>
```

## Installing the system

1.  Select best pacman mirrors

```shell
sudo reflector \
  --country BR,US \
  --protocol https \
  --sort rate \
  --connection-timeout 3 \
  --download-timeout 3 \
  --threads 20 \
  --save /etc/pacman.d/mirrorlist
```

2. Install essential packages

```shell
pacstrap -K /mnt base base-devel linux linux-firmware intel-ucode networkmanager openssh man-db man-pages curl wget reflector helix git
```

3. Generate a fstab file

```shell
genfstab -U /mnt >> /mnt/etc/fstab
```

4. Change root into the new system

```shell
arch-chroot /mnt
```

5. Persist the time zone

```shell
ln -sf /usr/share/zoneinfo/<Region/City> /etc/localtime
```

6. Run `hwclock` to generate `/etc/adjtime`

```shell
hwclock --systohc
```

7. Edit `/etc/locale.gen`, uncomment `en_US.UTF-8 UTF-8` and generate the locales

```shell
helix /etc/locale.gen
locale-gen
```

8. Create the `locale.conf` file, and set the `LANG` variable accordingly

```shell
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
```

9. Make keyboard layout changes persistent

```shell
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
```

10. Configure the host name of the machine

```shell
echo "ex-machina" >> /etc/hostname
```

11. Enable necessary services

```shell
systemctl enable NetworkManager.service
```

12. Set root password

```shell
passwd
```

13. Build the initcpio image

```shell
mkinitcpio -p linux
```

14. Configure the bootloader

- Add necessary kernel parameters:

```shell
# add to /etc/cmdline.d/root.conf
root=UUID=<root_uuid> rw
```

- Change `/etc/mkinitcpio.d/linux.preset` file:

```shell
#ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux"

PRESETS=('default' 'fallback')

#default_config="/etc/mkinitcpio.conf"
#default_image="/boot/initramfs-linux.img"
default_uki="/boot/EFI/Linux/arch-linux.efi"
default_options="--splash=/usr/share/systemd/bootctl/splash-arch.bmp"

#fallback_config="/etc/mkinitcpio.conf"
#fallback_image="/boot/initramfs-linux-fallback.img"
fallback_uki="/boot/EFI/Linux/arch-linux-fallback.efi"
fallback_options="-S autodetect"
```

- Build the UKI

```shell
mkdir -p /boot/EFI/Linux
mkinitcpio -p linux
```

Optionally, remove any leftover `initramfs-*.img` from `/boot`.

- Configure systemd bootloader

```shell
bootctl install
```

Systemd will automatically read the UKI located in `/boot` directory.

15. Exit system, unmount the filesystems and reboot the machine

```shell
exit
umount -R /mnt
reboot
```

## Installing and configuring desktop environment

1. Update `vconsole.conf`

```shell
localectl set-keymap br-abnt2
```

2. Create and configure the user

```shell
useradd --create-home --groups wheel --shell /usr/bin/bash yourusername
visudo # open sudoers file and uncomment wheel group configuration
passwd yourusername
```

3. Exit root account and login into your user account

```shell
exit
```

4. Configure pacman

```shell
sudoedit /etc/pacman.conf

# add to the file:
# Color=True
# VerbosePkgLists=True
# ParallelDownloads=20
# ILoveCandy=True
```

5. Configure NVIDIA drivers

```shell
sudo pacman -Syu nvidia-open
```

6. Remove `kms` from the `HOOKS` array in `/etc/mkinitcpio.conf` and regenerate the initramfs

```shell
sudo mkinitcpio -p linux
```

7. Configure NVIDIA modeset in kernel parameters

```shell
# add to /etc/cmdline.d/nvidia.conf
nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia_drm.NVreg_PreserveVideoMemoryAllocations=1
```

8. Install desktop environment and other packages

```shell
sudo pacman -Syu \
  gnome \
  pipewire \
  pipewire-alsa \
  pipewire-pulse \
  pipewire-jack
```

9. Reboot system.

## Default applications

Use `xdg-mime` to setup default user applications.

Example:

> Ensure the desktop entry file exists before running the command.

```shell
xdg-mime default my-pdf-opener.desktop application/pdf
```

## Configure ASUS tools

_Reference:_ [Arch Setup Guide - Asus](https://asus-linux.org/guides/arch-guide)

1. Add asus-linux keys to pacman

```shell
sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
```

2. Add to the end of the `/etc/pacman.conf` file

```shell
[g14]
Server = https://arch.asus-linux.org
```

3. Update the repository and install asus tools

```shell
pacman -Syu asusctl power-profiles-daemon rog-control-center supergfxctl switcheroo-control
```

4. Enable power daemon and the other tools

```shell
systemctl enable --now power-profiles-daemon supergfxd switcheroo-control
```

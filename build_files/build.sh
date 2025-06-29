#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux \
    stow

# Use a COPR Example:
#
dnf5 -y copr enable ublue-os/staging
dnf5 -y copr enable ublue-os/packages
dnf5 -y copr enable solopasha/hyprland
dnf5 -y copr enable xeriab/ghostty
dnf5 -y copr enable hazel-bunny/ricing
dnf5 -y copr enable mecattaf/duoRPM 

dnf5 install -y \
    xdg-desktop-portal-hyprland \
    hyprland \
    hyprpaper \
    hyprpolkitagent \
    hyprsysteminfo \
    hyprshot \
    hyprlock \
    hypridle \
    waybar \
    rofi-wayland \
    wlogout \
    cliphist \
    wl-clipboard \
    dunst \
    udiskie \
    kitty \
    wireplumber \
    pavucontrol \
    NetworkManager-tui \
    thunar \
    uwsm \
    grim \
    slurp \
    pamixer \
    breeze-cursor-theme \
    kora-icon-theme \
    lm_sensors \
    fastfetch \
    btop \
    gnome-disk-utility \
    alacritty \
    wayvnc \
    ghostty
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable ublue-os/staging
dnf5 -y copr disable ublue-os/packages
dnf5 -y copr disable solopasha/hyprland
dnf5 -y copr disable xeriab/ghostty
dnf5 -y copr disable hazel-bunny/ricing
dnf5 -y copr disable mecattaf/duoRPM 


#### Example for enabling a System Unit File
cp /ctx/60-openrgb.rules /usr/lib/udev/rules.d/
chmod 644 /usr/lib/udev/rules.d/60-openrgb.rules
#udevadm control --reload-rules
#udevadm trigger
#cp /ctx/nix.conf /usr/lib/tmpfiles.d/nix.conf

#ln -s /var/home/brian<Find>/.local/share/nix /nix

systemctl enable podman.socket

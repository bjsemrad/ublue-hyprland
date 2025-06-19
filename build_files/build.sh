#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

# Use a COPR Example:
#
dnf5 -y copr enable ublue-os/staging
dnf5 -y copr enable ublue-os/packages
dnf5 -y copr enable solopasha/hyprland
dnf5 -y copr enable xeriab/ghostty
dnf5 -y copr enable hazel-bunny/ricing

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
    gnome-disk-utility
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable ublue-os/staging
dnf5 -y copr disable ublue-os/packages
dnf5 -y copr disable solopasha/hyprland
dnf5 -y copr disable xeriab/ghostty
dnf5 -y copr disable hazel-bunny/ricing

#### Example for enabling a System Unit File

export NIX_DEST="/var/lib/nix"

# Download and install Determinate Nix Installer
NIX_INSTALL_DIR=$NIX_DEST curl -L https://install.determinate.systems/nix | bash -s -- install \
  --no-confirm \
  --extra-conf "experimental-features = nix-command flakes" \
  --no-start-daemon

# Set up environment script for new users
mkdir -p /etc/profile.d

cat << EOF > /etc/profile.d/nix.sh
export NIX_INSTALL_ROOT=$NIX_DEST
export PATH=\$NIX_INSTALL_ROOT/bin:\$PATH
export NIX_CONF_DIR=\$NIX_INSTALL_ROOT/etc
export NIX_PATH=nixpkgs=channel:nixos-unstable
source \$NIX_INSTALL_ROOT/etc/profile.d/nix.sh
EOF
chmod +x /etc/profile.d/nix.sh

systemctl enable podman.socket

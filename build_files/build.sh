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

#mkdir -p /nix/var/determinate /root/.nix-profile /nix/var/nix/profiles/default
export NIX_STORE_DIR=/var/lib/nix/store
export NIX_STATE_DIR=/var/lib/nix/var
export NIX_CONF_DIR=/var/lib/nix/etc

# Set install location
# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate

sh <(curl -L https://nixos.org/nix/install) --daemon --yes --destdir /var/lib/nix

#curl -L https://nixos.org/nix/install | bash -s install --daemon --yes --destdir /var/lib/nix

# Add environment to skeleton so new users get it
cat << EOF > /etc/profile.d/nix.sh
export NIX_STORE_DIR=/var/lib/nix/store
export NIX_STATE_DIR=/var/lib/nix/var
export NIX_CONF_DIR=/var/lib/nix/etc
source /var/lib/nix/etc/profile.d/nix.sh
EOF

systemctl enable podman.socket

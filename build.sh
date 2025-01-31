#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

dnf remove -y subscription-manager

dnf -y update

dnf config-manager --set-enabled crb

dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

dnf group install -y "KDE Plasma Workspaces" 

dnf install -y plymouth plymouth-system-theme neofetch

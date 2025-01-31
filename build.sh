#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
curl --retry 3 -Lo "/etc/yum.repos.d/compose.repo" "https://gitlab.com/redhat/centos-stream/containers/bootc/-/raw/c${MAJOR_VERSION_NUMBER}s/cs.repo"
sed -r \
    -e 's@(baseos|appstream)@&-compose@' \
    -e 's@- (BaseOS|AppStream)@& - Compose@' \
    -e 's@/usr/share/distribution-gpg-keys/centos/RPM-GPG-KEY-CentOS-Official@/etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial-SHA256@' \
    -i /etc/yum.repos.d/compose.repo

# This thing slows down downloads A LOT for no reason
dnf remove -y subscription-manager

# The base images take super long to update, this just updates manually for now
dnf -y update

dnf config-manager --set-enabled crb


dnf install -y epel-next-release

dnf group install -y "KDE Plasma Workspaces" 

dnf install -y plymouth plymouth-system-theme neofetch

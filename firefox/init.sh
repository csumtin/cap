#!/bin/bash
set -eux

# make sure we are in ccs directory
cd "$(dirname "$0")"

if [[ $EUID -ne 0  ]]; then
  echo "This script must be run as root"
  exit 1
fi

mkdir bootstrap

debootstrap --arch=amd64 --variant=minbase stable bootstrap

echo "Pick root password"
systemd-nspawn -D bootstrap -M firefox passwd

echo "Add user c and pick password"
systemd-nspawn -D bootstrap -M firefox adduser c

systemd-nspawn -D bootstrap -M firefox -P /bin/bash <<EOT
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends firefox-esr pulseaudio
EOT

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
systemd-nspawn -D bootstrap passwd

echo "Add user c and pick password"
systemd-nspawn -D bootstrap adduser c

systemd-nspawn -D bootstrap -P /bin/bash <<EOT

DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends wget ca-certificates unzip python3-pyqt5.qtwebkit libxt-dev

su - c

wget https://www.gov.uk/government/uploads/uploaded/hmrc/payetools-rti-22.2.22292.290-linux.zip
unzip payetools-rti-22.2.22292.290-linux.zip
rm payetools-rti-22.2.22292.290-linux.zip

echo 'export QT_X11_NO_MITSHM=1' >> .bashrc

EOT

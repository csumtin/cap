#!/bin/bash
set -eux
cd "$(dirname "$0")"
sudo systemd-nspawn -D bootstrap -u c -M google-chrome --setenv=DISPLAY=$DISPLAY --bind-ro=/tmp/.X11-unix --bind=/home/c/download --ephemeral google-chrome

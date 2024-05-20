#!/bin/bash
set -eux
cd "$(dirname "$0")"
sudo systemd-nspawn -D bootstrap -u c -M firefox --setenv=DISPLAY=$DISPLAY --bind-ro=/tmp/.X11-unix --bind=/dev/dri --bind-ro=$XDG_RUNTIME_DIR/pulse:/container$XDG_RUNTIME_DIR/pulse --setenv=PULSE_SERVER=/container/$XDG_RUNTIME_DIR/pulse/native --bind=/home/c/download --ephemeral firefox -no-remote

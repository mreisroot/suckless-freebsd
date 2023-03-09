#!/bin/sh

home=/home/vagrant


pkg update
pkg install -y git
printf "vagrant\nvagrant" | passwd vagrant

# Clone suckless-freebsd script repo
git clone -b dev https://gitlab.com/mreisroot/suckless-freebsd.git "${home}"/suckless-freebsd/

# Run script
cd "${home}"/suckless-freebsd || return
chmod +x ./suckless-freebsd.sh
./suckless-freebsd.sh

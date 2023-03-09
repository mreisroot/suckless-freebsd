#!/bin/sh

# user and home directory
user=vagrant
home=/home/$user

sudo su <<- EOF

  # Variables
  user="$user"
  home="$home"
  dependencies="xorg-minimal xorg-fonts xf86-video-intel libx11 mesa-devel libx11 libxft libxinerama xinit xrdb xrandr unclutter xclip xbacklight redshift rxvt-unicode vim tmux lynx pcmanfm"
  tools="dwm dmenu st slstatus"

  # Upgrade system and install dependencies
  freebsd-update fetch install
  pkg update && pkg upgrade -y
  pkg install -y \$dependencies

  # Clone repos
  for i in \$tools;
  do
    git clone -b freebsd https://gitlab.com/mreisroot/\${i}.git \${home}/.config/src/\${i};
  done

  # Compile tools
  for i in \$tools;
  do
    cd \${home}/.config/src/\${i};

    make clean install;
  done

  # Copy .xinitrc to home directory
  cp \${home}/suckless-freebsd/.xinitrc \${home}/.xinitrc

  # Adjust permissions
  chown -R \${user}:\${user} \${home}/.config
  chown \${user}:\${user} \${home}/.xinitrc

EOF

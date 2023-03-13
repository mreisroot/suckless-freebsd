#!/bin/sh

# user and home directory
set user = $USER
set home = $HOME

su - <<- EOF

  # Variables
  set user = "$user"
  set home = "$home"
  set dependencies = "xorg-minimal mesa-devel libXft libXinerama xinit xrdb xrandr unclutter xclip xbacklight doas password-store pass-otp pkgconf vim tmux lynx wget curl mixertui yt-dlp pipe-viewer cups sane-backends freetype2 redshift rxvt-unicode mpv zathura zathura-ps zathura-pdf-mupdf zathura-djvu pcmanfm-gtk3"
  set tools = "dwm dmenu st slstatus"

  # Upgrade system and install dependencies
  freebsd-update fetch install
  pkg update && pkg upgrade -y
  pkg install -y \$dependencies

  # Install DevOps tools
  printf "\nDo you want to install DevOps tools? (y/n) "
  read -r ans
  if [ \$ans = 'y' || \$ans = 'Y' ]; then
    set devops = "py39-ansible py39-ansible-lint terraform gh glab packer vagrant virtualbox-ose kubectl go"
    pkg install -y \$devops
  fi

  # Install LaTeX
  printf "\nDo you want to install LaTeX? (y/n) "
  read -r ans2
  if [ \$ans2 = 'y' || \$ans2 = 'Y' ]; then
    pkg install -y texlive-full latex-biber
  fi

  # Clone repos
  foreach i (\$tools);
  do
    git clone -b freebsd https://gitlab.com/mreisroot/\${i}.git \${home}/.config/src/\${i};
  done

  # Compile tools
  foreach i (\$tools);
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

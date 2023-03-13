#!/bin/sh 

# user and home directory
set user = $USER
set home = $HOME

su - <<- EOF

  # Variables
  set user = "$user"
  set home = "$home"
  set dependencies = "xorg-minimal xf86-video-intel xf86-input-keyboard xf86-input-mouse mesa-devel libXft libXinerama xinit xrdb xrandr unclutter xclip xbacklight doas password-store pass-otp pkgconf vim tmux lynx wget curl mixertui yt-dlp pipe-viewer cups sane-backends freetype2 redshift rxvt-unicode mpv zathura zathura-ps zathura-pdf-mupdf zathura-djvu pcmanfm-gtk3"
  set tools = "dwm dmenu st slstatus"

  # Upgrade system and install dependencies
  freebsd-update fetch install
  pkg update && pkg upgrade -y
  pkg install -y \$dependencies

  # Install DevOps tools
  #set devops = "py39-ansible py39-ansible-lint terraform gh glab packer vagrant virtualbox-ose kubectl go"
  #pkg install -y \$devops

  # Install LaTeX
  #pkg install -y texlive-full latex-biber

  # Clone repos
  foreach i (\$tools)
    git clone -b freebsd https://gitlab.com/mreisroot/\${i}.git \${home}/.config/src/\${i}
  end

  # Compile tools
  foreach i (\$tools)
    cd \${home}/.config/src/\${i}
    make clean install
  end

  # Adjust permissions
  chown -R \${user}:\${user} \${home}/.config
EOF

# Get dotfiles
git clone https://gitlab.com/mreisroot/dotfiles.git $home
# Link .xinitrc
$home/dotfiles/x11/setup

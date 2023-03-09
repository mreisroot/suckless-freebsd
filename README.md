# Setup script for a Suckless FreeBSD desktop (Work in Progress)

The [suckless-freebsd.sh](./suckless-freebsd.sh) automatically installs some suckless tools on FreeBSD, speeding up the setup process.

The installed tools are:

* dwm
* dmenu
* st
* slstatus

In this project, I'm using the forks I made of these programs, but feel free to use other versions by changing the git repository url on the script file.

## How to use this project

1. Install git

Make sure your machine has git installed:

```sh
sudo pkg update
sudo pkg install -y git
```

2. Clone this project

`git clone https://gitlab.com/mreisroot/suckless-freebsd.git`

or

`git clone https://github.com/mreisroot/suckless-freebsd.git`

3. cd into the script directory

`cd suckless-freebsd`

4. Give the script permission to execute:

`chmod +x suckless-freebsd.sh`

5. Run the script

`./suckless-freebsd.sh`

6. Go to a tty and start Xorg

`startx`

### Testing

If you want to try this script quickly, without having to make a physical installation of FreeBSD, you can use the testing environment I'm providing with the [Vagrantfile](./Vagrantfile) and [provision.sh](./provision.sh) files.

The Vagrantfile has the specifications for the VM to be created.

The testing environment uses the script on the dev branch due to usergroup issues in the `chown` command, which complains that `root` is an illegal group name.

The provision.sh script runs after the VM is created to automatically execute the necessary steps to test the suckless-freebsd.sh script.

1. Make sure you have VirtualBox and Vagrant installed:

* [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Install Vagrant](https://developer.hashicorp.com/vagrant/downloads)

2. Run the following command to create the VM:

`vagrant up`

3. Login credentials

```sh
login: vagrant
password: vagrant
```

4. Starting the window manager

The virtualbox GUI will appear and, after all commands of the provision.sh and suckless-freebsd.sh scripts have been executed, you can test the desktop by running inside the VM:

`startx`

5. To destroy the VM, run:

`vagrant destroy -f`

## Bugs

The [errors.txt](./errors.txt) file contains the output of the provisioning script, which presents compilation errors.

Although I programmed the [suckless-freebsd.sh](./suckless-freebsd.sh) script to install xorg-minimal and some other packages related to x11, it still can't finish the compilation process of the suckless tools successfully, complaining of missing header files, such as sndio.h.

If you know solutions to these problems, please open a pull request.

## License

Licensed under the [GNU General Public License v2.0](./LICENSE)

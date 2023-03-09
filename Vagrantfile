Vagrant.configure("2") do |config|

  # Define provider and allocate resources
  config.vm.provider "virtualbox" do |v|
    v.name = "suckless_freebsd"
    v.cpus = 1
    v.memory = 1024
    v.gui = true
  end

  # Define hostname, OS and networking
  config.vm.hostname = "freebsd"
  config.vm.box = "freebsd/FreeBSD-13.2-STABLE"
  config.vm.network "private_network", ip: "192.168.56.11"

  # Provision VM
  config.vm.provision "shell", path: "provision.sh"

end

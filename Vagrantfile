# -*- mode: ruby -*-
# vi: set ft=ruby :

GENERIC_SCRIPT = "vmSetup.sh"

Vagrant.configure("2") do |config|
    # Common Provider Settings
    
    # config.vm.provision "shell", path: GENERIC_SCRIPT
    # config.ssh.forward_x11 = true

    # config.vm.provider "virtualbox" do |v|
        # v.name = "Sensors Machine"
        # v.gui = true
        # v.customize ["modifyvm", :id, "--memory", 2048] # Increase the memory limit to ~2GB
    # end

    config.vm.synced_folder ".", "/vagrant"

    # Master Machine
    config.vm.define "master" do |master|
        master.vm.box = "generic/ubuntu2004" 
        master.vm.box_version = "3.2.12"
        master.vm.hostname = "master.mkornyev.com"
        master.vm.network "private_network", ip: "10.0.0.200"
        master.vm.provider "virtualbox" do |v|
            v.name = "master"
            # v.gui = true
            # v.memory = 2048
            # v.cpus = 2
        end
        # master.vm.provision :docker
        master.vm.provision :shell, path: GENERIC_SCRIPT
    end

end

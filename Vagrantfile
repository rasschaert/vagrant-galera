# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

###############################################################################
# Base box                                                                    #
###############################################################################
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"

###############################################################################
# Global provisioning settings                                                #
###############################################################################
  # Workaround for https://tickets.puppetlabs.com/browse/MODULES-1303
  config.vm.provision :shell, inline: "sudo yum -y erase firewalld;\
                                       sudo yum -y install iptables-services;\
                                       sudo systemctl enable iptables.service;\
                                       sudo systemctl start iptables.service;"

  config.vm.synced_folder 'hiera/', '/var/lib/hiera'
  config.vm.provision :puppet do |puppet|
    puppet.options = "--environment development"
    puppet.manifests_path = "puppet/environments/development/manifests"
    puppet.manifest_file  = ""
    puppet.module_path = "puppet/modules"
    puppet.hiera_config_path = "puppet/hiera.yaml"
  end

###############################################################################
# Global VirtualBox settings                                                  #
###############################################################################
  config.vm.provider "virtualbox" do |v|
    v.customize [
      "modifyvm", :id,
      "--memory", "512",
      "--cpus", "1",
      "--groups", "/Vagrant/Galera"
    ]
  end

###############################################################################
# VM definitions                                                              #
###############################################################################
  config.vm.define :db01 do |db01|
    db01.vm.hostname = "db01.vagrant.local"
    db01.vm.network :private_network, ip: "172.20.200.101"
    db01.vm.provider("virtualbox") { |v| v.name = "db01" }
  end
  config.vm.define :db02 do |db02|
    db02.vm.hostname = "db02.vagrant.local"
    db02.vm.network :private_network, ip: "172.20.200.102"
    db02.vm.provider("virtualbox") { |v| v.name = "db02" }
  end
  config.vm.define :db03 do |db03|
    db03.vm.hostname = "db03.vagrant.local"
    db03.vm.network :private_network, ip: "172.20.200.103"
    db03.vm.provider("virtualbox") { |v| v.name = "db03" }
  end
end

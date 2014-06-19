# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "guest"
  config.vm.box = "nrel/CentOS-6.5-x86_64"
  config.vm.box_url = "https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140504.box"

  config.vm.network :private_network, ip: "192.168.50.10"

  config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["./cookbooks", "./site-cookbooks"]
    chef.run_list = %w[
      recipe[yum-epel]
      recipe[iptables]
      recipe[nginx]
      recipe[php-env]
    ]
  end
end

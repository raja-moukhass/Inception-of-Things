Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
  config.vm.define "master" do |subconfig|
      subconfig.vm.box = "centos/7"
      subconfig.vm.hostname = "master"
      subconfig.vm.network :private_network, ip: "192.168.42.110"
     
  end
  config.vm.define "slave" do |subconfig|
      subconfig.vm.box = "centos/7"
      subconfig.vm.hostname = "slave"
      subconfig.vm.network :private_network, ip: "192.168.42.111"
     
  end
end

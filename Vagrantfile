Vagrant.configure("2") do |config|

  config.vm.define "master" do |master|
    master.vm.box = "centos/7"
    master.vm.hostname = "master"
    master.vm.provider "virtualbox" do |v|
        v.name = "Sramoukha1"
        v.memory = 1024
        v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  config.vm.network :private_network, ip: "192.168.42.110"
    end
  end
  config.vm.define "slave" do |slave|
    slave.vm.box = "centos/7"
    slave.vm.hostname = "slave"
    slave.vm.provider "virtualbox" do |v|
        v.name = "SWamoukha2"
        v.memory = 1024
        v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  config.vm.network :private_network, ip: "192.168.42.111"
    end
  end

end





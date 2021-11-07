Vagrant.configure("2") do |config|
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.define "master" do |master|
    master.vm.box = "centos/7"
    master.vm.hostname = "master"
    master.vm.provider "virtualbox" do |v|
        v.name = "Sramoukha1"
  config.vm.network :private_network, ip: "192.168.42.110"
    end
  end
  config.vm.define "slave" do |slave|
    slave.vm.box = "centos/7"
    slave.vm.hostname = "slave"
    slave.vm.provider "virtualbox" do |v|
        v.name = "SWamoukha2"
        
  config.vm.network :private_network, ip: "192.168.42.111"
    end
  end
  

end





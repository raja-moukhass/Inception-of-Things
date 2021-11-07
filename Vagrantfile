IMAGE = "centos/8"
MEM = 1024
CPU = 1
MASTER_NAME = "login1S"
WORKER_NAME = "login2SW"
MASTER_IP = "192.168.42.110"
WORKER_IP = "192.168.42.111"

Vagrant.configure("2") do |config|
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = MEM
    vb.cpus = CPU
  	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  	vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.define MASTER_NAME do |master|
    master.vm.box = IMAGE
    master.vm.hostname = MASTER_NAME
    master.vm.network :private_network, ip: MASTER_IP
	  master.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"
	  master.vm.provision "shell", privileged: true, path: "scripts/master_install.sh"
    master.vm.provider "virtualbox" do |v|
      v.name = MASTER_NAME
    end    
  end
  
  config.vm.define WORKER_NAME do |worker|
    worker.vm.box = IMAGE
    worker.vm.hostname = WORKER_NAME
  	worker.vm.network :private_network, ip: WORKER_IP 
	  worker.vm.provision "file", source: "~/.ssh/id_rsa", destination: "/tmp/id_rsa"
	  worker.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"
	  worker.vm.provision "shell", privileged: true, path: "scripts/worker_install.sh"
    worker.vm.provider "virtualbox" do |v|
      v.name = WORKER_NAME
    end
  end

end

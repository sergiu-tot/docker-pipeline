# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vbguest.auto_update = true
  config.vm.synced_folder ".", "/mnt/host_machine", create: true

  config.vm.provider :virtualbox do |vb|
      vb.name = "jenkins"
      vb.memory = "2048"
  end

  config.vm.provision "shell" do |s|
    s.path = "provision.sh"
  end
end

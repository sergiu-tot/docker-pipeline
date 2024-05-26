# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false

  # Jenkins host
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "ubuntu/jammy64"
    jenkins.vm.network "forwarded_port", guest: 80, host: 8080
    jenkins.vm.hostname = "jenkins"
    
    jenkins.vm.synced_folder ".", "/mnt/host_machine", create: true
  
    jenkins.vm.provider :virtualbox do |vb|
        vb.name = "jenkins"
        vb.memory = "4096"
    end
  
    config.vm.provision "shell" do |s|
      s.path = "provision.sh"
    end  
  end

end

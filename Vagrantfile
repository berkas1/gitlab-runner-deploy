# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "debian/jessie64"

  config.vm.provider "virtualbox" do |v|
    v.name = "gitlab_runner"
  end



   config.vm.provider "virtualbox" do |vb|
     vb.memory = "2024"
     vb.cpus = 2
   end

  config.vm.provision "shell", path: "deploy.sh"
end


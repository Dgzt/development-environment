VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "generic/arch"
  
  config.vm.provider "virtualbox" do |vb|
    vb.name = "archlinux"
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    # Customize the amount of memory on the VM:
    vb.memory = "4096"

    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
	
	# Set the amount of RAM, in MB, that the VM should allocate for itself, from the host
    vb.customize ["modifyvm", :id, "--vram", "128"]
	
	# Allow the VM to display the desktop environment
	vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxsvga"]
	
	# Enable, if Guest Additions are installed, whether hardware 3D acceleration should be available
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  end
  
  config.vm.provision "file", source: ".variables", destination: "/home/vagrant/.variables"
  config.vm.provision "shell", path: "bootstrap.sh"

end

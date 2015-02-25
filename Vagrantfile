# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

required_plugins = %w( vagrant-berkshelf vagrant-omnibus omnibus )
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = 'clojure-stack-berkshelf'

  # Set the version of chef to install using the vagrant-omnibus plugin
  # NOTE: You will need to install the vagrant-omnibus plugin:
  #
  #   $ vagrant plugin install vagrant-omnibus
  #
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = 'latest'
  end

  # Every Vagrant virtual environment requires a box to build off of.
  # If this value is a shorthand to a box in Vagrant Cloud then
  # config.vm.box_url doesn't need to be specified.
  config.vm.box = 'chef/ubuntu-14.04'


  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :private_network, type: 'dhcp'
  # config.vm.network :forwarded_port, guest: 3000, host: 3000
  # config.vm.network :forwarded_port, guest: 5000, host: 5000
  # config.vm.network :forwarded_port, guest: 8080, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "2048`"]
  end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []


  config.vm.provision :chef_solo do |chef|
    chef.json = {
      rvm: {
        rubies: ["2.1.5"],
        default_ruby: "2.1.5",
        vagrant: { system_chef_solo: "/opt/chef/bin/chef-solo" }
      },
      :nginx => {
        :version => "1.6.2",
        :dir => "/etc/nginx",
        :log_dir => "/var/log/nginx",
        :binary => "/opt/nginx-1.6.2/sbin",
        :init_style => "init",
        :source => {
          :modules => ['clojure-stack::nginx_clojure'],
          :checksum => "b5608c2959d3e7ad09b20fc8f9e5bd4bc87b3bc8ba5936a513c04ed8f1391a18"
        }
      },
      clojure_apps: [
        {
          name: 'hello',
          port: '8080', 
          ubarjar: '/home/vagrant/hello-world/target/hello-world-0.1.0-SNAPSHOT.jar',
          handler: 'hello-world.core/handler' 
        }
      ],
      "java" => {
        "install_flavor" => "oracle",
        "jdk_version" => "7",
        "oracle" => {
          "accept_oracle_download_terms" => true
        }
      }
    }

    chef.run_list = [
      'recipe[clojure-stack::default]'
    ]
  end
end


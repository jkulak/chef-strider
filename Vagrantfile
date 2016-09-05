# -*- mode: ruby -*-
# vi: set ft=ruby :

MACHINE_NAME = "stridercd-kitchen"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Lock Chef version
  config.omnibus.chef_version = :latest #"12.5.1"

  # Fix to: https://github.com/mitchellh/vagrant/issues/1673
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  # config.ssh.pty = true
  config.ssh.forward_agent = true

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  config.vm.hostname = MACHINE_NAME

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.auto_detect = true
    config.cache.scope = :box
  end

  config.vm.provider "virtualbox" do |vb|
    vb.name = MACHINE_NAME

    vb.memory = 2000
    vb.cpus = 1
  end

  # Configure networking
  config.vm.network :private_network, ip: "192.168.2.25"

  # Load configuration from Chef's local.json environment definition
  config_json = JSON.parse(File.read("./hosts.json"))

  # Don't sync current directory
  config.vm.synced_folder ".", "/vagrant", disabled: true
  # Sync code directories
  # config.vm.synced_folder "../example.com.dev",   "/code/example.com.dev"

  # Configure provisioning
  config.vm.provision "chef_solo" do |chef|

      chef.log_level = :info
      chef.data_bags_path = "./data_bags"
      chef.environments_path = "./environments"
      chef.roles_path = "./roles"

      chef.run_list = [
          "recipe[jku-strider::default]"
      ]
      chef.json = {
          # authorization - Add vagrant user back to sudoers after 'sudo' cookbook removes it
          "authorization" => {
              "sudo" => {
                  "users" => [ "vagrant" ],
                  "passwordless" => true,
              }
          }
      }
  end

  # Enable vagrant-hostsupdater support, if the plugin is installed
  # see https://github.com/cogitatio/vagrant-hostsupdater for details
  if Vagrant.has_plugin?("vagrant-hostsupdater")
    config.hostsupdater.aliases = []

    config_json["add_to_local_hosts"].each do |host|

      config.hostsupdater.aliases.push(host)
      # if vhost["alias"]
      #   vhost["alias"].each do |alias_url|
      #     config.hostsupdater.aliases.push(alias_url)
      #   end
      # end
    end
  end

  config.vm.provision "shell", privileged: false, inline: <<-EOF
    echo "Welcome!"
    # echo "Local server address is http://#{config_json["hosts"]}"
  EOF
end

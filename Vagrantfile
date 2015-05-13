# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

###############################################################################
# Base box                                                                    #
###############################################################################
    config.vm.box = "puppetlabs/centos-6.6-64-puppet"

###############################################################################
# Global plugin settings                                                #
###############################################################################
    plugins = ["vagrant-hostmanager"]
    plugins.each do |plugin|
      unless Vagrant.has_plugin?(plugin)
        raise plugin << " has not been installed."
      end
    end

    # Configure cached packages to be shared between instances of the same base box.
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :machine
    end

###############################################################################
# Global provisioning settings                                                #
###############################################################################
    default_env = 'XS'
    ext_env = ENV['VAGRANT_PUPPET_ENV']
    env = ext_env ? ext_env : default_env
    PUPPET    = "sudo puppet agent -t --environment #{env} --server puppetmaster.ipa.vagrant; echo $?"

###############################################################################
# Global VirtualBox settings                                                  #
###############################################################################
    config.vm.provider 'virtualbox' do |v|
    v.customize [
      'modifyvm', :id,
      '--groups', '/Vagrant/ipa'
    ]
    end

###############################################################################
# Global /etc/hosts file settings                                                  #
###############################################################################
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

###############################################################################
# VM definitions                                                              #
###############################################################################
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.define :puppetmaster do |puppetmaster_config|
      puppetmaster_config.vm.host_name = "puppetmaster.ipa.vagrant"
      puppetmaster_config.vm.network :private_network, ip: "192.168.21.130"
      puppetmaster_config.vm.synced_folder 'manifests/', "/etc/puppet/environments/#{env}/manifests"
      puppetmaster_config.vm.synced_folder 'modules/', "/etc/puppet/environments/#{env}/modules"
      puppetmaster_config.vm.synced_folder 'hiera/', '/var/lib/hiera'
      puppetmaster_config.vm.synced_folder 'files/', '/opt/files'
      puppetmaster_config.vm.provision :shell, inline: 'sudo cp /opt/files/hiera.yaml /etc/puppet/hiera.yaml'
      puppetmaster_config.vm.provision :shell, inline: 'sudo cp /opt/files/autosign.conf /etc/puppet/autosign.conf'
      puppetmaster_config.vm.provision :puppet do |puppet|
          puppet.options = "--environment #{env}"
          puppet.manifests_path = "manifests"
          puppet.manifest_file  = ""
          puppet.module_path = "modules"
          puppet.hiera_config_path = "files/hiera.yaml"
      end
    end

    config.vm.define :office do |office_config|
      office_config.vm.box = "puppetlabs/centos-7.0-64-puppet"
      office_config.vm.host_name = "office.ipa.vagrant"
      office_config.vm.network :forwarded_port, guest: 22, host: 2140
      office_config.vm.network :private_network, ip: "192.168.21.140"
      office_config.vm.synced_folder 'files/', '/opt/files'
      office_config.vm.provision :shell, inline: 'sudo cp /opt/files/hosts /etc/hosts'
      office_config.vm.provision 'shell', inline: PUPPET
    end

    config.vm.define :club do |club_config|
      club_config.vm.host_name = "club.ipa.vagrant"
      club_config.vm.network :forwarded_port, guest: 22, host: 2150
      club_config.vm.network :private_network, ip: "192.168.21.150"
      club_config.vm.provision 'shell', inline: PUPPET
    end

    config.vm.define :lounge do |lounge_config|
      lounge_config.vm.host_name = "lounge.ipa.vagrant"
      lounge_config.vm.network :forwarded_port, guest: 22, host: 2151
      lounge_config.vm.network :private_network, ip: "192.168.21.151"
      lounge_config.vm.provision 'shell', inline: PUPPET
    end
end

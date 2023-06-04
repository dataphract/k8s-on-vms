# -*- mode: ruby -*-
# vi: set ft=ruby :

def make_ip(n)
  "10.240.0.#{n}"
end

boxes = [
  (0..2).map do |i|
    {
      :name => "etcd-#{i}",
      :eth1 => make_ip(11 + i),
      :cpus => 2,
      :memory => 512,
      :disk => "4G",
      :script => "etcd-setup.sh",
    }
  end,
  # (0..1).map do |i|
  #   {
  #     :name => "controller-#{i}",
  #     :eth1 => make_ip(21 + i),
  #     :cpus => 2,
  #     :memory => 512,
  #     :disk => "4G",
  #   }
  # end,
  # (0..2).map do |i|
  #   {
  #     :name => "worker-#{i}",
  #     :eth1 => make_ip(31 + i),
  #     :cpus => 2,
  #     :memory => 1024,
  #     :disk => "20G",
  #   }
  # end,
  # (0..1).map do |i|
  #   {
  #     :name => "lb-#{i}",
  #     :eth1 => make_ip(41 + i),
  #     :cpus => 2,
  #     :memory => 512,
  #     :disk => "4G",
  #   }
  # end,
].flatten

$common_setup = <<-SCRIPT
echo "Updating package lists..."
sudo apt-get update
echo "Upgrading packages..."
sudo apt-get upgrade
echo "Installing cfssl..."
sudo apt-get install golang-cfssl
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  # Disable synced folder
  config.vm.synced_folder '.', '/vagrant', disabled: true

  boxes.each do |opts|
    config.vm.define opts[:name] do |cfg|
      cfg.vm.hostname = opts[:name]

      cfg.vm.network :private_network, :ip => opts[:eth1]

      cfg.vm.provider :virtualbox do |vbox|
        vbox.cpus = opts[:cpus]
        vbox.memory = opts[:memory]
      end

      cfg.vm.provision :shell, inline: $common_setup
      cfg.vm.provision :shell, path: opts[:script]
    end
  end
end

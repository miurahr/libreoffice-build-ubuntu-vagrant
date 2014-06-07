# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "trusty"

  config.vm.provider :virtualbox do |vb, override|
   override.vm.box     = "ubuntu/trusty64"
  end

  config.vm.provider :kvm do |kvm, override| 
    kvm.gui = true
    override.vm.box     = "trusty"
    override.vm.box_url = "https://vagrant-kvm-boxes-si.s3.amazonaws.com/trusty64-kvm-20140418.box"
  end

  config.vm.synced_folder "/tmp", "/var/tmp/lo", type: "nfs"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end

  config.vm.provision :shell, inline: <<-SH
    set -x
    export DEBIAN_FRONTEND=noninteractive
    export TMPDIR=/var/tmp/lo
    apt-get update
    apt-get -y install git autoconf automake make
    apt-get -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
    apt-get -y build-dep libreoffice
    git clone --depth 1 git://gerrit.libreoffice.org/core libreoffice
    cd libreoffice
    ./autogen.sh --enable-dbgutil --without-java --without-help --without-myspell-dicts --with-lang=ALL
    make
  SH

end

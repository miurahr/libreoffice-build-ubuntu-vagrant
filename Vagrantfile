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
    kvm.memory_size = "4gb"
    # 9p cause git problem.
    override.vm.synced_folder ".", "/vagrant", type: "nfs"
  end

  # If you want to add more disk space for compilation.
  # Please check and update environment variable TMPDIR also.
  #
  #config.vm.synced_folder "/var/tmp/libreoffice", "/var/tmp/libreoffice"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end

  config.vm.provision :shell, inline: <<-SH1
    set -x
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get -y install git autoconf automake make
    apt-get -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
    apt-get -y build-dep libreoffice
  SH1

  config.vm.provision :shell, privileged: false, inline: <<-SH2
    set -x
    #
    #export TMPDIR=/var/tmp/libreoffice
    #
    LOGIT_REPO=git://gerrit.libreoffice.org/core
    BUILD_GEN="--without-java --without-help --without-myspell-dicts"
    BUILD_DEBUG="--enable-dbgutil"
    BUILD_LANG="--with-lang=ALL"
    BUILD_SRC="--with-referenced-git=/vagrant/libreoffice --with-external-tar=/vagrant/libreoffice/src"
    BUILD_BRANCH="master"
    #
    cd /home/vagrant
    git clone --reference /vagrant/libreoffice --branch $BUILD_BRANCH $LOGIT_REPO libreoffice
    cd libreoffice
    ./autogen.sh $BUILD_GEN $BUILD_DEBUG $BUILD_LANG $BUILD_SRC
    make
  SH2

end

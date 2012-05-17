

### Instalar minimal

    # Mac: kickstart server
    sudo httpd -k start
    curl http://localhost/ks62-3.cfg
    
    # Mac: create a new Virtualbox machine
    ./vbox-linux-server.sh centos62-ks
    
    # VirtualBox:
    [tab]
    linux text ks=http://10.0.2.2/ks62.cfg
    
    # Mac: pack a box for later reuse
    vagrant package --base   centos62-ks \
                    --output centos-6.2-x86_64-ks-01.box
    vagrant box add centos62-ks-01 centos-6.2-x86_64-ks-01.box
    
    
### Configurar VBoxAdditions

    # Mac: create a working machine
    vagrant init centos62-ks-01
    vagrant ssh
    
    # Linux: rpm's from cdrom
    mkdir -p /media/CentOS
    mount /dev/cdrom /media/CentOS
    
    # Linux: rpm's: build
    alias yum='yum --disablerepo=\* --enablerepo=c6-media'
    yum install -y gcc cpp glibc-headers glibc-devel make \
                   kernel-headers kernel-devel perl

    ###
    ### Linux: scp
    ###     (Vbox additions: inside virtualbox installation dir)
    ###
    scp marcus@10.0.2.2:/pub/downloads/vbox/VBoxLinuxAdditions-4.1.12-77245.run .
    
    ./VBoxLinuxAdditions-4.1.12-77245.run
    
    reboot
    
    ###
    ### Linux: cleanup
    ###
    rm /root/VBoxLinuxAdditions-4.1.12-77245.run
    yum remove -y gcc cpp glibc-headers glibc-devel make \
                  kernel-headers kernel-devel libgomp
                  
    /bin/rm ./VBoxLinuxAdditions-4.1.12-77245.run
    
    #
    # Mac: Package a new machine: centos62-vboxadd
    #
    VBoxManage list vms # get current vagrant working box
    vagrant package --base box_name_123456 \
                    --output centos-6.2-x86_64-boxadd.box
    vagrant box add centos62-boxadd centos-6.2-x86_64-boxadd.box
        
### Config Base Machine

    # Mac: create a working machine
    #    using new box to install RPMS
    cd rpm-build/
    vagrant init centos62-vboxadd
    vagrant ssh
        
    # vagrant: install rpms
    
    sudo su -
    cd /vagrant/RPMS/
    rpm -ivh ruby
    rpm -ivh rvm
    rpm -ivh vim
    rpm -ivh puppet
    rpm -ivh bootstrap-setup
    rpm -ivh htop
    
    #
    # Mac: Package a new machine: centos62-vboxadd
    #
    VBoxManage list vms    # get current vagrant working box
    vagrant package --base   rpm-build_133343483 \
                    --output centos-6.2-x86_64-base-01.box
    vagrant box add centos62-base-01 ./centos-6.2-x86_64-base-01.box

    # Done!
    
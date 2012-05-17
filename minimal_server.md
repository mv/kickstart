

### Instalar minimal

    # Mac: kickstart server
    sudo httpd -k start
    curl http://localhost/ks62.cfg
    
    # Mac: create a new Virtualbox machine
    ./vbox-linux-server.sh centos62-new
    
    # VirtualBox:
    [tab]
    linux text ks=http://10.0.2.2/ks62.cfg
    
    
### Configurar VBoxAdditions

    # Virtual machine: centos62-new
    
    ###
    ### Linux: rpm's from cdrom
    ###
    mkdir -p /media/CentOS
    mount /dev/cdrom /media/CentOS
    
    ###
    ### Linux: rpm's: build
    ###
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
    yum remove -y 
    
    ###
    ### Mac: Package a new machine: centos62-vboxadd
    ###
    vagrant package --base centos62-ks2 --output centos62-vboxadd.box
    
### Config Base Machine

    ###
    ### Mac: creating a box
    ###
    vagrant box add centos62-vboxadd ./centos62-vboxadd.box


    ###
    ### using new box to install RPMS
    ###
    cd rpm-build/
    vagrant init centos62-vboxadd
    vagrant ssh
    
    # vagrant: install rpms
    
    sudo su -
    rpm -ivh ruby
    rpm -ivh pupept
    rpm -ivh rvm
    rpm -ivh vim
    rpm -ivh ruby
    rpm -ivh bootstrap-setup
    rpm -ivh htop
    
    # Mac: packaging base
    
    ###
    ### My current working machine
    ###
    VboxMachine list vms
    
    ###
    ### current working machine -> base machine
    ###
    vagrant package --base   cento62-vboxadd_1337199183 \
                    --output centos-6.2-x86_64-base-01.box
    vagrant box add centos62-base-01 ./centos-6.2-x86_64-base-01.box
    
    # Done!
    
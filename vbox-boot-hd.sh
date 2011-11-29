#!/bin/bash
#
# vbox-boot-dvd.sh
#     VirtualBox: setting boot device
#
# 2011/11
# Marcus Vinicius Ferreira               ferreira.mv[ at ]gmail.com
#

[ -z "$1" ] && {
    echo
    echo "Usage: $0 <machine_name>"
    echo
    exit 2
}

machine_name="$1"

#
# Boot order
#
VBoxManage modifyvm $machine_name --boot1 disk --boot2 none --boot3 none --boot4 none


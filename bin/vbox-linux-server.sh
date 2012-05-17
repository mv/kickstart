#!/bin/bash
#
# vbox-linux-server.sh
#     VirtualBox: new linux server
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

dvd="/pub/_iso/linux/CentOS-5.7-x86_64-bin-DVD/CentOS-5.7-x86_64-bin-1of8.iso"
dvd="/pub/iso/centos57/CentOS-5.7-x86_64-bin-DVD-1of2.iso"
dvd="/pub/iso/centos58/CentOS-5.8-x86_64-bin-DVD-1of2.iso"
dvd="/pub/iso/centos62/CentOS-6.2-x86_64-bin-DVD1.iso"

machine_dir="/VMachine"
machine_name="$1"

#
# New Machine
#
VBoxManage createvm \
    --name $machine_name    \
    --ostype Linux26_64     \
    --register

#
# Server settings
#
VBoxManage modifyvm          \
    $machine_name            \
    --memory 512             \
    --vram       5           \
    --acpi       off         \
    --ioapic     on          \
    --pae        off         \
    --nestedpaging on        \
    --largepages   off       \
    --vtxvpid      on        \
    --cpus         2         \
    --rtcuseutc    on        \
    --monitorcount       1   \
    --accelerate3d       off \
    --accelerate2dvideo  off \
    --firmware bios          \
    --chipset  piix3         \
    --boot1    dvd           \
    --boot2    disk          \
    --boot3    none          \
    --boot4    none          \
    --mouse    ps2           \
    --keyboard ps2           \
    --uart1    off           \
    --uart2    off           \
    --audio    none          \
    --usb      off           \
    --usbehci  off           \
    --vrde     off           \
    --teleporter off         \
    # --nictype1         Am79C970A \
    # --nic2             hostonly  \
    # --hostonlyadapter2 vboxnet0  \
    # --nictype2         82540EM   \
    # --cableconnected2  on        \


#
# SATA disk: 20G
#
VBoxManage createhd         \
    --filename ${machine_dir}/${machine_name}/${machine_name}.vmdk  \
    --size   10240          \
    --format  VMDK          \
    --variant Standard

VBoxManage storagectl   \
    $machine_name       \
    --name "SATA Controller" \
    --add sata               \
    --controller IntelAhci   \
    --sataportcount 1        \
    --bootable on

VBoxManage storageattach            \
    $machine_name                   \
    --storagectl "SATA Controller"  \
    --port 0             \
    --type hdd --medium ${machine_dir}/${machine_name}/${machine_name}.vmdk

#
# DVD image to boot
#
VBoxManage storagectl       \
    $machine_name           \
    --name "IDE Controller" \
    --add ide               \
    --bootable on

VBoxManage storageattach            \
    $machine_name                   \
    --storagectl "IDE Controller"   \
    --device 1 --port 1             \
    --type dvddrive --medium "$dvd"




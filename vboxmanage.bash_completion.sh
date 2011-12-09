#
# VirtualBox command line
#     http://www.virtualbox.org/
#
# Marcus Vinicius Fereira            ferreira.mv[ at ].gmail.com
# 2011-11
#

_vboxmanage() {

    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    #
    #  VBoxManage installed ?
    #
    [ -x $( which VBoxManage ) ] || return 0

    case "${prev}" in
        list)
            opts="vms runningvms ostypes hostdvds hostfloppies bridgedifs hostonlyifs dhcpservers hostinfo hostcpuids hddbackends hdds dvds floppies usbhost usbfilters systemproperties extpacks"
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
            ;;
        setproperty)
            opts="machinefolder vrdeauthlibrary websrvauthlibrary vrdeextpack loghistorycount"
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
            ;;
        guestproperty)
            opts="get set enumerate wait"
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
            ;;
        sharedfolder)
            opts="add remove"
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
            ;;
        clonehd|convertfromraw|modifyhd|showhdinfo)
            list=$( VBoxManage list hdds | egrep '^UUID|^Location' | awk '{print $2}' | sort )
            COMPREPLY=( $(compgen -W "${list}" -- ${cur}) )
            return 0
            ;;
        closemedium)
            list=$( (VBoxManage list hdds ; VBoxManage list floppies ; VBoxManage list dvds) | egrep '^UUID|^Location' | awk '{print $2}' | sort )
            COMPREPLY=( $(compgen -W "${list}" -- ${cur}) )
            return 0
            ;;
        adoptstate|bandwidthctl|clonevm|controlvm|debugvm|discardstate|export|guestcontrol|\
        modifyvm|showvminfo|snapshot|startvm|storage*|unregistervm)
            vms=$( VBoxManage list vms | awk '{print $1}' | sed -e 's/"//g' )
            COMPREPLY=( $(compgen -W "${vms}" -- ${cur}) )
            return 0
            ;;
    esac

    # default
    local actions=$( VBoxManage | grep VBoxManage | awk {'print $2'} | grep -v '\-\-' | sort | uniq )
    COMPREPLY=( $(compgen -W "${actions}" -- ${cur}) )
    return 0
}

complete -F _vboxmanage VBoxManage
complete -F _vboxmanage vboxmanage
complete -F _vboxmanage vbm

# vim:ft=sh:


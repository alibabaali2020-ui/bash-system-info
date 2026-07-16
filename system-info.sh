#!/bin/bash

# ==========================================
# Project : System Information
# Author  : Ali
# Version : 1.0
# ==========================================
set -o errexit
set -o nounset

#Variables
hostname=$(hostname)
current_User=$(whoami)
operating_System=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d"=" -f2 | tr -d '"')
kernel_Version=$(uname -r)
architecture=$(uname -m)
uptime=$(uptime -p)
current_Date=$(date "+%Y-%m-%d %H:%M:%S")
#----------------
cpu_model=$(lscpu | grep "^Model name" | cut -d":" -f2 | xargs)
cpu_cores=$(nproc)
#----------------
total_ram=$(free -h | awk '/^Mem/ {print$2}')
used_ram=$(free -h | awk '/^Mem/ {print$3}')
free_ram=$(free -h | awk '/^Mem/ {print$4}')
#----------------
disk_total=$(df -h / | awk 'NR==2 {print$2}')
disk_used=$(df -h / | awk 'NR==2 {print$3}')
disk_free=$(df -h / | awk 'NR==2 {print$4}')
#----------------
ip_address=$(hostname -I | awk '{print $1}')
default_gateway=$(ip route | awk '/default/ {print $3}')
dns_server=$(grep "^nameserver" /etc/resolv.conf | awk '{print $2}' | head -1)
#----------------

title(){
    echo "==============================
       $1
=============================="
}

system_info() {
    title "SYSTEM INFORMATION"
    echo "Hostname         : $hostname "
    echo "Current User     : $current_User "
    echo "Operating System : $operating_System"
    echo "Kernel Version   : $kernel_Version "
    echo "Architecture     : $architecture"
    echo "Uptime           : $uptime "
    echo "Current Date     : $current_Date "
    echo "Shell            : $SHELL"
    echo
}

cpu_info(){
    title "CPU INFORMATION"
    echo "CPU Model        : $cpu_model"
    echo "CPU Cores        : $cpu_cores"
    echo
}
ram_info(){
    title "RAM INFORMATION"
    echo "Total RAM        : $total_ram"
    echo "Used RAM         : $used_ram"
    echo "Free RAM         : $free_ram"
    echo
}
disk_info(){
    title "DISK INFORMATION"
    echo "Disk Total       : $disk_total"
    echo "Disk Used        : $disk_used"
    echo "Disk Free        : $disk_free"
    echo
}
net_info(){
    title "NETWORK INFORMATION"
    echo "IP Address       : $ip_address"
    echo "Default Gateway  : $default_gateway"
    echo "DNS Server       : $dns_server"
    echo
}

main(){
   system_info
    cpu_info
    ram_info
    disk_info
    net_info 
}

main

arch=$(uname -a)
pcpu=$(lscpu | grep "CPU(s)" | head -1 | awk '{print $2}')
vcpu=$(cat /proc/cpuinfo | grep "cpu cores" | awk '{print $4}')
umem=$(free -m | grep "Mem" | awk '{print $3}')
fmem=$(free -m | grep "Mem" | awk '{print $4}')
pmem=$(free -m | grep "Mem" | awk '{printf("%.2f%%"), $3/$2*100}')
tmp=$(who | tail -c 17)
adisk=$(df / | tail -1 | awk '{printf("%i"), $4/1000}')
tdisk=$(df -h / | tail -1 | awk '{print $3+$4}')
pdisk=$(df / | tail -1 | awk '{print $5}')
lcpu=$(top -bn1 | grep '^%Cpu' | cut -c 9- | awk '{printf("%.1f%%"), $1+$3}')
clvm=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
ntcp=$(ss -t | wc -l)
ulog=$(w -h | wc -l)
ip=$(hostname -I)
mac=$(ip a | grep "ether"| awk '{print $2}')
cmd=$(journalctl _COMM=sudo -q | grep COMMAND | wc -l)
wall "  #Architecture: $arch
        #CPU physical: $pcpu
        #vCPU: $vcpu
        #Memory Usage: $umem/${fmem}MB ($pmem)
        #Disk Usage: $adisk/${tdisk}Gb ($pdisk)
        #CPU load: $lcpu
        #Last boot: $tmp
        #LVM use: $clvm
        #Connections TCP: $ntcp ESTABLISHED
        #User log: $ulog
        #Network: IP $ip($mac)
        #Sudo: $cmd cmd"

#!bin/bash
function_collector() {
	echo "$ip will be start collecting data"
	snmpget -v 2c -c xxx $ip sysDescr.0 sysName.0 > result.txt
	hostname="$(cat result.txt | tail -1 | cut -c 33-100)"
	for line in $(cat list_brand.txt); 
		do 
			brand="$(cat result.txt | grep -i $line | wc -l)"
			brand1="$(cat result.txt | head -1 | sed -e "s/^.*\(.\)$/\1/")"
			if [ $brand -gt 0 ]
			then
				echo "$ip $line $hostname" >> brand.txt
			elif 
				[[ "$brand1" == "J" ]]
			then
				brand_1="Juniper"
				if [[ "$brand_1" == "$line" ]]
				then
					echo "$ip $line $hostname" >> brand.txt
				fi
			fi

	done
}

while IFS= read -r ip; do #open file and store to variable ip

    if ping -q -W 1 -c2 "$ip" &>/dev/null; then #confition
    	function_collector
    	echo "$ip has been done collected $hostname"
    else
        echo "$ip unreachable"  #result if devices down
    fi

done </home/xxxx/xxxx/ip.txt

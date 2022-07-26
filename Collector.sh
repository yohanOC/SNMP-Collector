#!bin/bash
function_collector() {
	echo "$ip will be start collecting data"
	snmpwalk -v 2c -c xxx $ip sysDescr.0 > result.txt
	snmpwalk -v 2c -c xxx $ip sysName.0 > hostname.txt
	hostname="$(cut hostname.txt -c 33-100)"
	brand1="$(cat result.txt | grep -i brand1 | wc -l)"
	brand2="$(cat result.txt | grep -i brand2 | wc -l)"
	brand3="$(cat result.txt | grep -i brand3 | wc -l)"
	brand4="$(cat result.txt | grep -i brand4 | wc -l)"
	brand5="$(cat result.txt | grep -i brand5 | wc -l)"
	brand6="$(cat result.txt | sed -e "s/^.*\(.\)$/\1/")"

	if  
	[ $brand1-gt 0 ]
	then
		echo "$ip brand1 $hostname" >> brand.txt
	elif 
	[ $brand2 -gt 0 ]
	then
		echo "$ip brand2 $hostname" >> brand.txt
	elif 
	[ $brand3 -gt 0 ]
	then
		echo "$ip brand3 $hostname" >> brand.txt
	elif
	[ $brand4 -gt 0 ]
	then
		echo "$ip brand4 $hostname" >> brand.txt
	elif
	[ $brand5 -gt 0 ]
	then
		echo "$ip brand5 $hostname" >> brand.txt
	elif
	[[ "$brand6" == "J" ]]
	then 
		echo "$ip brand6 $hostname" >> brand.txt
	fi
}

while IFS= read -r ip; do #open file and store to variable ip

    if ping -q -W 1 -c2 "$ip" &>/dev/null; then #confition
    	function_collector
    	echo "$ip has been done collected $hostname"
    else
        echo "$ip unreachable"  #result if devices down
    fi

done </home/xxxx/xxxx/ip.txt

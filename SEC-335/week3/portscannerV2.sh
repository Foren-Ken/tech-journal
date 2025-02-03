#!/bin/bash

checkvalid() { # This function is responsible for checking the valdiity of the  IP address provided
	local ip=$1
	local segments=$2 # Checks how many octets is expected
	if [[ $ip =~ ^([0-9]{1,3}\.){$((segments+0))}[0-9]{1,3}$ ]] && \
	# Checks if the format is abc.def.ghi.jkl
	[[ $(echo "$ip" | tr '.' '\n' | awk '$1 <= 255' | wc -l) -eq $((segments+1)) ]]; then 
	# Checks if there are 4 segments (a bit of redundancy)

		return 0 # If the function did not find the statement untrue, return with a "succes"
	else
		return 1 # If the function found the statement untrue, return with a "failure"
	fi
}

checkport(){
	local -n hf=$1 #host file
	local pf=$2 #port file
	local sf=$3 #save file

	for host in ${hf[@]}; do # Takes one host at a time
		local temparray=($host) # Will store the host in position 0

		for port in $(cat $pf); do # For every port in the port list
		timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null && # If unsuccesssful, throw away error
		temparray+=($port) # If successfully able to contact the port, append it to an array
	done
	if [ ${#temparray[@]} -gt 1 ]; then
		echo ${temparray[@]}
		echo ${temparray[*]} >> $savefile # Save the erray to the save file
	fi
done
}


hostfile=$1 # Gets the first argument
portfile=$2 # Gets the second argument
savefile=$3 # Gets the third argument

echo "Host, Port" >> $savefile # A little buffer to show which is which in a file

normal=() # Expecting 4 octets
special=() # Expecting 3 octets


for host in $(cat $hostfile); do
	if checkvalid $host "3"; then # If 4 octets are discovered from the host file, place them in the normal array 
		normal+=("$host")
	elif checkvalid $host "2"; then # If 3 octets are discovered from the host file, place them in the specical array
		special+=("$host")
	fi
done

# echo ${special[@]}

# checkport normal $portfile $savefile
for element in "${special[@]}"; do
	echo "$element Results"
	for odd in ${element[@]}; do
		superspecial=($odd.{1..254}) # For each item in special, this will contain all ip addresses between 1 and 254
		# echo ${superspecial[@]}
	checkport superspecial $portfile $savefile
	done
done

echo "Information saved to" $savefile

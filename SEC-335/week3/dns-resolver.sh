#!/bin/bash


lookup(){
	local -n guesses=$1 #host file
	local dns=$2 #port file
	local sf=$3 #save file
	
	for guess in ${guesses[@]}; do # Gets every guess
		timeout .1 bash -c "nslookup $guess $dns" | grep "="
	done
}

netprefix=$1 # Gets the first argument
DNS_Server=$2 # Gets the second argument

echo "DNS Resolution for" $netprefix


superspecial=($netprefix.{1..254}) # For each item in special, this will contain all ip addresses between 1 and 254
# echo ${superspecial[@]}
lookup superspecial $DNS_Server $savefile

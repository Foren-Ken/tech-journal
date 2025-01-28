#!/bin/bash

hostfile=$1
portfile=$2
savefile=$3

echo "Host, Port" >> $savefile
checkvalid() {
        local ip=$1
        if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] && \
        [[ $(echo "$ip" | tr '.' '\n' | awk '$1 <= 255' | wc -l) -eq 4 ]]; then
                return 1
        else
                return 0
        fi
}

for host in $(cat $hostfile); do
        temparray=($host)

        if checkvalid "$host"; then
                echo "$host is an invalid ip"
                # echo "$host is not a valid ip" >> $savefile
                continue
        fi

        for port in $(cat $portfile); do
                timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
                temparray+=($port)
        done

        echo ${temparray[*]} >> $savefile
done

echo "Data saved to $savefile"

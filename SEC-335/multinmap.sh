nmap -sn 10.0.5.2-50 | grep "report for" | cut -d " " -f 5 > sweep3.txt

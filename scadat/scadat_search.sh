#!/bin/sh
#   author:martinmhan@yahoo.com date:  22/04/2014
#   scadat is a sh command line interface to the tango scada
#   Copyright (C) <2014>  <Martin Mohan>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software Foundation,
#   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

if [ $# -lt 2 ];then 
    printf "%s\n" "Usage: $0 ipbase nr_values [portnumber]"
    printf "e.g. %s\n" "$0 198.23.242.110 5"
    printf "e.g. %s\n" "$0 198.23.242.110 5 10000"
#    printf "e.g. %s\n" "$0 23.239.140.191 5"
    exit
fi

#portnumber=$3

if [ -n "$3" ];then
    portnumber=$3
else
    portnumber=10000
fi

count=0
ip=$1
printf "%s\n" "portnumber=$portnumber"
ipbase="$(echo $ip | cut -d. -f1-3)"
ip_start="$(echo $ip | cut -d. -f4)"
ip_end=$(($ip_start+$2))
ip_end=$((ip_end-1))
iprange="$ip_start $ip_end"

#printf "%s\n" "$0 ip: $ip ipbase: $ipbase iprange: $iprange"
for i in `seq $iprange`; 
#    do
#        `nc -nz -w1 $ipbase.$i $portnumber` 
    do `nc -nz -w1 $ipbase.$i $portnumber`; 
        if [ $? -eq 0 ];then 
            printf "%s\n" "nc -nvz -w1 $ipbase.$i $portnumber - open"
            export TANGO_HOST=$ipbase.$i:$portnumber
            scadat -v > /dev/null 2>&1
            if [ $? -eq 0 ];then 
#                printf "%s\n" "scadat -v - pass (export TANGO_HOST=$ipbase.$i:$portnumber)"
                printf "%s\n" "scadat -v -t $ipbase.$i:$portnumber - pass"
                count=$((count+1))
            else
#                printf "%s\n" "scadat -v - fail (export TANGO_HOST=$ipbase.$i:$portnumber)"
                printf "%s\n" "scadat -v -t $ipbase.$i:$portnumber - fail"
            fi
        else
            printf "%s\n" "nc -nvz -w1 $ipbase.$i $portnumber - closed"
        fi
    done

    printf "%s\n" "Found $count tango(s) $ipbase.$ip_start - $ipbase.$ip_end"

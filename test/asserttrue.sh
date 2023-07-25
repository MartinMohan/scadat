#!/bin/sh
#   author:martinmhan@yahoo.com date:  22/04/2014
#   assertTest is a sh command line interface to the tango scada
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

#set -x
PASS=0
FAIL=1
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

if [ $# -lt 1 ];then 
    printf "%s\n" "Usage: $0 cmd <stderr> (redirect stderr)"
    printf "e.g. %s %s %s\n" "$0 'echo hello world'"
    printf "e.g. %s %s %s\n" "$0 'echo hello world' stderr"
    exit
fi

if [ $# -eq 2 ];then  # redirect stderr
    actual=`eval $1 2>&1`
else
    actual=`eval $1`
fi

if [ $? -eq 0 ]; then
#    echo "pass: assertTrue $1"
    echo "${green}pass:$reset$1"
    exit $PASS
else
#    echo "fail: assertTrue $1: $actual"
    echo "${red}fail:$reset$1: expected_part: $expected actual: $actual"
    exit $FAIL
fi

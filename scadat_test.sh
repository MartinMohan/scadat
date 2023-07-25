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

#set -x

PASS=0
FAIL=1
export PATH=.:$PATH
echo "`python --version` `which scadat`"

if [ -z "$TANGO_HOST" ]; then
    echo "set TANGO_HOST (e.g. export TANGO_HOST=127.0.0.1:10000)"
    exit 1
fi  

# Test bad TANGO_HOST's
TEMP=`echo $TANGO_HOST`
unset TANGO_HOST
#assertgrep.sh "scadat -v" "0.5.0"
export TANGO_HOST="InvalidHostName:1234"
assertgrep.sh "scadat -v" "InvalidHostName:1234 openDB <class 'socket.gaierror'>" stderr
export TANGO_HOST=$TEMP
# scadat -v, -h
assertgrep.sh "scadat -v -t InvalidHostName:1234" "InvalidHostName:1234 openDB <class 'socket.gaierror'>" stderr
assertgrep.sh "scadat -v -t mytango:10000" "mytango:10000 openDB <class 'socket.gaierror'>" stderr
##exit 1
assertgrep.sh "scadat" "Command line interface to TANGO_HOST"
assertgrep.sh "scadat -h" "Command line interface to TANGO_HOST"
# Fix bug devices printed twice
assertequal.sh "scadat -l -vv | grep dserver/DataBaseds | wc -l" "1" 
assertequal.sh "scadat -a bad/device/name" "Cannot read device bad/device/name" stderr
assertgrep.sh "scadat -a" "scadat: error: argument -a: expected at least one argument" stderr
assertequal.sh "scadat -a aa/bb/cc" "Cannot read device aa/bb/cc" stderr
assertequal.sh "scadat -a AABBCC" "stderr: Invalid name AABBCC (expected aa/bb/cc/<dd>)" stderr
assertequal.sh "scadat -a baddevicename" "stderr: Invalid name baddevicename (expected aa/bb/cc/<dd>)" stderr
assertequal.sh "scadat -a sys/tg_test/1 123" "Usage: scadat -a aa/bb/cc/dd 123" stderr

assertgrep.sh "scadat -l" "sys/tg_test/1" > /dev/null
if [ "$?" != "$PASS" ] ; then
    echo "$0: Further tests require running device sys/tg_test/1 at TANGO_HOST=$TANGO_HOST"
    exit 0
fi
assertgrep.sh "scadat -l" "sys/tg_test/1"

#scadat -r
#assertequal.sh "scadat -r sys/tg_test/1/Status" "Usage: scadat -c sys/tg_test/1" stderr
assertgrep.sh "scadat -r sys/tg_test/1" "sys/tg_test/1/State"
assertgrep.sh "scadat -r sys/tg_test/1/Status" "Usage: scadat -c sys/tg_test/1" stderr

#scadat -a
assertequal.sh "scadat -a sys/tg_test/1 | grep Status" "sys/tg_test/1/Status"
assertequal.sh "scadat -a sys/tg_test/1 -v | grep Status" "sys/tg_test/1/Status <attr_ro>"
assertgrep.sh "scadat -a sys/tg_test/1 | grep long_scalar_rww" "sys/tg_test/1/long_scalar_rww"
assertgrep.sh "scadat -a sys/tg_test/1 | grep long_scalar_w" "sys/tg_test/1/long_scalar_w"

# Write/Read Attributes
assertgrep.sh "scadat -a sys/tg_test/1" "sys/tg_test/1"
assertgrep.sh "scadat -a bad/device/name sys/tg_test/1" "sys/tg_test/1" stderr
assertequal.sh "scadat -a sys/tg_test/1/long_scalar_w" "sys/tg_test/1/long_scalar_w"
assertequal.sh "scadat -a sys/tg_test/1/long_scalar_w -v" "sys/tg_test/1/long_scalar_w <attr_w>"
assertequal.sh "scadat -a sys/tg_test/1/long_scalar_w 4321" "sys/tg_test/1/long_scalar_w->4321"
assertequal.sh "scadat -a sys/tg_test/1/long_scalar_w -vv" "sys/tg_test/1/long_scalar_w 4321"
assertequal.sh "scadat -a sys/tg_test/1/long_scalar_w 1234" "sys/tg_test/1/long_scalar_w->1234"
assertequal.sh "scadat -a sys/tg_test/1/long_scalar_w -vv" "sys/tg_test/1/long_scalar_w 1234"
assertequal.sh "scadat -a sys/tg_test/1/long_scalar_w" "sys/tg_test/1/long_scalar_w"
assertequal.sh "scadat -a sys/tg_test/1/long_scalar_w -v" "sys/tg_test/1/long_scalar_w <attr_w>"
assertequal.sh "scadat -a sys/tg_test/1/string_scalar 'my string 123'" "sys/tg_test/1/string_scalar->my string 123"
assertequal.sh "scadat -a sys/tg_test/1/string_scalar" "sys/tg_test/1/string_scalar"
assertequal.sh "scadat -a sys/tg_test/1/string_scalar -v" "sys/tg_test/1/string_scalar <attr_w>"
assertgrep.sh "scadat -a sys/tg_test/1/string_scalar -vv" "sys/tg_test/1/string_scalar my string 123"
assertequal.sh "scadat -a sys/tg_test/1 | grep ulong_image_ro" "sys/tg_test/1/ulong_image_ro"
assertgrep.sh "scadat -a sys/tg_test/1" "sys/tg_test/1/Status"

#scadat -c
assertgrep.sh "scadat -c sys/tg_test/1" "sys/tg_test/1/Status"
assertgrep.sh "scadat -c sys/tg_test/1 -v" "sys/tg_test/1/Status <cmd>"
assertgrep.sh "scadat -c sys/tg_test/1 -vv" "sys/tg_test/1/Status <DevVoid>"
assertequal.sh "scadat -c sys/tg_test/1/Init" "Usage: scadat -c sys/tg_test/1/Init DevVoid"
assertequal.sh "scadat -c sys/tg_test/1/Init DevVoid" "None"
assertgrep.sh "scadat -c sys/tg_test/1/DevFloat 12.34" "12.34"
assertequal.sh "scadat -c sys/tg_test/1/Status" "Usage: scadat -c sys/tg_test/1/Status DevVoid"
assertequal.sh "scadat -c sys/tg_test/1/Status DevVoid" "The device is in RUNNING state."
assertequal.sh "scadat -c sys/tg_test/1/DevDouble 12.34" "12.34"
assertequal.sh "scadat -c sys/tg_test/1/DevLong 1234" "1234"
assertequal.sh "scadat -c sys/tg_test/1/DevLong64 1234" "1234"
assertequal.sh "scadat -c sys/tg_test/1/DevULong64 1234" "1234"
assertequal.sh "scadat -c sys/tg_test/1/DevULong 1234" "1234"
assertequal.sh "scadat -c sys/tg_test/1/DevBoolean 0" "False"
assertequal.sh "scadat -c sys/tg_test/1/DevBoolean 1" "True"
assertequal.sh "scadat -c sys/tg_test/1/DevShort 1234" "1234"
assertequal.sh "scadat -c sys/tg_test/1/DevUShort 1234" "1234"
assertequal.sh "scadat -c sys/tg_test/1/DevString 'my string'" "my string"
assertgrep.sh "scadat -c sys/tg_test/1/DevVarFloatArray '1.123456 2.2 3.3 4.4'" "1.123456"
assertgrep.sh "scadat -c sys/tg_test/1/DevVarDoubleArray '1.123456 2.2 3.3 4.4'" "1.123456"
assertequal.sh "scadat -c sys/tg_test/1/DevVarStringArray 'string1 string2 string3 string4'" "['string1', 'string2', 'string3', 'string4']"
assertequal.sh "scadat -c sys/tg_test/1/DevVarShortArray 'string1 string2 string3 string4'" "Error writing cmd DevVarShortArray->string1 string2 string3 string4" stderr
assertequal.sh "scadat -c sys/tg_test/1/DevVoid DevVoid" "None"
assertequal.sh "scadat -c sys/tg_test/1/DevLong" "Usage: scadat -c sys/tg_test/1/DevLong DevLong" stderr
assertgrep.sh "scadat -c sys/tg_test/1/badcommand" "reason = API_CommandNotFound" stderr

assertequal.sh "scadat -c sys/tg_test/1/DevVarLongArray '1 2 3 4'" "[1 2 3 4]"
assertequal.sh "scadat -c sys/tg_test/1/DevVarLong64Array '1 2 3 4'" "[1 2 3 4]"
assertequal.sh "scadat -c sys/tg_test/1/DevVarULong64Array '1 2 3 4'" "[1 2 3 4]"
assertequal.sh "scadat -c sys/tg_test/1/DevVarUShortArray '1 2 3 4'" "[1 2 3 4]"
assertequal.sh "scadat -c sys/tg_test/1/DevVarShortArray '1 2 3 4'" "[1 2 3 4]"

#scadat -p
assertequal.sh "scadat -p sys/tg_test/1 123" "Usage: scadat -p aa/bb/cc/prop 123" stderr

# Stop here for moment. Add test/simulator/rampx2 to tango test devices
exit 0
assertgrep.sh "scadat -l" "test/simulator/rampx2" > /dev/null
if [ "$?" != "$PASS" ] ; then
    echo "$0: Further tests require running device test/simulator/rampx2 at TANGO_HOST:$TANGO_HOST"
    exit 0
fi
# Testing props need test/simulator/rampx2
assertgrep.sh "scadat -p test/simulator/rampx2/*" "test/simulator/rampx2/DeviceNr"
assertgrep.sh "scadat -p test/simulator/rampx2" "test/simulator/rampx2/DeviceNr"
assertgrep.sh "scadat -p test/simulator/rampx2/DeviceNr -v" "test/simulator/rampx2/DeviceNr <prop>"
assertgrep.sh "scadat -p test/simulator/rampx2/DeviceNr -vv" "test/simulator/rampx2/DeviceNr"
# scadat -p test/simulator/rampx2/DeviceNr 2 - throws exception but write works? - tango ticket?
asserttrue.sh "scadat -p test/simulator/rampx2/DeviceNr 2"
assertequal.sh "scadat -p test/simulator/rampx2/DeviceNr -vv" "test/simulator/rampx2/DeviceNr ['2']"

# Python2 specific test - python-pytango2 needed
#if ! $(python2 -c "import tango" &> /dev/null); then
python2 -c "import tango" > /dev/null 2>&1
if [ "$?" != "$PASS" ] ; then
    echo "WARN: python2-pytango not available for test" >&2
else
    echo "python2-pytango test" >&2
    assertgrep.sh "python2 `which scadat` -l -t 127.0.0.1:1234" "socket.error" stderr
    assertgrep.sh "python2 `which scadat` -v" "python.version_info 2"
fi

# Python3 specific test - python-pytango3 needed
#python3 -c "import tango" &> /dev/null - bash format
python3 -c "import tango" > /dev/null 2>&1
if [ "$?" != "$PASS" ] ; then
    echo "WARN: python3-pytango not available for test" >&2
else
    echo "python3-pytango test" >&2
    assertgrep.sh "python3 `which scadat` -l -t 127.0.0.1:1234" "ConnectionRefusedError" stderr
    assertgrep.sh "python3 `which scadat` -v" "python.version_info 3"
#    assertequal.sh "python3 `which scadat` -c sys/tg_test/1/DevVarLongArray 'kj1 2 3 4'" "[1 2 3 4]"
#    assertequal.sh "python3 `which scadat` -c sys/tg_test/1/DevVarLong64Array '1 2 3 4'" "[1 2 3 4]"
#    assertequal.sh "python3 `which scadat` -c sys/tg_test/1/DevVarULong64Array '1 2 3 4'" "[1 2 3 4]"
#    assertequal.sh "python3 `which scadat` -c sys/tg_test/1/DevVarUShortArray '1 2 3 4'" "[1 2 3 4]"
#    assertequal.sh "python3 `which scadat` -c sys/tg_test/1/DevVarShortArray '1 2 3 4'" "[1 2 3 4]"
fi

# scadat_search tests
assertgrep.sh "scadat_search.sh 198.23.242.110 1" "nc -nvz -w1 198.23.242.110 10000 - open"
assertgrep.sh "scadat_search.sh 198.23.242.130 1" "scadat -v -t 198.23.242.130:10000 - fail"

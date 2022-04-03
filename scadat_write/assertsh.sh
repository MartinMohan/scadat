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
printf "Usage:\n"
printf "assertequal.sh cmd 'expected_string' <stderr>\n"
printf "assertgrep.sh 'expected_string' <stderr>\n"
printf "asserttrue.sh cmd 'expected_string' <stderr>\n"
printf "assertfalse.sh cmd 'expected_string' <stderr>\n\n"
printf "e.g. assertequal.sh 'echo hello world' 'hello world'\n"
printf "e.g. assertgrep.sh 'echo hello world' 'hello'\n"

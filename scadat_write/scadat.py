#!/usr/bin/python
##!/usr/bin/env python
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
#import sys
#if sys.version_info >= (3, 0):
#    sys.stdout.write("Sorry, requires Python 2.x, not Python 3.x\n")
#    sys.exit(1)

import scadat_tango,os

if __name__ == '__main__':
    # export SUPER_TANGO="true" - if enviroment variable not set
#    if not os.getenv("SUPER_TANGO"):
#        os.environ["SUPER_TANGO"] = "true"
#        print ("SUPER_TANGO=",os.getenv("SUPER_TANGO"))
    scadat_tango.main()

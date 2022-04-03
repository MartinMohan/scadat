#! /usr/bin/env python
import os,argparse
import scadat
#import scadat.scadat_tango

parser = argparse.ArgumentParser(description=\
        "Find Tango by ip address\n\
        e.g. scadat_search.py 198.23.242.110 5")
parser.add_argument('ip',help='ip address')
parser.add_argument('nr',help='increment value')

args = parser.parse_args()

ip_address=args.ip
ipall=ip_address.split(".")
ipbase="%s.%s.%s"%(ipall[0],ipall[1],ipall[2])
baseNr=int(ipall[3])

#myscadat=scadat.scadat_tango.scadat_tango()
for x in range(baseNr, baseNr+int(args.nr)):
    ipAddress="%s.%s"%(ipbase,str(x))
    target=os.environ["TANGO_HOST"]="%s:%s"%(ipAddress,"10000")
    print ("scadat_tango TANGO_HOST=%s"%target)
    myscadat=scadat.scadat_tango.scadat_tango(TANGO_HOST=target)
    try:
        myscadat.openDB()
        print ("%s - Tango found"%target)
    except Exception as e:
        print ("%s - no Tango"%target)

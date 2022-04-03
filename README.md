Usage: [-h] [-v] [-t T] [ -l | -r R [R ...] | -a A [A] | -c C [C] | -p P [P]]  
  
Linux command line interface to tango  
  
optional arguments:  
  -h            show this help message and exit  
  -v            increase verbosity using -v,-vv,-vvv  
  -t T          Override TANGO_HOST environment variable e.g.  
                scadat -l -t scadat.org:10000  
  -l            List tango devices  
  -r R [R...]   Read attributes,commands and properties for devices: e.g.  
                scadat -r sys/tg_test/1  
  -a A [A]      Read/Write attributes: e.g.  
                scadat -a sys/tg_test/1/string_scalar 'hello world'  
  -c C [C]      Read/Write commands: e.g.  
                scadat -c sys/tg_test/1/DevLong 1234  
  -p P [P]      Read/Write properties: e.g.  
                scadat -p sys/tg_test/1/myproperty test  

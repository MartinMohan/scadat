Command line interface to [Tango scada]( https://tango-controls.readthedocs.io/en/latest/installation/tango-on-linux.html "Tango")  
<img src="./docs/tango_logo.png">

<html><body>
<p>scadat -h</p>
<pre>
Usage: [-h] [-v] [-t T] [ -l | -r R [R ...] | -a A [A] | -c C [C] | -p P [P]]

Linux command line interface to tango

optional arguments:
  -h            show this help message and exit
  -v            increase verbosity using -v,-vv,-vvv
  -t T          Override TANGO_HOST environment variable e.g. scadat -l -t scadat.org:10000
  -l            List tango devices
  -r R [R...]   Read attributes,commands and properties for devices: e.g. scadat -r sys/tg_test/1
  -a A [A]      Read/Write attributes: e.g.
                scadat -a sys/tg_test/1/string_scalar 'hello world'
  -c C [C]      Read/Write commands: e.g.
                scadat -c sys/tg_test/1/DevLong 1234
  -p P [P]      Read/Write properties: e.g.
                scadat -p sys/tg_test/1/myproperty test

Install Tango on debian or ubuntu
---------------------------
apt install mariadb-server

vi /etc/mysql/my.cnf
[client]
user=mysqluser
password=mysqlpass

apt install tango-db tango-test python-pytango

Install scadat
---------------------------
git clone https://github.com/martinmohan99/scadat
cd scadat
./scadat -h

Test
-------
scadat_test.sh will run unit tests.
</pre>
</body></html>

TODO: -addserver and -regserver to db

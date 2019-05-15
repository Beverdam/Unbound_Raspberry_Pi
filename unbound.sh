## be sure to replace unbound-1.8.1 with the version you would like to use. Source for version: https://nlnetlabs.nl/projects/unbound/download/ ##

#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# install dnsutils
sudo apt-get -y install dnsutils
# install drill
# usage drill txt qnamemintest.internet.nl
# result HOORAY - QNAME minimisation is enabled on your resolver
sudo apt-get -y install ldnsutils

sudo apt-get -y install libssl-dev
sudo apt-get -y install libexpat1-dev

sudo groupadd -g 991 unbound
## change the unboud-1.8.1. to the version you want to use ##
sudo useradd -c "unbound-1.8.1" -d /var/lib/unbound -u 991 -g unbound -s /bin/false unbound

## change unbound-1.8.1. to the version you want to use, https://nlnetlabs.nl/projects/unbound/download/ ## 
file=unbound-1.8.1
mkdir -p unbound
cd unbound
wget https://nlnetlabs.nl/downloads/unbound/$file.tar.gz
tar xzf $file.tar.gz
cd $file

sudo ./configure --prefix=/usr --sysconfdir=/etc --disable-static --with-pidfile=/run/unbound.pid
sudo make
sudo make install

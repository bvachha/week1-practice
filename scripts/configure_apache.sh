#! /bin/bash

HOSTIP=$(hostname -I | awk '{print $1}')
echo "Allocated IP is $HOSTIP"
echo "Updating the apache2 webserver config"
sed --in-place=".original" "s/Listen.*80/Listen $HOSTIP:80/" /etc/apache2/ports.conf
echo "Apache config updated"

exit 0
#!/bin/sh
export realm=`hostname -d`
export REALM="${realm^^}"
export HOSTNAME=`hostname -f`
sed -i "s/blueprintclusterhost/$HOSTNAME/g" cluster_configuration.json
sed -i "s/SPECIFYREALM/$REALM/g" cluster_configuration.json
sed -i "s/SPECIFYDOMAIN/$realm/g" cluster_configuration.json
sed -i "s/blueprintclusterhost/$HOSTNAME/g" hostmapping.json
sed -i "s/blueprintclusterhost/$HOSTNAME/g" registerBluePrint.sh

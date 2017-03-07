#!/bin/sh
export HOSTNAME1=node01.hadoophdp.com
export HOSTNAME2=node02.hadoophdp.com
export HOSTNAME3=node03.hadoophdp.com
export AMBARISERVER=node01.hadoophdp.com
export KDCADMINHOST=node01.hadoophdp.com
export KDCHOST=node01.hadoophdp.com
sed -i "s/HOSTNAME1/$HOSTNAME1/g" cluster_configuration.json
sed -i "s/HOSTNAME1/$HOSTNAME1/g" hostmapping.json
sed -i "s/HOSTNAME2/$HOSTNAME2/g" hostmapping.json
sed -i "s/HOSTNAME3/$HOSTNAME3/g" hostmapping.json
sed -i "s/AMBARISERVER/$AMBARISERVER/g" registerBluePrint.sh

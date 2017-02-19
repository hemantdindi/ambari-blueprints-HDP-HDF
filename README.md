# hdp-sn-blueprint

Execute the below scripts on the host - 

git clone https://github.com/hemantdindi/hdp-sn-blueprint.git
chmod +x -R hdp-sn-blueprint/
sh hdp-sn-blueprint/setup/host-ambari.sh
cd hdp-sn-blueprint/json
export realm=`hostname -d`
export REALM="${realm^^}"
sed -i "s/blueprintclusterhost/$HOSTNAME/g" cluster_configuration.json
sed -i "s/SPECIFYREALM/$REALM/g" cluster_configuration.json
sed -i "s/blueprintclusterhost/$HOSTNAME/g" hostmapping.json
sed -i "s/blueprintclusterhost/$HOSTNAME/g" registerBluePrint.sh
sh registerBluePrint.sh

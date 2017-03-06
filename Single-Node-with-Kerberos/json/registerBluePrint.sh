#!/bin/sh
curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://blueprintclusterhost:8080/api/v1/blueprints/hdp25snbp -d @cluster_configuration.json
curl -H "X-Requested-By: ambari" -X PUT -u admin:admin http://blueprintclusterhost:8080/api/v1/stacks/HDP/versions/2.5/operating_systems/redhat7/repositories/HDP-2.5 -d @hdp.json
curl -H "X-Requested-By: ambari" -X PUT -u admin:admin http://blueprintclusterhost:8080/api/v1/stacks/HDP/versions/2.5/operating_systems/redhat7/repositories/HDP-UTILS-1.1.0.21 -d @hdp-util.json
curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://blueprintclusterhost:8080/api/v1/clusters/hdp25sn -d @hostmapping.json

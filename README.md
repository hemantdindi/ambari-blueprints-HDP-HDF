# hdp-sn-blueprint

#This is tested in a CentOS 7 64 Bit Server on a Digital Ocean Droplet

The below script will configure your single host with all the pre-requisites for a single node HDP 2.5 instance.
It will setup passwordless-ssh, install ambari-server, ambari-agent and configure them as per you node details.
It will configure ambari server in the silent mode and install Java Accordingly.

	#!/bin/sh
	cd ~
	yum install git -y
	git clone https://github.com/hemantdindi/hdp-sn-blueprint.git
	chmod +x -R hdp-sn-blueprint/
	cd hdp-sn-blueprint/setup/
	sh host-ambari.sh
	cd ../json/
	sh configure-scripts.sh
	ambari-server start
	ambari-agent start
	ambari-server status
	ambari-agent status
	sh registerBluePrint.sh
   
You should see a the below output when you execute the last statement -

      {
      "href" : "http://hemant.hadoophdp.com:8080/api/v1/clusters/hdp25sn/requests/1",
      "Requests" : {
      "id" : 1,
      "status" : "Accepted"
       } 
     }

Please login to ambari using the default[admin/admin] credentials. You should see the progress of installation.
 
![Alt text](./Ambari-BP-1.PNG)
  
![Alt text](./Ambari-BP-2.PNG)



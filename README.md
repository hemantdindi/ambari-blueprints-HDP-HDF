# hdp-sn-blueprint

#This is tested in a CentOS 7 64 Bit Server on a Digital Ocean Droplet

The below script will configure your single host with all the pre-requisites for a single node HDP 2.5 instance.
It will setup passwordless-ssh, install ambari-server, ambari-agent and configure them as per you node details.
It will configure ambari server in the silent mode and install Java Accordingly.

When you create the Droplet, ensure that in the data section, you add the script as below - 

![Alt text](./Droplet-Data.PNG)

Login to the droplet with creadentials [root/hadoophdp]
	
	tail -f cloud-init-output.log
   
You should see a the below output when you execute the last statement -

      {
      "href" : "http://hemant.hadoophdp.com:8080/api/v1/clusters/hdp25sn/requests/1",
      "Requests" : {
      "id" : 1,
      "status" : "Accepted"
       } 
     }Cloud-init v. 0.7.5 finished at Sun, 05 Mar 2017 15:34:48 +0000. Datasource DataSourceDigitalOcean.  Up 296.53 seconds

Please login to ambari using the default[admin/admin] credentials. You should see the progress of installation.
 
![Alt text](./Ambari-BP-1.PNG)
  
![Alt text](./Ambari-BP-2.PNG)



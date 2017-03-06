# HDP multinode installation using Ambari Blueprints without Kerberos.

##This is tested in a CentOS 7 64 Bit Servers hosted in Digital Ocean

Note that the hostnames are as below - 

* node01.hadoophdp.com 
* node02.hadoophdp.com 
* node03.hadoophdp.com 

node01.hadoophdp.com acts as the ambari server.

##### On node01, execute the script - setup-ambari-server.sh
##### On node02, node03, execute the script - setup-ambari-agent.sh

_At this point ambari-agent's are not started._
_Ensure DNS/Rev. DNS is working among the nodes, else modify /etc/hosts on all hosts as per your IP's_

In my case, I updated /etc/hosts 

Follow the below steps - 

* On Ambari-server host, execute the following - 

      yum install git -y
      

![Alt text](./images/multinode-install-1.PNG)

![Alt text](./images/multinode-install-2.PNG)

![Alt text](./images/multinode-install-3.PNG)

![Alt text](./images/multinode-install-4.PNG)

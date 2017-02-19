# hdp-sn-blueprint

#This is tested in a CentOS 7 64 Bit Server

The below script will configure your single host with all the pre-requisites for a single node HDP 2.5 instance.
It will configure passwordless-ssh, install ambari-server, ambari-agent and configure them as per you node details.
It will set up ambari server in the silent mode and install Java Accordingly.

    cd ~
    yum install git -y
    git clone https://github.com/hemantdindi/hdp-sn-blueprint.git
    chmod +x -R hdp-sn-blueprint/
    cd hdp-sn-blueprint/setup/
    sh host-ambari.sh
    
Execute the below command to enable installation using blueprint

    cd ~
    cd hdp-sn-blueprint/json
    sh configure-scripts.sh

Please ensure ambari-server and ambari-agent are up and running

    ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql-connector-java.jar
    ambari-server restart
    ambari-server status
    ambari-agent status

Execute the statements of the script file sequentially

    registerBluePrint.sh
	   
You should see a the below output when you execute the last statement -

      {
      "href" : "http://hemant.hadoophdp.com:8080/api/v1/clusters/hdp25sn/requests/1",
      "Requests" : {
      "id" : 1,
      "status" : "Accepted"
       } 
     }

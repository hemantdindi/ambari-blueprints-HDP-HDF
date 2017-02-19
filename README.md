# hdp-sn-blueprint

Execute the below scripts on the host - 

    cd ~
    yum install git -y
    git clone https://github.com/hemantdindi/hdp-sn-blueprint.git
    chmod +x -R hdp-sn-blueprint/
    cd hdp-sn-blueprint/setup/
    sh host-ambari.sh
    cd ~
    cd hdp-sn-blueprint/json
    sh configure-scripts.sh

Please ensure ambari-server and ambari-agent are up and running
    
    ambari-server status
    ambari-agent status
    sh registerBluePrint.sh
	   
You should see a output similar to this -

      {
      "href" : "http://hemant.hadoophdp.com:8080/api/v1/clusters/hdp25sn/requests/1",
      "Requests" : {
      "id" : 1,
      "status" : "Accepted"
       } 
     }

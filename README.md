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
    sh registerBluePrint.sh
	   

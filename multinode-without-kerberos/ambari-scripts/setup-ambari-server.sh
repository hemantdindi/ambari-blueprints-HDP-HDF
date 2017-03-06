#!/bin/sh
passwd root <<EOF
hadoophdp
hadoophdp
EOF
cd ~
mkdir node-setup
cd node-setup
#cp /etc/hosts .
echo "127.0.0.1 localhost.localdomain localhost" > /etc/hosts
echo "127.0.0.1 localhost4.localdomain4 localhost4" >> /etc/hosts
ip a | grep 'inet' | grep eth0 | cut -d: -f2 | awk '{ print $2}' | tr "/" " " | awk '{ print $1}' | head -n 1 > ipaddr
hostname -f | tr "." " " | awk '{ print $1}' > hostname
hostname -f > fqdn
cat ipaddr fqdn hostname | xargs >> /etc/hosts
service network restart
yum install httpd unzip wget -y
service httpd start
systemctl enable httpd
service firewalld stop
systemctl disable firewalld
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.2.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.rpm
rpm -ivh jdk-8u102-linux-x64.rpm
echo "export JAVA_HOME=/usr/java/default" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
source ~/.bashrc
yum install ambari-server -y
ambari-server setup <<EOF
n
3
/usr/java/default
n
EOF
mkdir -p /usr/share/java
wget -nv https://jdbc.postgresql.org/download/postgresql-9.4.1212.jre6.jar -O /usr/share/java/postgresql-jdbc.jar
ambari-server setup --jdbc-db=postgres --jdbc-driver=/usr/share/java/postgresql-jdbc.jar
ambari-server start
wget --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
unzip -o -j -q jce_policy-8.zip -d /usr/java/default/jre/lib/security/
ambari-server restart
yum install ambari-agent -y
sed -i 's/hostname=localhost/'hostname="$HOSTNAME"'/g' /etc/ambari-agent/conf/ambari-agent.ini
service postgresql restart
su postgres -c psql <<EOF
\x
create database hivedb;
create user hiveuser with password 'hadoop';
grant all privileges on database hivedb to hiveuser;
EOF
echo "host all all 0.0.0.0/0 trust" >> /var/lib/pgsql/data/pg_hba.conf
service postgresql restart
ambari-server restart
ambari-agent restart
ambari-server status
ambari-agent status
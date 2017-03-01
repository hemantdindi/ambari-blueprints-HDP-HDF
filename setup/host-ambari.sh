#!/bin/sh
passwd root <<EOF
hadoophdp
hadoophdp
EOF
cd ~
mkdir node-setup
cd node-setup
cp /etc/hosts .
head -2 hosts > /etc/hosts 
ip a | grep 'inet' | grep eth0 | cut -d: -f2 | awk '{ print $2}' | tr "/" " " | awk '{ print $1}' > ipaddr
hostname -f | tr "." " " | awk '{ print $1}' > hostname
hostname -f > fqdn
cat ipaddr fqdn hostname | xargs >> /etc/hosts
service network restart
rm -rf ~/.ssh
mkdir ~/.ssh
ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
ssh -o "StrictHostKeyChecking no" `hostname` 'date'
yum install httpd -y
service httpd start
systemctl enable httpd
service firewalld stop
systemctl disable firewalld
yum install unzip -y
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.2.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.rpm
wget --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
rpm -ivh jdk-8u102-linux-x64.rpm
echo "export JAVA_HOME=/usr/java/default" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
unzip -o -j -q jce_policy-8.zip -d /usr/java/default/jre/lib/security/
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
yum install ambari-agent -y
sed -i 's/hostname=localhost/'hostname="$HOSTNAME"'/g' /etc/ambari-agent/conf/ambari-agent.ini
wget http://www.issihosts.com/haveged/haveged-1.9.1.tar.gz
yum install -y gcc-c++
cd ./haveged-1.9.1
./configure
make
make install
haveged -w 1024
echo "/usr/local/sbin/haveged -w 1024" >> /etc/rc.local
export realm=`hostname -d`
export REALM="${realm^^}"
export KDC_HOST=`hostname -f`
yum -y install krb5-server krb5-libs krb5-workstation
cp /etc/krb5.conf .
mv /etc/krb5.conf /tmp/
sed -i "s/EXAMPLE.COM/$REALM/g" krb5.conf
sed -i "s/example.com/$realm/g" krb5.conf
sed -i "s/kerberos.$realm/$KDC_HOST/g" krb5.conf
sed -i '2,$s/#//' krb5.conf
cp krb5.conf /etc/krb5.conf
kdb5_util create -s -P hadoop
service krb5kdc start
service kadmin start
systemctl enable krb5kdc
systemctl enable kadmin
kadmin.local -q "addprinc -pw hadoop admin/admin"
sed -i "s/EXAMPLE.COM/$REALM/g" /var/kerberos/krb5kdc/kadm5.acl
service krb5kdc restart
service kadmin restart
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

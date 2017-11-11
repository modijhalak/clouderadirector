#!/bin/sh
# Cloudera bootstrap script 
sudo yum remove --assumeyes *openjdk*
sudo yum update -y
#aws s3 cp s3://dbs-ngdp/jdk-8u141-linux-x64.rpm .
#sudo yum localinstall jdk-8u141-linux-x64.rpm -y
sudo yum install https://s3-us-west-2.amazonaws.com/jmodi-kogentix/jdk-8u141-linux-x64.rpm -y
export JAVA_HOME=/usr/java/jdk1.8.0_141
sudo sh -c "echo 'export JAVA_HOME=/usr/java/jdk1.8.0_141' >> /etc/profile.d/jdk_home.sh"
echo "Java 1.8 Installed"
echo "Setup JDBC"
#aws s3 cp s3://dbs-ngdp/mysql-connector-java-5.1.44.tar.gz .
#tar xvzf mysql-connector-java-5.1.44.tar.gz
#mkdir -p /usr/share/java
#sudo cp mysql-connector-java-5.1.44/mysql-connector-java-5.1.44-bin.jar /usr/share/java/mysql-connector-java.jar
#install dependencies
#sudo yum install mlocate unzip telnet bind-utils vim wget screen -y
#sudo yum install openldap-clients krb5-workstation krb5-libs -y # dependecies to be installed if using AD
#sudo yum install realmd oddjob oddjob-mkhomedir sssd adcli samba-common-tools -y
#Setup DNS
#sudo sed -i 's/plugins=ifcfg-rh/plugins=ifcfg-rh\ndns=none/' /etc/NetworkManager/NetworkManager.conf
#sudo systemctl restart NetworkManager
#sudo sed -i '1s/^/search ad-dns-ntp.dahngdp.local dahngdp.local\nnameserver 10.115.80.195\n/' /etc/resolv.conf
#sudo systemctl restart NetworkManager
#sudo cat /etc/resolv.conf
#echo "network setup done"
# Setup Hostname
echo "change hostname"
sudo hostnamectl status
host1="$(hostname -s | cut -d '-' -f 2-5).dahngdp.local"
sudo hostnamectl set-hostname "$host1" --static
sudo hostnamectl set-hostname "$host1" --pretty
sudo hostnamectl status
#Setup NTP
#echo "setup NTP"
#yum install ntp* -y
#sudo sed -i 's/server 0.amazon.pool.ntp.org iburst/server 0.ad-dns-ntp.dahngdp.local iburst prefer/' /etc/ntp.conf
#ntpdate -q ad-dns-ntp.dahngdp.local
#ntpdate ad-dns-ntp.dahngdp.local
#chkconfig ntpdate on
#Setup AD
echo "AD setup started"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sh -c 'cat /etc/ssh/sshd_config | grep PasswordAuthentication'
sudo service sshd restart
nslookup dahngdp.local
echo "domain join started"
realm discover dahngdp.local
aws s3 cp s3://dbs-ngdp/adpwd.txt /tmp/
cat /tmp/adpwd.txt | sudo realm join --computer-ou="ou=Cloudera,dc=dahngdp,dc=local" -U bigdata dahngdp.local
sudo sh -c "echo '%dahngdp\\\Domain\ Admins     ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers"
sudo sh -c "echo '%dahngdp\\\cdhadmin   ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers"
realm list
id bigdata@dahngdp.local

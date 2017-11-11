#setup DB 
sudo yum install mariadb-server -y
sudo systemctl start mariadb
sudo chkconfig mariadb on 
sudo sh -c "echo -e '\n\nabc\nabc\n\n\n\n\n' | /usr/bin/mysql_secure_installation"
for i in `cat database.txt`; do mysql -u root -pabc -e "create database $i;" -e "GRANT ALL PRIVILEGES ON $i.* to $i@'%' IDENTIFIED BY '$i#123';" ; done
for i in `cat database.txt`; do mysql -u root -pabc -e "show databases;" ; mysql -u root -pabc -e " SHOW USERS FROM mysql.users;";done

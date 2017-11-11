#!/bin/sh
function install_db {
  echo "Install DB Server in $DIRECTOR_HOST... "
  $SUDO_CMD yum remove mariadb-server -y
  $SUDO_CMD rm -rf /var/lib/mysql
  $SUDO_CMD rm -f /etc/my.cnf
  $SUDO_CMD rm -f ~/.my.cnf
  $SUDO_CMD yum install mariadb-server -y
  $SUDO_CMD systemctl start mariadb
  $SUDO_CMD chkconfig mariadb on 
  $SUDO_CMD sh -c "echo -e '\n\n'${DB_ROOT_PASSWORD}'\n'${DB_ROOT_PASSWORD}'\n\nn\n\n\n' | /usr/bin/mysql_secure_installation"
}
echo "User: $(whoami)"
echo "$DIRECTOR_HOST:$DIRECTOR_HOST"
echo "SUDO_CMD: $SUDO_CMD"
if [[ ! -z "$DB_ROOT_PASSWORD" ]]; then
  echo "DB_ROOT_PASSWORD:******"
fi
install_db

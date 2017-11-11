echo "lp.plugin.configuration.blacklist: sandbox" >> /etc/cloudera-director-server/application.properties
service cloudera-director-server start 
until service cloudera-director-server status; do 
  echo "cloudera-director-server is not starting. Try to restart service in 5 sec...."
  service cloudera-director-server restart
  sleep 5
done
DIRECTOR_URL="http://localhost:7189"
until curl -m 15 $DIRECTOR_URL; do echo "Waiting director ready..."; done
echo "done"

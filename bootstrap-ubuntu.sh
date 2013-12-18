#!/bin/bash

# Install Mongo
[[ ! `which mongod` ]] &&
(
  echo " --- Installing MongoDB"
  sudo apt-key add /vagrant/config/10gen-gpg-key.asc
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
  sudo apt-get update -qq
  sudo apt-get install mongodb-10gen -y -qq
)

# Installing other dependancies
echo " --- Installing JDK"
sudo apt-get install openjdk-7-jre-headless vim -y -qq


# from https://gist.github.com/wingdspur/2026107
[[ ! -d /etc/elasticsearch ]] &&
(
  echo " --- Installing ElasticSearch"
  sudo dpkg -i /vagrant/src/elasticsearch-0.90.7.deb
  sudo cp /vagrant/config/elasticsearch.yml /etc/elasticsearch/
  sudo service elasticsearch start
)

# Installing Graylog-Server v0.20.0-preview.8
graylog2_server="graylog2-server-0.20.0-preview.8"

[[ ! -d ~/$graylog2_server ]] &&
(
  echo " --- Installing Graylog-Server"
  sudo tar xfz /vagrant/src/${graylog2_server}.tgz -C /opt/

  sudo ln -s /opt/$graylog2_server/bin/graylog2ctl /etc/init.d/
  sudo cp /vagrant/config/graylog2.conf /etc/graylog2.conf
)

graylog2_ui="graylog2-web-interface-0.20.0-preview.8"

[[ ! -d ~/$graylog2_ui ]] &&
(
  echo " --- Installing Graylog-Server"
  sudo tar xfz /vagrant/src/${graylog2_ui}.tgz -C /opt/
  cp /vagrant/config/graylog2-web-interface.conf /opt/$graylog2_ui/conf/graylog2-web-interface.conf
  sudo ln -s /opt/$graylog2_ui/bin/graylog2-web-interface ~/
)

exit 0

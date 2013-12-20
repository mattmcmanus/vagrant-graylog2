#!/bin/bash

graylog2_server="graylog2-server-0.20.0-preview.8"
graylog2_ui="graylog2-web-interface-0.20.0-preview.8"

# Install Mongo
[[ ! `which mongod` ]] &&
(
  echo " --- Installing MongoDB"
  cp ./config/mongodb.repo /etc/yum.repos.d/
  sudo mkdir -p /data/db
  sudo chmod 0755 /data/db
  sudo yum install mongo-10gen mongo-10gen-server -y -q
  sudo chown mongod:mongod /data/db
)

# Installing other dependancies
echo " --- Installing JDK"
sudo yum install java-1.7.0-openjdk.x86_64 -y -q


# from https://gist.github.com/wingdspur/2026107
[[ ! -d /etc/elasticsearch ]] &&
(
  echo " --- Installing ElasticSearch"
  sudo yum localinstall https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.noarch.rpm -y -q
  sudo cp ./config/elasticsearch.yml /etc/elasticsearch/
)

# Installing Graylog-Server v0.20.0-preview.8
[[ ! -d /opt/$graylog2_server ]] &&
(
  echo " --- Installing Graylog-Server"
  sudo tar xfz ./src/${graylog2_server}.tgz -C /opt/

  sudo ln -s /opt/$graylog2_server/bin/graylog2ctl /etc/init.d/
  sudo cp ./config/graylog2.conf /etc/graylog2.conf
)

[[ ! -d /opt/$graylog2_ui ]] &&
(
  echo " --- Installing Graylog-Web-Interface"
  sudo tar xfz ./src/${graylog2_ui}.tgz -C /opt/
  cp ./config/graylog2-web-interface.conf /opt/$graylog2_ui/conf/graylog2-web-interface.conf
)

#!/bin/bash

# reconfig tomcat structure so that /opt/tomcat directory can be volume mounted to allow persistence of config changes
echo "Configuring tomcat directory structure"

# first make sure we have /opt/tomcat/
if [ ! -d "/opt/tomcat/" ]; then
  mkdir -p /opt/tomcat/
fi

# second create directories that we wish to allow persistence
cd /opt/tomcat/
if [ ! -d "/opt/tomcat/bin/" ]; then
  ln -s /usr/local/tomcat/bin .
fi
if [ ! -d "/opt/tomcat/lib/" ]; then
  ln -s /usr/local/tomcat/lib .
fi

# third link directories that we do not need to make persistent
cd /usr/local/tomcat/
if [ ! -d "/opt/tomcat/conf/" ]; then
  mv conf /opt/tomcat/
  ln -s /opt/tomcat/conf .
else
  rm -rf /usr/local/tomcat/conf
  ln -s /opt/tomcat/conf .
fi

if [ ! -d "/opt/tomcat/logs/" ]; then
  mv logs /opt/tomcat/
  ln -s /opt/tomcat/logs .
else
  rm -rf /usr/local/tomcat/logs
  ln -s /opt/tomcat/logs .
fi

if [ ! -d "/opt/tomcat/webapps/" ]; then
  mv webapps /opt/tomcat/
  ln -s /opt/tomcat/webapps .
else
  rm -rf /usr/local/tomcat/webapps
  ln -s /opt/tomcat/webapps .
fi

if [ ! -d "/opt/tomcat/work/" ]; then
  mv work /opt/tomcat/
  ln -s /opt/tomcat/work .
else
  rm -rf /usr/local/tomcat/work
  ln -s /opt/tomcat/work .
fi

# fourth, setup GeoServer portal
if [ ! -d "/opt/tomcat/webapps/geoserver" ]; then
  echo "Setting up GeoServer portal"
  mv /geoserver /opt/tomcat/webapps
fi

# start tomcat
catalina.sh run

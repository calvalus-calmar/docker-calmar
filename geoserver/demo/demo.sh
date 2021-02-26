#!/bin/bash

echo "Initialising GeoServer with demo configuration"

rm -rf /opt/tomcat/webapps/geoserver/data/data/calmar/
rm -rf /opt/tomcat/webapps/geoserver/data/styles/line_yellow.*
rm -rf /opt/tomcat/webapps/geoserver/data/workspaces/calmar/

mkdir /opt/tomcat/webapps/geoserver/data/data/calmar
cp -rp geoserver_data/data/calmar/ne_10m_coastline/ /opt/tomcat/webapps/geoserver/data/data/calmar/

cp -rp geoserver_data/styles/line_yellow.* /opt/tomcat/webapps/geoserver/data/styles/

mkdir /opt/tomcat/webapps/geoserver/data/workspaces/calmar
cp -rp geoserver_data/workspaces/calmar/ne_10m_coastline/ /opt/tomcat/webapps/geoserver/data/workspaces/calmar/
cp -rp geoserver_data/workspaces/calmar/workspace.xml /opt/tomcat/webapps/geoserver/data/workspaces/calmar/
cp -rp geoserver_data/workspaces/calmar/namespace.xml /opt/tomcat/webapps/geoserver/data/workspaces/calmar/

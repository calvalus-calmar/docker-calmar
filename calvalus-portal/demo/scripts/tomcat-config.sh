#!/bin/bash

cd $CATALINA_HOME

#################################################
# 1 - Configure tomcat users                    #
#################################################
tomcatUsersFile="conf/tomcat-users.xml"
comment='<!-- Calvalus portal roles and users -->'

if ! grep -q "${comment}" $tomcatUsersFile; then
  sed -i "/<\/tomcat-users>/ i \
  \  $comment\n\
  <role rolename=\"calvalus\"/>\n\
  <role rolename=\"bc\"/>\n\
  <user username=\"calmar\" password=\"demo*\" roles=\"calvalus,bc\"/>" \
  $tomcatUsersFile
fi

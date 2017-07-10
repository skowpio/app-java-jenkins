#!/bin/bash

#JAVA_HOME/bin/java -cp $(JARS=(/opt/app-jenkins/custom_deploy/install_dir/current/*.jar); IFS=:; echo "${JARS[*]}") -DdeployedBy=Jenkins org.kkrzysiu.tools.Servlet 1>/dev/null 2>&1 &
java -cp $(JARS=(/opt/app-jenkins/custom_deploy/install_dir/current/*.jar); IFS=:; echo "${JARS[*]}") -DdeployedBy=Jenkins org.kkrzysiu.tools.Servlet 1>/home/prod-jenkins/log.txt 2>&1 &
echo $! > /opt/app-jenkins/app-jenkins.pid

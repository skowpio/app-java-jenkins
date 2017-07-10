#!/bin/bash

$JAVA_HOME/bin/java -cp $(JARS=(/opt/app-jenkins/custom_deploy/install_dir/current/*.jar); IFS=:; echo "${JARS[*]}") -DdeployedBy=Jenkins org.kkrzysiu.tools.Servlet

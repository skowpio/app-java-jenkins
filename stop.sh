#!/bin/bash

if [ -f /opt/app-jenkins/app-jenkins.pid ]
then
if [ $(ps -o pid h $(cat /opt/app-jenkins/app-jenkins.pid) | wc -l) == 1 ]
then
kill $(cat /opt/app-jenkins/app-jenkins.pid)
fi
rm -rf /opt/app-jenkins/app-jenkins.pid
fi

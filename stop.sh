#!/bin/bash

if [ -f /opt/app-jenkins/app-jenkins.pid ]
then
kill $(cat /opt/app-jenkins/app-jenkins.pid)
rm -rf /opt/app-jenkins/app-jenkins.pid
fi

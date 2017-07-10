#!/bin/bash

kill $(cat /opt/app-jenkins/app-jenkins.pid)
rm -rf /opt/app-jenkins/app-jenkins.pid

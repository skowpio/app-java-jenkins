#!/bin/bash

INSTALL_DIR="/opt/app-jenkins/custom_deploy/install_dir"
WORK_DIR="/tmp/target"
POM_VERSION=$(cat $WORK_DIR/app-java-jenkins-version.properties)
PACKAGE_PATH="${WORK_DIR}/app-java-jenkins-$POM_VERSION-dist.zip"

mkdir -p ${INSTALL_DIR}

#supervisorctl stop app-jenkins-custom-deploy

unzip -q -o ${PACKAGE_PATH} -d ${INSTALL_DIR}

ln -fs ${INSTALL_DIR}/app-java-jenkins-${POM_VERSION} ${INSTALL_DIR}/current

#supervisorctl start app-jenkins-custom-deploy

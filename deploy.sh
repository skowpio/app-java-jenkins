#!/bin/bash

INSTALL_DIR="/opt/app-jenkins/install"
WORK_DIR="/tmp/target"
POM_VERSION=$(cat $WORK_DIR/app-java-jenkins-version.properties)
PACKAGE_PATH="${WORK_DIR}/app-java-jenkins-$POM_VERSION-dist.zip"

mkdir -p ${INSTALL_DIR}

unzip -q -o ${PACKAGE_PATH} -d ${INSTALL_DIR}

if [ -f ${INSTALL_DIR}/current/stop.sh ]
then
chmod 0750 ${INSTALL_DIR}/current/stop.sh
${INSTALL_DIR}/current/stop.sh
fi

rm -f ${INSTALL_DIR}/current
ln -s ${INSTALL_DIR}/app-java-jenkins-${POM_VERSION} ${INSTALL_DIR}/current

chmod 0750 ${INSTALL_DIR}/current/*.sh

${INSTALL_DIR}/current/start.sh $1

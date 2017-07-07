#!/bin/bash 

get_help() {
  echo "Usage:\n $0 app-jenkins-1.tar.gz"
}

if [ $# -eq 0 ]; then 
  get_help
  exit 1
fi 

APP_PACKAGE=${1}
VERSION=$(echo ${APP_PACKAGE} | awk -F'-' '{print $3}' | tr -d 'tar.gz')
APP_NAME=$(echo ${APP_PACKAGE} | awk -F'-' '{print $1"-"$2}')

INSTALL_DIR="/opt/${APP_NAME}/custom_deploy/install_dir"
WORK_DIR="/tmp"
PACKAGE_PATH="${WORK_DIR}/${APP_PACKAGE}"
ARCHIVE_DIR="/opt/${APP_NAME}/custom_deploy/archive"
POM_VERSION_FILE="${INSTALL_DIR}/current/pom_version.txt"

mkdir -p ${INSTALL_DIR}
mkdir -p ${ARCHIVE_DIR}

supervisorctl stop ${APP_NAME}-custom-deploy

if [ -f ${PACKAGE_PATH} ]; then 
  tar zxf "${PACKAGE_PATH}" -C "${INSTALL_DIR}"
fi

if [ -L ${INSTALL_DIR}/current ]; then 
  rm -f ${INSTALL_DIR}/current
fi 

ln -s ${INSTALL_DIR}/${VERSION} ${INSTALL_DIR}/current

# unzip maven zip package
if [ -f ${POM_VERSION_FILE} ]; then 
  POM_VERSION=$(echo pom_version.txt)
  unzip app-java-jenkins-${POM_VERSION}-dist.zip -d ${INSTALL_DIR}/current
  mv ${INSTALL_DIR}/current/app-java-jenkins-${POM_VERSION}/*.jar ${INSTALL_DIR}/current
  rm -fr ${INSTALL_DIR}/current/app-java-jenkins-${POM_VERSION}
fi

supervisorctl start ${APP_NAME}-custom-deploy
mv ${PACKAGE_PATH} ${ARCHIVE_DIR}

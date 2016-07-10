#!/bin/bash
set -e

chown -R 888.888 /opt/fitnesse
cd /opt/fitnesse/testFiles
mvn package
cd /opt/fitnesse
exec java -jar /opt/fitnesse/fitnesse-standalone.jar -d /opt/fitnesse/ "$@"

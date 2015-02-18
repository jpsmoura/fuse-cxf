#!/bin/sh

# Update FUSE_61_ARCHIVE, FUSE_INSTALL_PATH and org.ops4j.pax.url.mvn.repositories below before running!

jps -lm | grep karaf | grep -v grep | awk '{print $1}' | xargs kill -KILL

export FUSE_61_ARCHIVE=/home/bibryam/apps/_archive/jboss-fuse-full-6.1.1.redhat-412.zip
export FUSE_61_ARCHIVE=/home/bibryam/apps/_archive/jboss-fuse-full-6.1.0.redhat-379.zip
export FUSE_INSTALL_PATH=/tmp/

rm -rf ${FUSE_INSTALL_PATH}jboss-fuse-6.1.0.redhat-379/
unzip $FUSE_61_ARCHIVE -d $FUSE_INSTALL_PATH
sed -i 's/#admin/admin/' ${FUSE_INSTALL_PATH}jboss-fuse-6.1.0.redhat-379/etc/users.properties
cd ${FUSE_INSTALL_PATH}jboss-fuse-6.1.0.redhat-379/bin/
./start

sleep 20
./client

wait-for-service -t 300000 io.fabric8.api.BootstrapComplete

fabric:create --clean --wait-for-provisioning --profile fabric

fabric:profile-edit --pid io.fabric8.agent/org.ops4j.pax.url.mvn.repositories='file:/home/bibryam/projects/fuse-cxf/offline-repo/target/repo@snapshots@id=bp' default
fabric:profile-edit --pid org.fusesource.fabric.maven/checksumPolicy=warn  default
fabric:profile-edit --pid org.ops4j.pax.url.mvn/checksumPolicy=warn default

fabric:profile-edit --pid org.ops4j.pax.web/org.osgi.service.http.port=${port:80,8282}


fabric:profile-edit --repositories mvn:com.ofbizian/features/1.0.0/xml/features default

fabric:profile-create --parents feature-camel demo1

#container-create-child root demo

container-add-profile root demo1

fabric:version-create --parent 1.0 --default 1.1


fabric:profile-edit --features camel-routes-demo demo1 1.1
#fabric:profile-edit --features camel-cxf demo1 1.1

container-upgrade --all 1.1

log:tail



################################################################################################   patching
wait-for-service -t 300000 io.fabric8.api.BootstrapComplete

fabric:create --clean --wait-for-provisioning --profile fabric

version-create
patch-apply --version 1.1  --username admin --password admin  file:///data/installers/jboss-fuse-6.1.0.redhat-379-r1.zip
container-upgrade 1.1 root

version-set-default 1.1


version-create
patch-apply --version 1.2 --username admin --password admin   file:///data/installers/jboss-fuse-6.1.0.redhat-379-r1p2.zip
container-upgrade 1.2 root

version-set-default 1.2



fabric:profile-edit --pid io.fabric8.agent/org.ops4j.pax.url.mvn.repositories='file:/data/user/documents/RedHat/engineering/support/bilgin/fuse-cxf/offline-repo/target/repo@snapshots@id=bp' default
fabric:profile-edit --pid org.fusesource.fabric.maven/checksumPolicy=warn  default
fabric:profile-edit --pid org.ops4j.pax.url.mvn/checksumPolicy=warn default

fabric:profile-edit --repositories mvn:com.ofbizian/features/1.0.0/xml/features default

fabric:profile-create --parents feature-camel demo1

container-add-profile root demo1

fabric:version-create


fabric:profile-edit --features camel-routes-demo demo1 1.3
#fabric:profile-edit --features camel-cxf demo1 1.1

container-upgrade --all 1.3

log:tail
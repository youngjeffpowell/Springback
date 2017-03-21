#!/bin/bash
VERSION="5.4.2"
MD5HASH=ce5413ff7414b9f17895d2305b51a081
CMD=/opt/proserver/bin/proserver
INSTALLDIR=/tmp/src

if [ ! -f $CMD ]
then
    mkdir -p $INSTALLDIR
    echo "Download Code42 Server (CrashPlanPROServer)"
    curl -fSL -o /tmp/Code42server_Linux.tgz https://download.code42.com/installs/proserver/${VERSION}/Code42server_${VERSION}_Linux.tgz
    echo "Unpacking Code42 Server (CrashPlanPROServer)"
    echo "$MD5HASH  /tmp/Code42server_Linux.tgz" |
    tar -xzf /tmp/Code42server_Linux.tgz -C $INSTALLDIR --strip-components 1 &&\
    rm -f /tmp/Code42server_Linux.tgz
    echo "Starting installation of CrashPlanPROServer v$VERSION!"
    sed -i 's/INSTALL_UNATTENDED=0/INSTALL_UNATTENDED=1/g' ${INSTALLDIR}/install.sh
    sed -i 's/AUTO_ACCEPT_EULA=0/AUTO_ACCEPT_EULA=1/g' ${INSTALLDIR}/install.sh
    cd $INSTALLDIR && ./install.sh
    rm -rf $INSTALLDIR
fi

echo "Starting Services"
/etc/init.d/proserver start
touch /var/log/proserver/app.log
tail -f /var/log/proserver/app.log

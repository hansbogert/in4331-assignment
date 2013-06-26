#!/bin/bash
JAVA_PACKAGE=openjdk-7-jre-headless

## download resources for assignment
cd /vagrant/res; bash download-resources.sh


## download latest stable hadoop if not installed already
# change to home dir
cd

# check if hadoop is already installed
dpkg --status hadoop
if [ $? = 1 ]
then
	if [ ! -f hadoop_1.1.2-1_i386.deb ]
	then
		wget http://apache.xl-mirror.nl/hadoop/common/hadoop-1.1.2/hadoop_1.1.2-1_i386.deb
	fi
	sudo dpkg -i hadoop_1.1.2-1_i386.deb

	#set java home correctly
	sudo sed -i -e 's/\(export JAVA_HOME=\).*/\1\/usr\/lib\/jvm\/java-7-openjdk-i386/' /etc/hadoop/hadoop-env.sh 

fi

## download java
dpkg --status $JAVA_PACKAGE
if [ $? = 1  ]
then
	sudo aptitude update
	sudo aptitude install -y $JAVA_PACKAGE
fi

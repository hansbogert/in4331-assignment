#!/bin/bash
JAVA_PACKAGE=openjdk-7-jre-headless

## download resources for assignment
cd /vagrant/res; bash download-resources.sh


## download latest stable hadoop if not installed already
# change to home dir
cd

# check if hadoop is already installed
aptitude show hadoop > /dev/null
if [ $? = 255 ]
then
	if [ ! -f hadoop_1.1.2-1_i386.deb ]
	then
		wget --progress=dot:mega http://apache.xl-mirror.nl/hadoop/common/hadoop-1.1.2/hadoop_1.1.2-1_i386.deb
	fi
	sudo dpkg -i hadoop_1.1.2-1_i386.deb

	#set java home correctly
	sudo sed -i -e 's/\(export JAVA_HOME=\).*/\1\/usr\/lib\/jvm\/java-7-openjdk-i386/' /etc/hadoop/hadoop-env.sh 
	cat << 'EOF' | sudo tee /etc/hadoop/core-site.xml
<configuration>
<property>
    <name>fs.default.name</name>
    <value>hdfs://localhost:9000</value>
  </property>
</configuration>
EOF
        sudo su hdfs -c 'hadoop namenode -format'
	sudo invoke-rc.d hadoop-namenode start
	sudo invoke-rc.d hadoop-datanode start
        
fi

## download java
dpkg --status $JAVA_PACKAGE
if [ $? = 1  ]
then
	sudo aptitude update
	sudo aptitude install -y $JAVA_PACKAGE
fi

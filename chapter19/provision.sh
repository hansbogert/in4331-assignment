#!/bin/bash
JAVA_PACKAGE=openjdk-6-jdk
echo `whoami`
## download resources for assignment
cd /vagrant/res; bash download-resources.sh

## hadoop dependencies
## download java and maven
dpkg --status $JAVA_PACKAGE
if [ $? = 1  ]
then
    sudo aptitude update
    sudo aptitude install -y maven
fi

## download latest stable hadoop if not installed already
# change to home dir
cd

# check if hadoop is already installed
if [ -f /etc/hadoop/mapred-site.xml ]
    mkdir /etc/hadoop
    sudo sed -i -e 's/\(export JAVA_HOME=\).*/\1\/usr\/lib\/jvm\/java-6-openjdk-i386/' /etc/hadoop/hadoop-env.sh 
    cat << 'EOF' | sudo tee /etc/hadoop/core-site.xml
<configuration>
<property>
    <name>fs.default.name</name>
    <value>hdfs://localhost:9000</value>
  </property>
</configuration>
EOF

    cat << 'EOF' |sudo tee /etc/hadoop/mapred-site.xml
<configuration>
     <property>
         <name>mapred.job.tracker</name>
         <value>localhost:9001</value>
     </property>
</configuration>
EOF

fi

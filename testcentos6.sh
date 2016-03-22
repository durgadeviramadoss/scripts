#!/bin/bash
#Getting releasever and Basearch
distro=$(sed -n 's/^distroverpkg=//p' /etc/yum.conf)
releasever=$(rpm -q --qf "%{version}" -f /etc/$distro)
basearch=$(rpm -q --qf "%{arch}" -f /etc/$distro)
#Creating Saltstack Repo
rpm --import https://repo.saltstack.com/yum/redhat/6/x86_64/latest/SALTSTACK-GPG-KEY.pub
echo "[saltstack-repo]
name=SaltStack repo for RHEL/CentOS $releasever
baseurl=https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest
enabled=1
gpgcheck=1
gpgkey=https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/SALTSTACK-GPG-KEY.pub" >> /etc/yum.repos.d/saltstack.repo
sudo yum clean expire-cache
#Updating OS
yum update -y
#Installing Saltstack
#yum install salt-master -y
yum install salt-minion -y
yum install salt-syndic -y
yum install salt-ssh -y
yum install salt-cloud -y
#Enabling Salt services at OS Level
#sudo systemctl enable salt-master.service
chkconfig salt-minion on
#Start Salt Service
service salt-minion start
#Install Salt dependencies
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
sudo python2.6 ez_setup.py
sudo easy_install-2.6 pip
yum install python-cffi* -y
yum install python-devel* -y
yum install libffi* -y
yum install gcc* -y
yum install openssl* -y
yum install m2crypto* -y
wget ftp://ftp.muug.mb.ca/mirror/centos/7.2.1511/os/x86_64/Packages/python-cherrypy-3.2.2-4.el7.noarch.rpm
rpm -ivh python-cherrypy-3.2.2-4.el7.noarch.rpm
wget https://pypi.python.org/packages/source/c/cffi/cffi-1.5.2.tar.gz#md5=fa766133f7299464c8bf857e0c966a82
tar -xvf cffi-1.5.2.tar.gz
cd cffi-1.5.2
chmod 777 setup.py
sudo python setup.py install
cd
wget https://pypi.python.org/packages/source/c/cryptography/cryptography-1.2.2.tar.gz#md5=2b25eebd1d3c6bae52b46f0dcec74dfb
cd cryptography-1.2.2.tar.gz
tar -xvf cryptography-1.2.2.tar.gz
cd cryptography-1.2.2
chmod 777 setup.py
sudo python setup.py install
cd
sudo pip install azure==0.10.2
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"
yum install jdk-8u60-linux-x64.rpm -y

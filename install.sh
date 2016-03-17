sudo yum -y update
sudo yum install -y $1
sudo yum -y update --fix-missing
sudo yum install -y $1

# Install tomcat
sudo yum install -y  $2


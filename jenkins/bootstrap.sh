# BEGIN ########################################################################
echo -e "-- ------------------ --\n"
echo -e "-- BEGIN BOOTSTRAPING --\n"
echo -e "-- ------------------ --\n"

# BOX ##########################################################################
# echo -e "-- Updating packages list\n"
# apt-get update -y

# GIT ##########################################################################
# echo -e "-- Installing GIT packages\n"
# apt-get install -y git

# MAVEN ########################################################################
# echo -e "-- Installing MAVEN packages\n"
# apt-get install -y maven

# JAVA #########################################################################
echo -e "-- Installing JAVA packages\n"

add-apt-repository ppa:webupd8team/java -y
apt-get update

/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections

apt-get install -y oracle-java8-installer > /dev/null 2>&1

# JENKINS #########################################################################
echo -e "-- Including Jenkins packages\n"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add - > /dev/null 2>&1
sh -c "echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list"

echo -e "-- Updating packages list\n"
apt-get update -y
echo -e "-- Installing Jenkins automation server\n"
apt-get install jenkins -y > /dev/null 2>&1

# END ##########################################################################
echo -e "-- ---------------- --"
echo -e "-- END BOOTSTRAPING --"
echo -e "-- ---------------- --"
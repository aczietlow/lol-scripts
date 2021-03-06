#!/bin/bash
echo "***************************************************************************
*****************Welcome to the interactive script for setting******************
***************** up a Drupal Dev evnironment in Ubuntu 11.10 **********************
***************************************************************************"
sudo -k

echo "***************************************************************************
********Remember the root password you enter for MySQL, We'll need that later ***
********************************************************************************"
echo "Installing lamp-server"
sudo apt-get install lamp-server^
echo "successfully installed the LAMP stack."

echo "Install PHP modules cli gd and xdebug"
sudo apt-get install php5-cli php5-gd php5-xdebug
echo "Successfully installed php modules"

echo "configuring Apache for virtual hosting"
sudo a2enmod rewrite
sudo /etc/init.d/apache2 restart
sudo touch /etc/apache2/conf.d/servername

#gets the host name of the server
THISHOST=$(hostname)

echo "SeverName" $THISHOST > /etc/apache2/conf.d/servername
echo "Apace has been configured"

echo "Setting up Drupal Install"
#Make a directory for Drupal Sites to Go
mkdir ~/Web

#Get currect user's username (The one running the script
USERNAME=$(id -un)

cd ~/Web
wget http://ftp.drupal.org/files/projects/drupal-7.14.tar.gz
tar zxf drupal-7.14.tar.gz
rm drupal-7.14.tar.gz
cd Web/drupal-7.14/sites/default/
cp default.settings.php settings.php
chmod a+w settings.php
mkdir files
chmod a+wx files


echo "Finished Downloading Drupal"

echo "Create an entry in the hosts file"
sudo echo "
127.0.0.1	localhost
127.0.0.1	web
127.0.0.1	$THISHOST

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts

sudo touch /etc/apache2/sites-available/web

sudo echo "
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  ServerName web

  DocumentRoot /home/$USERNAME/Web

  <Directory />
    Options FollowSymLinks
    AllowOverride All
  </Directory>
</VirtualHost>" > web

sudo a2ensite web
sudo /etc/init.d/apache2 reload
echo "Apache is now configured!"

echo "Installing phpmyadmin"
sudo apt-get install phpmyadmin

#Appends line to end of apache confirguration file
sudo echo "
#Includes phpmyadmin library
Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

sudo /etc/init.d/apache2 restart
echo "phpmyadmin is configured and installed!"

echo "DRUSH!!!"
sudo apt-get install php-pear
sudo pear channel-discover pear.drush.org
sudo pear install drush/drush




apt-get install mysql-client
adduser --system --group --home /var/aegir aegir
adduser aegir www-data    #make aegir a user of group www-data
chsh -s /bin/sh aegir
apt-get install rsync apache2 php5 php5-cli php5-mysql
mkdir /var/aegir/.ssh
cat > /var/aegir/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9P7B/wFiTUVPHpO1XqCaOtr6T3+nwZDavM4nyTHdNJd4bPW9q9s3X87qpeWW3EkTYQwtlU8JXUxBoL9LesIr2XHLENcZta3awveQtEDJ+71dh3xsMfFjLE34gQXUrZUqJvfk0IaB5q2ditmo5QELT5Mrz0Dh3v9I9cA0qdNkWYhd5lkzMHSjMN4U0yHmoo8KC+76Igo3UBLU1di3SjVLwKcpG7sdVMa4ssqsoB7DMZn40Y3VKNaBYXuKiLgLU20izePiIHkCFNYSK7XzpflzU6nR2P8xCzNMLs2uIVJrTH40x0lPZQJsneB8of3pF3f5pPJQuXsImT2/WG8Ksxg25 aegir@aegir.spyderbytedesign.dnsdynamic.com
EOF
chown aegir:aegir /var/aegir/.ssh -R
chmod 750 /var/aegir/.ssh
chmod 640 /var/aegir/.ssh/authorized_keys
a2enmod rewrite
ln -s /var/aegir/config/apache.conf /etc/apache2/conf.d/aegir.conf
cat > /etc/sudoers.d/aegir <<EOF
Defaults:aegir  !requiretty
aegir ALL=NOPASSWD: /usr/sbin/apache2ctl
EOF
chmod 440 /etc/sudoers.d/aegir

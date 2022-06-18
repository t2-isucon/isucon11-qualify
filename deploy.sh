#!/bin/bash

# source $HOME/.bash_profile $HOME/.bashrc

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo 'Restarting Go...'
sudo systemctl stop isucondition.go.service
cd $DIR/webapp/go/
/home/isucon/local/go/bin/go build -o isucondition
cp isucondition /home/isucon/webapp/go/
cd $DIR
sudo systemctl restart isucondition.go.service
echo 'Restarted!'

echo 'Updating config file...'
# env
sudo cp "$DIR/env.sh" /home/isucon/env.sh

# nginx
sudo cp "$DIR/nginx/nginx.conf" /etc/nginx/nginx.conf
sudo cp "$DIR/nginx/isucondition.conf" /etc/nginx/sites-enabled/isucondition.conf

# mysql
sudo cp "$DIR/my.cnf" /etc/mysql/conf.d/my.cnf
echo 'Updated config file!'

echo 'Restarting services...'
sudo systemctl restart mysql.service
sudo systemctl restart nginx.service
echo 'Restarted!'

echo 'Rotating files'
sudo bash -c 'cp /var/log/nginx/access.log /var/log/nginx/access.log.$(date +%s) && echo > /var/log/nginx/access.log'
sudo -u mysql bash -c 'cp /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.$(date +%s) && echo > /tmp/mysql-slow.sql'
echo 'Rotated!'

#!/bin/bash

# source $HOME/.bash_profile $HOME/.bashrc

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo 'Restarting Go...'
cd $DIR/webapp/go/
/home/isucon/local/go/bin/go build -o isucondition
sudo systemctl stop isucondition.go.service
cd $DIR
sudo systemctl restart isucondition.go.service
echo 'Restarted!'

echo 'Updating config file...'
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
sudo bash -c 'cp /tmp/mysql-slow.sql /tmp/mysql-slow.sql.$(date +%s).$(git rev-parse HEAD) && echo > /tmp/mysql-slow.sql'
echo 'Rotated!'

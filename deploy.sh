#!/usr/bin/env bash

set -e

ssh  isucon12-02 /bin/bash <<-EOF
sudo su - isucon
pushd webapp
git checkout nekottyo;
git fetch origin nekottyo;
git reset --hard origin/nekottyo
# sudo cp nginx/nginx.conf /etc/nginx/nginx.conf
# sudo cp nginx/sites-enabled/isucondition.conf /etc/nginx/sites-enabled/isucondition.conf
# sudo cp mysql/my.cnf /etc/mysql/my.cnf
pushd go
echo make
make
sudo su
systemctl restart isucondition.go.service
systemctl restart nginx
systemctl stop mysql
:>  /var/log/nginx/access.log
:>  /var/log/nginx/error.log
exit
popd
echo finish sync \$(cat .git/refs/heads/nekottyo)
EOF

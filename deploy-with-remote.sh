#!/bin/bash -eu

repo_path=/home/isucon/isucon11-qualify
branch=${1:-main} # default: main

echo 'running deploy to this server'
git -C ${repo_path} pull origin main
git -C ${repo_path} switch ${branch}
${repo_path}/deploy.sh

echo 'running deploy to other servers, isu2 and isu3'
echo ''
echo '[NOTE] Before expecting this process to work well, you need to prepare /etc/hosts for alias isu2, isu3'
echo ''
for srv in "isu2" "isu3"
do
  echo 'starting for '${srv}
  ssh isucon@${srv} git -C ${repo_path} pull origin ${branch} || ssh isucon@${srv} git clone https://github.com/t2-isucon/isucon11-qualify.git
  ssh isucon@${srv} git -C ${repo_path} switch ${branch}
  ssh isucon@${srv} ${repo_path}/deploy.sh
  echo 'finished for '${srv}
done

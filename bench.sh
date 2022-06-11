#!/usr/bin/env bash

set -e

ssh  isucon12-02 /bin/bash <<-EOF
sudo su - isucon
cd bench
./bench -all-addresses 127.0.0.11 -target 127.0.0.11:443 -tls -jia-service-url http://127.0.0.1:4999

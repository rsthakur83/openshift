#!/usr/bin/bash
export http_proxy=http://10.103.30.18:8080/
export https_proxy=http://10.103.30.18:8080/

sudo terraform plan
sudo terraform apply

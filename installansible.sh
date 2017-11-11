#!/bin/bash
echo "Downloading get-pip.py ..."
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
echo "Installing pip.py ..."
python get-pip.py
pip install -U pip
yum install -y gcc libffi-devel python-devel openssl-devel
pip install ansible
pip install boto
pip install awscli

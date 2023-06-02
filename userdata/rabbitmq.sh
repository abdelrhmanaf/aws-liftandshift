#!/bin/bash
sudo yum install dnf -y 
sudo dnf install epel-release -y
sudo dnf update -y
sudo dnf install socat logrotate -y
sudo dnf install -y erlang rabbitmq-server
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl status rabbitmq-server
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo systemctl restart rabbitmq-server

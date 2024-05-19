#!/bin/bash
#echo "Hello world" > ~/hello.txt
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd
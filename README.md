# chef-efk
Cookbooks
=================

Overview
------------
These are recipes for building a system for visualizing the log by the fluentd, elasticsearch and kibana.

Operating environment
-----
・CentOS 6.6

Prerequisite
-----
・Chef Solo can perform system

・System Java program can be executed
 JRE/JDK >= 1.8.0_x (x >= 20)
 or
 JRE/JDK >= 1.7.0_x (x >= 55)

・HTTP server
 Apache >= 2.4.x (x >= 12)

Usage
-----
1. Store the cookbooks.tar.gz to /tmp

2. Create a cookbooks in the Repository (/var/chef).

 $sudo knife cookbook create td-agent -o /var/chef/cookbooks

 $sudo knife cookbook create elasticsearch -o /var/chef/cookbooks

 $sudo knife cookbook create kibana -o /var/chef/cookbooks

3. To expand by moving the cookbook.tar.gz to /var/chef

 $mv /tmp/cookbooks.tar.gz /var/chef

 $tar zxvf /var/chef/cookbooks.tar.gz

4. Install

 $sudo chef-solo -o elasticsearch

 $sudo chef-solo -o td-agent

 $sudo chef-solo -o kibana

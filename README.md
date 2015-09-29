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
・Chef Solo can be executed

・Java program can be executed
 
  JRE/JDK >= 1.8.0_x (x >= 20)
 
  or
 
  JRE/JDK >= 1.7.0_x (x >= 55)
 
・Dstat can be executed

・HTTP server

  Apache >= 2.4.x (x >= 12)

Usage
-----
1. Store the chef-efk-master.zip to /tmp

2. Create a cookbooks in the Repository (/var/chef/chef-efk-master).

 $ sudo knife cookbook create td-agent -o /var/chef/chef-efk-master/cookbooks

 $ sudo knife cookbook create elasticsearch -o /var/chef/chef-efk-master/cookbooks

 $ sudo knife cookbook create kibana -o /var/chef/chef-efk-master/cookbooks

3. To expand by moving the chef-efk-master.zip to /var/chef

 $ mv /tmp/chef-efk-master.zip /var/chef/chef-efk-master

 $ unzip /var/chef/chef-efk-master.zip

4. Store the packages necessary to files/default of each cookbook
 * Refer to a README.md of each cookbook

5. Install using chef-solo

 $ sudo chef-solo -o elasticsearch

 $ sudo chef-solo -o td-agent

 $ sudo chef-solo -o kibana

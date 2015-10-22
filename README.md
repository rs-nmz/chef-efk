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

2. Create a cookbooks in the Repository (/var/chef).

 $ sudo knife cookbook create td-agent

 $ sudo knife cookbook create elasticsearch

 $ sudo knife cookbook create kibana

3. Unzip the chef-efk-master.zip with /tmp. Overwrite copy "/tmp/chef-efk-master/cookbooks" to "/var/chefcookbooks".

 $ unzip -d /tmp /tmp/chef-efk-master.zip

 $ cp -r /tmp/chef-efk-master/cookbooks /var/chef

4. Store the packages necessary to files/default of each cookbook
 * Refer to a README.md of each cookbook

5. Install using chef-solo

 $ sudo chef-solo -o elasticsearch

 $ sudo chef-solo -o td-agent

 $ sudo chef-solo -o kibana

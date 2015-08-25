# chef-efk
Cookbooks
=================

Overview
------------
These are recipes for building a system for visualizing the log by the fluentd, elasticsearch and kibana.

Usage
-----
Store the cookbooks.tar.gz to /tmp

sudo knife cookbook create td-agent -o /var/chef/cookbooks

sudo knife cookbook create elasticsearch -o /var/chef/cookbooks

sudo knife cookbook create kibana -o /var/chef/cookbooks

mv /tmp/cookbooks.tar.gz /var/chef

tar zxvf /var/chef/cookbooks.tar.gz

sudo chef-solo -o td-agent

sudo chef-solo -o elasticsearch

sudo chef-solo -o kibana

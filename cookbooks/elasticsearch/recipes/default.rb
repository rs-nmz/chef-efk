#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

filename1 = "elasticsearch-1.5.2.noarch.rpm"
#filename2 = "java-1.8.0-openjdk-1.8.0.25-1.b17.el6.x86_64.rpm"

cookbook_file "/tmp/#{filename1}" do
  source "#{filename1}"
end

#cookbook_file "/tmp/#{filename2}" do
#  source "#{filename2}"
#end

package "elasticsearch" do
  action :install
  source "/tmp/#{filename1}"
end

#package "OpenJDK" do
#  action :install
#  source "/tmp/#{filename2}"
#end

template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  owner "root"
  group "root"
  mode 644
end


service "elasticsearch" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end








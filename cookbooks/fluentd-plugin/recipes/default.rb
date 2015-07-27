#
# Cookbook Name:: fluentd-plugin
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

filename = "fluent-plugin-elasticsearch-0.9.0.gem"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end

gem_package "fluentd-elasticsearch" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename}"
end


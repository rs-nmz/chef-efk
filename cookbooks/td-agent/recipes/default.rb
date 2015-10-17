#
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


group 'td-agent' do
  group_name 'td-agent'
  gid        403
  action    :create
end


user 'td-agent' do
  comment  'td-agent'
  uid      403
  group    'td-agent'
  home     '/var/run/td-agent'
  shell    '/bin/false'
  password nil
  supports :manage_home => true
  action   [:create, :manage]
end


directory '/etc/td-agent/' do
  owner  'td-agent'
  group  'td-agent'
  mode   '0755'
  action :create
end

directory '/etc/td-agent/plugin' do
  owner  'td-agent'
  group  'td-agent'
  mode   '0755'
  action :create
end

filename1 = "td-agent-2.2.0-0.x86_64.rpm"
filename2 = "fluent-plugin-elasticsearch-0.9.0.gem"
filename3 = "fluent-plugin-dstat-0.3.1.gem"
filename4 = "fluent-plugin-map-0.0.5.gem"
filename5 = "parser_postgres.rb"

cookbook_file "/tmp/#{filename1}" do
  source "#{filename1}"
end


package "td-agent" do
  action :install
  source "/tmp/#{filename1}"
end


#package "td-agent" do
#  action :upgrade
#  source "/tmp/#{filename1}"
#end

file '/var/log/td-agent/messages.log.pos' do
  owner 'td-agent'
  group 'td-agent'
  mode 0755
  action :create_if_missing
end

directory '/var/log/td-agent' do
  owner 'td-agent'
  group 'td-agent'
  mode 0755
end

file '/var/log/messages' do
  mode "0644"
end

template "/etc/td-agent/td-agent.conf" do
  mode "0644"
  source "td-agent_first.conf.erb"
  notifies :restart, "service[td-agent]"
end

service "td-agent" do
  action [:enable, :start]
  subscribes :restart, resources(:template => "/etc/td-agent/td-agent.conf")
end

#plugin install
cookbook_file "/tmp/#{filename2}" do
  source "#{filename2}"
end

cookbook_file "/tmp/#{filename3}" do
  source "#{filename3}"
end

cookbook_file "/tmp/#{filename4}" do
  source "#{filename4}"
end

gem_package "fluentd-elasticsearch" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename2}"
end

gem_package "fluentd-dstat" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename3}"
end

gem_package "fluentd-map" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename4}"
end

cookbook_file "/etc/td-agent/plugin/#{filename5}" do
  source "#{filename5}"
  mode "0755"
end

template "/etc/td-agent/td-agent.conf" do
  mode "0644"
  source "td-agent.conf.erb"
  notifies :restart, "service[td-agent]"
end


service "td-agent" do
  action [:enable, :start]
  subscribes :restart, resources(:template => "/etc/td-agent/td-agent.conf")
end

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

filename = "td-agent-2.2.0-0.x86_64.rpm"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end


package "td-agent" do
  action :install
  source "/tmp/#{filename}"
end


#package "td-agent" do
#  action :upgrade
#  source "/tmp/#{filename}"
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
  source "td-agent.conf.erb"
  notifies :restart, "service[td-agent]"
end


service "td-agent" do
  action [:enable, :start]
  subscribes :restart, resources(:template => "/etc/td-agent/td-agent.conf")
end


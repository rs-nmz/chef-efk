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
filename2 = "multipart-post-2.0.0.gem"
filename3 = "faraday-0.9.1.gem"
filename4 = "elasticsearch-transport-1.0.12.gem"
filename5 = "elasticsearch-api-1.0.12.gem"
filename6 = "elasticsearch-1.0.12.gem"
filename7 = "excon-0.45.4.gem"
filename8 = "fluent-mixin-rewrite-tag-name-0.1.0.gem"
filename9 = "fluent-plugin-elasticsearch-0.9.0.gem"
filename10 = "fluent-plugin-dstat-0.3.1.gem"
filename11 = "fluent-plugin-map-0.0.5.gem"
filename12 = "parser_postgres.rb"

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

file '/var/log/td-agent/postgres.log.pos' do
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

cookbook_file "/tmp/#{filename5}" do
  source "#{filename5}"
end

cookbook_file "/tmp/#{filename6}" do
  source "#{filename6}"
end

cookbook_file "/tmp/#{filename7}" do
  source "#{filename7}"
end

cookbook_file "/tmp/#{filename8}" do
  source "#{filename8}"
end

cookbook_file "/tmp/#{filename9}" do
  source "#{filename9}"
end

cookbook_file "/tmp/#{filename10}" do
  source "#{filename10}"
end

cookbook_file "/tmp/#{filename11}" do
  source "#{filename11}"
end

gem_package "multipart-post" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename2}"
end

gem_package "faraday" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename3}"
end

gem_package "elasticsearch-transport" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename4}"
end

gem_package "elasticsearch-api" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename5}"
end

gem_package "elasticsearch" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename6}"
end

gem_package "excon" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename7}"
end

gem_package "fluent-mixin-rewrite-tag-name" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename8}"
end

gem_package "fluentd-elasticsearch" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename9}"
end

gem_package "fluentd-dstat" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename10}"
end

gem_package "fluentd-map" do
  gem_binary "/usr/sbin/td-agent-gem"
  action :install
  source "/tmp/#{filename11}"
end

cookbook_file "/etc/td-agent/plugin/#{filename12}" do
  source "#{filename12}"
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

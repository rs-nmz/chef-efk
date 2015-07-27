

# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

filename="kibana-3.1.2.tar.gz"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end

directory '/var/www/html/' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

bash "kibana" do
  not_if "ls /var/www/html/kibana"
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
    tar zxvf "/tmp/#{filename}" -C /var/www/html
    mv /var/www/html/kibana-3.1.2 /var/www/html/kibana
  EOH
end

template "/var/www/html/kibana/config.js" do
  source "config.js.erb"
  owner "root"
  group "root"
  mode 755
end

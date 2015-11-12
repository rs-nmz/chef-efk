# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

filename1="kibana-3.1.2.tar.gz"
filename2="Dstat_Dashboard"
filename3="Syslog_Dashboard"
filename4="PosgreSQL_Dashboard"

cookbook_file "/tmp/#{filename1}" do
  source "#{filename1}"
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
    tar zxvf "/tmp/#{filename1}" -C /var/www/html
    mv /var/www/html/kibana-3.1.2 /var/www/html/kibana
  EOH
end

template "/var/www/html/kibana/config.js" do
  source "config.js.erb"
  owner "root"
  group "root"
  mode "0755"
end

cookbook_file "/var/www/html/kibana/app/dashboards/#{filename2}" do
  source "#{filename2}"
end

cookbook_file "/var/www/html/kibana/app/dashboards/#{filename3}" do
  source "#{filename3}"
end

cookbook_file "/var/www/html/kibana/app/dashboards/#{filename4}" do
  source "#{filename4}"
end


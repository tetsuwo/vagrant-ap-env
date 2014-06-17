#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "iptables" do
  action :install
end

template "/etc/sysconfig/iptables" do
  source "iptables.erb"
  group "root"
  owner "root"
  mode "0600"
  notifies :reload, 'service[iptables]'
end

service "iptables" do
  supports :status => true, :restart => true
  action [:enable, :restart]
end

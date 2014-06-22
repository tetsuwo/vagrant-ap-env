#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "mysql-libs" do
  action :remove
end

node["mysql"]["rpm"].each do |rpm|
  remote_file "/tmp/#{rpm[:file_name]}" do
    source "#{rpm[:remote_uri]}"
  end
  package rpm[:package_name] do
    action :install
    provider Chef::Provider::Package::Rpm
    source "/tmp/#{rpm[:file_name]}"
  end
end

service "mysql" do
  action [:enable, :start]
end

script "Secure_Install" do
  interpreter "bash"
  user "root"
  not_if "mysql -u root -p#{node[:mysql][:server_root_password]} -e 'show databases'"
  code <<-EOL
    export Initial_PW=`head -n 1 /root/.mysql_secret |awk '{print $(NF - 0)}'`
    mysql -u root -p${Initial_PW} --connect-expired-password -e "SET PASSWORD FOR root@localhost=PASSWORD('your_password');"
    mysql -u root -pyour_password -e "SET PASSWORD FOR root@'127.0.0.1'=PASSWORD('your_password');"
    mysql -u root -pyour_password -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -pyour_password -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1');"
    mysql -u root -pyour_password -e "DROP DATABASE test;"
    mysql -u root -pyour_password -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -u root -pyour_password -e "FLUSH PRIVILEGES;"
  EOL
end

# # secure install
# root_password = node["mysql"]["server_root_password"]
# execute "secure_install" do
#   command "/usr/bin/mysql -u root < #{chef::config[:file_cache_path]}/secure_install.sql"
#   action :nothing
#   only_if "/usr/bin/mysql -u root -e 'show databases;'"
# end
#
# template "#{chef::config[:file_cache_path]}/secure_install.sql" do
#   owner "root"
#   group "root"
#   mode 0644
#   source "secure_install.sql.erb"
#   variables({
#     :root_password => root_password,
#   })
#   notifies :run, "execute[secure_install]", :immediately
# end

default["mysql"]["user"] = "vagrant"
default["mysql"]["group"] = "vagrant"
default["mysql"]["server_root_password"] = ""
default["mysql"]["slave_ipaddress"] = "192.168.50.11"

default["mysql"]["versions"]   = "5.6.16-1.el6.x86_64"

default["mysql"]["rpm"] = [
  {
    :remote_uri   => "http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-server-5.6.16-1.el6.x86_64.rpm",
    :file_name    => "MySQL-server-5.6.16-1.el6.x86_64.rpm",
    :package_name => "MySQL-server"
  },
  {
    :remote_uri   => "http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-client-5.6.16-1.el6.x86_64.rpm",
    :file_name    => "MySQL-client-5.6.16-1.el6.x86_64.rpm",
    :package_name => "MySQL-client"
  },
  {
    :remote_uri   => "http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-devel-5.6.16-1.el6.x86_64.rpm",
    :file_name    => "MySQL-devel-5.6.16-1.el6.x86_64.rpm",
    :package_name => "MySQL-devel"
  },
  {
    :remote_uri   => "http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-shared-5.6.16-1.el6.x86_64.rpm",
    :file_name    => "MySQL-shared-5.6.16-1.el6.x86_64.rpm",
    :package_name => "MySQL-shared"
  }
]

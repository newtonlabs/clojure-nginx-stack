mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password 'password'
  action [:create, :start]
end

mysql_config 'default' do
  source 'mysite.cnf.erb'
  notifies :restart, 'mysql_service[default]'
  action :create
end

mysql_client 'default' do
  action :create
end
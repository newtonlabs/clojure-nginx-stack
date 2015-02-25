node[:clojure_apps].each do |app|
   git "/home/vagrant/#{app[:name]}" do
    repository "#{app[:git]}"
    reference "master"
    action :sync
    user "vagrant"
  end

  execute "uberjar" do
    user "vagrant"
    environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
    action :run
    cwd "/home/vagrant"
    command "cd #{app[:name]}; lein uberjar"
  end

  template "#{node['nginx']['dir']}/conf.d/#{app[:name]}.conf" do
    source 'clojure_apps.conf.erb'
    owner  'root'
    group  node['root_group']
    mode   '0644'
    variables :app => {:port => app[:port], :name => app[:name]}
    notifies :reload, 'service[nginx]'
  end
end
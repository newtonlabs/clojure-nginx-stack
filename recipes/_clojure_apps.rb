node[:clojure_apps].each do |app|
  template "#{node['nginx']['dir']}/conf.d/#{app[:name]}.conf" do
    source 'clojure_apps.conf.erb'
    owner  'root'
    group  node['root_group']
    mode   '0644'
    variables :app => {:port => app[:port], :name => app[:name]}
    notifies :reload, 'service[nginx]'
  end
end
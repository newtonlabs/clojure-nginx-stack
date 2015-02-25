# TODO, very brittle code.. pulling from master due to 
# compilaion error on 0.3.0 stable

edge        = "https://github.com/nginx-clojure/nginx-clojure/archive/master.zip"
clojure     = "http://repo1.maven.org/maven2/org/clojure/clojure/1.6.0/clojure-1.6.0.zip"
filename    = "nginx-clojure.zip"
file_path   = "#{Chef::Config[:file_cache_path]}"
working_dir = "#{file_path}/nginx-clojure-master"
config      = "#{working_dir}/src/c"

remote_file edge do
  path "#{file_path}/#{filename}"
  source edge
  action :create_if_missing
  notifies :run, "execute[unzip-clojure-nginx]", :immediately
end

execute "unzip-clojure-nginx" do
  command "cd #{file_path}; unzip -o #{filename}"
end

ruby_block "edit_config_file" do
  block do
    rc = Chef::Util::FileEdit.new("#{config}/config")
    rc.search_file_replace_line(/^JNI_HEADER_1/,
       "JNI_HEADER_1=/usr/lib/jvm/jdk1.7.0_75/include")
    rc.write_file
  end
end

execute "clojure-nginx-jar" do
  command "export LEIN_ROOT=true; cd #{working_dir}; lein jar"
  notifies :run, "execute[cp_jar_file]", :delayed
end

execute "cp_jar_file" do
  command "cp #{working_dir}/target/nginx-clojure-0.3.0.jar /opt"
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{config}"]
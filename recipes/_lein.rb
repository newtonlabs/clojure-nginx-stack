include_recipe "java"

remote_file "/usr/local/bin/lein" do
  source node[:leiningen][:install_script]
  owner "root"
  group "root"
  mode 0755
end


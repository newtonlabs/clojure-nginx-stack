execute "git_config_instead" do
  user "vagrant"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  action :run
  cwd "/home/vagrant"
  command 'git config --global url."http://".insteadOf git://'
end
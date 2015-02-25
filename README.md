# clojure-stack-cookbook

Download:

https://downloads.chef.io/chef-dk/
http://www.vagrantup.com/downloads.html
https://www.virtualbox.org/wiki/Downloads

TODO: Enter the cookbook description here.

SCP Command:
`scp -P 2222 nginx-clojure-0.3.0.tar.gz vagrant@127.0.0.1:/tmp`

Mysql Command line:
`mysql -h 127.0.0.1 --passsword=password --user=root`


## Error on chef folders not synced, this may go away with rsync
```bash
rm .vagrant/machines/default/virtualbox/synced_folders
vagrant reload --provision
```

# clojure-nginx-stack

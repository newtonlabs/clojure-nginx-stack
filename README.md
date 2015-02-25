# clojure-nginx-stack-cookbook

### Prereq Downloads:

* [Chef DK](https://downloads.chef.io/chef-dk/)
* [Vagrant](http://www.vagrantup.com/downloads.html)
* [Virtual Box](https://www.virtualbox.org/wiki/Downloads)

### Instructions

```
vagrant up
```

* Goto: [http://localhost:8080](http://localhost:8080)

### Helpful vagrant commands

```bash
# ssh to the box
vagrant ssh

# SCP example:
scp -P 2222 nginx-clojure-0.3.0.tar.gz vagrant@127.0.0.1:/tmp

# Mysql command line:
mysql -h 127.0.0.1 --passsword=password --user=root

# Mongo command line:
mongo
```

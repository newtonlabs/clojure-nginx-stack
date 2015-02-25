# clojure-nginx-stack-cookbook

### Prereq Downloads:

* [Chef DK](https://downloads.chef.io/chef-dk/)
* [Vagrant](http://www.vagrantup.com/downloads.html)
* [Virtual Box](https://www.virtualbox.org/wiki/Downloads)

### Instructions

```
vagrant up
```

* Goto: [http://localhost:8080/hello](http://localhost:8080/hello)

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

### What is going on here??

Using Chef to show how nginx-clojure works with external ring handler

* Creates vm
* Installs Java
* Installs mongo and mysql
* Compiles nginx with nginx-clojure moduule
* Deploys sample hello world application
* Configures nginx

Nginx Sample config:

```bash

# Located in (Created by Chef recipes: templates/default/clojure_apps.conf.erb)
/etc/nginx/conf.d/hello.conf

```

```nginx
### jvm dynamic library path
jvm_path '/usr/lib/jvm/jdk1.7.0_75/jre/lib/amd64/server/libjvm.so';

### application uberjar
jvm_var uberjar '/home/vagrant/hello/target/hello-world-0.1.0-SNAPSHOT-standalone.jar';

### my app classpath
jvm_options "-Djava.class.path=/opt/nginx-clojure-0.3.0.jar:#{uberjar}";

server {
  listen 8080;
  server_name localhost;
  location /hello {
    content_handler_type 'clojure';
    content_handler_name 'hello-world.core/handler';
  }
}
```

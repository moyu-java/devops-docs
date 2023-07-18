# 服务器安装后配置


## 安装 Node Js

```shell
# 解压缩
VERSION=v14.16.1
DISTRO=linux-x64
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs

# 编辑环境变量文件
vim /etc/profile

# 输入以下内容
# Nodejs
VERSION=v14.16.1
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH

# 重新载入
source /etc/profile

# 安装测试
node -v
npm version
npx -v
```

## 安装 Git

```shell
# 安装 git 
yum install -y git

# SSH RSA
ssh-keygen -t rsa
```

## 安装 Sublime Text

> 版本：Sublime Text 3 build 3211.
> 
> 状态：已测试

1. 修改 `hosts` 文件
   
   ```textile
   # block sublime text 3 build 3211.
   0.0.0.0 license.sublimehq.com
   0.0.0.0 45.55.255.55
   0.0.0.0 45.55.41.223
   127.0.0.1 www.sublimetext.com
   127.0.0.1 sublimetext.com
   127.0.0.1 sublimehq.com
   127.0.0.1 telemetry.sublimehq.com
   ```

2. 激活
   
   点击 Help - Enter License - use license.
   
   ```textile
   ----- BEGIN LICENSE -----
   Member J2TeaM
   Single User License
   EA7E-1011316
   D7DA350E 1B8B0760 972F8B60 F3E64036
   B9B4E234 F356F38F 0AD1E3B7 0E9C5FAD
   FA0A2ABE 25F65BD8 D51458E5 3923CE80
   87428428 79079A01 AA69F319 A1AF29A4
   A684C2DC 0B1583D4 19CBD290 217618CD
   5653E0A0 BACE3948 BB2EE45E 422D2C87
   DD9AF44B 99C49590 D2DBDEE1 75860FD2
   8C8BB2AD B2ECE5A4 EFC08AF2 25A9B864
   ------ END LICENSE ------
   ```

3. 汉化

先安装 `package control`，点击 Preferences - Install Package control 进行安装，等待安装完成。

使用快捷键 `Ctrl + Shift + p` ，输入 `install package`，等待一会，在弹出窗口中输入 `chinese` 搜索插件，安装 `ChineseLocalizations` 插件即可，安装成功后会自动切换到中文。

切换语言：帮助/Help - Language - 选择语言。

## 安装 python

```shell
# 安装编译环境包（防止出现安装错误）
yum install gcc-c++ gcc make cmake zlib-devel bzip2-devel openssl-devel ncurse-devel libffi-devel -y

#进入tmp目录
cd /tmp

#下载python3.7.3
wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tar.xz

# 解压
tar xvf Python-3.7.9.tar.xz
# 进入python3.7.3目录
cd Python-3.7.9
# 创建目录
mkdir -p /usr/local/python3
# 配置（指定安装目录）
./configure --prefix=/usr/local/python3 --enable-optimizations

# 编译及安装
make && 马克

# 更换系统默认Python版本
mv /usr/bin/python /usr/bin/python.bak
mkdir /usr/bin/pip
mv /usr/bin/pip /usr/bin/pip.bak

# 配置环境变量：创建新版本Python和pip的软链接
# 注意看版本
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip

# 查看Python版本
python -V

# 修改 yum 功能
# 因为yum的功能依赖Pyhon2，现在更改默认Python版本后会导致yum无法正常工作，所以进行以下3处修复
vim /usr/bin/yum
把最顶部的
改成：#！ /usr/bin/python2.7

第2处：
vim /usr/libexec/urlgrabber-ext-down
把最顶部的
改成：#！ /usr/bin/python2.7


/usr/sbin/firewalld

/usr/bin/firewall-cmd
```

## 安装 Docker

```shell
# 卸载老版本
yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine

# 设置仓库
yum install -y yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# 安装 Docker ce
yum install -y docker-ce docker-ce-cli containerd.io

# 设置开机自启
systemctl enable docker

# 安装验证
docker -v

# 阿里云镜像加速
# https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://38u6me2p.mirror.aliyuncs.com", "https://harbor.shiduai.com"]
}
EOF
systemctl daemon-reload
systemctl restart docker

# 启动 Docker
systemctl start docker
# 重启 Docker
systemctl restart docker
# 关闭 Docker
systemctl stop docker

# 更新 
yum update docker-ce docker-ce-cli containerd.io

# 卸载
yum remove docker-ce docker-ce-cli containerd.io
# 手动删除配置文件
rm -rf /var/lib/docker
```

## 安装 Docker Compose

```shell
# 下载 docker-compose 文件
# https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o cd /docker-compose

# 赋权
chmod +x /usr/local/bin/docker-compose

# 安装测试
docker-compose --version

# 卸载
rm /usr/local/bin/docker-compose
```

## 安装 maven

```shell
# 下载
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

# 解压到 /opt
sudo tar xf apache-maven-3.6.3-bin.tar.gz -C /opt

# 添加软链接
sudo ln -s /opt/apache-maven-3.6.3 /opt/maven

# 编辑环境变量文件
vim /etc/profile

# 添加到 /etc/profile 最后
# Maven
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}

# 重新载入
source /etc/profile

# 验证安装
mvn -version

# 配置私服, 编辑 settings.xml
vim /opt/maven/conf/settings.xml
```

## 安装 Nginx

**安装最新稳定版本**

```shell
# 官方文档 https://www.nginx.com/resources/wiki/start/topics/tutorials/install/
vim /etc/yum.repos.d/nginx.repo

# 添加以下内容
[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1

# 安装 nginx 
yum install -y nginx
```

**普通安装（推荐）**

```shell
# EPEL 仓库中有 Nginx 的安装包
sudo yum install -y epel-release

# 安装 Nginx
sudo yum install -y nginx

# 常用命令
# 开启 Nginx 开机启动
systemctl enable nginx

# 关闭 Nginx 开机启动
systemctl disable nginx

# 开启
systemctl start nginx

# 重启
systemctl restart nginx

# 停止
systemctl stop nginx

# 重载配置
systemctl reload nginx

# 查看运行状态
systemctl status nginx
```

静态文件目录：/usr/share/nginx/html
配置文件目录：/etc/nginx
日志文件目录：/var/log/nginx

**nginx.conf**

```
user  nginx;
worker_processes  1;
# 错误日志
error_log  /etc/nginx/logs/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    # 访问日志
    access_log  /etc/nginx/logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;
    # 包含配置文件
    include /etc/nginx/conf.d/*.conf;
}
```

**conf/default.conf**

```
upstream nacos {
    server 172.16.211.155:16600;
    server 172.16.211.156:16600;
    server 172.16.211.153:16600;
}

# 普通反向代理
server {
    listen       80;
    server_name  nacos.shiduai.com;

    return 307 https://nacos.shiduai.com$request_uri;
    # rewrite ^(.*)$  https://$host$1 permanent;
}

# HTTPS 反向代理
server {
    listen       443 ssl;
    server_name  nacos.shiduai.com;
    ssl_certificate   /home/cert/5257519__shiduai.com.pem;
    ssl_certificate_key  /home/cert/5257519__shiduai.com.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;

    access_log  /var/log/nginx/nacos/access.log;
    error_log /var/log/nginx/nacos/error.log;

    location /nacos/ {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_pass http://nacos/nacos/;    
    }
}

# 配置内网服务器访问
server {
    listen       80;
    server_name  nacos-inner.shiduai.com;

    access_log  /var/log/nginx/nacos/access.log;
    error_log /var/log/nginx/nacos/error.log;

    location /nacos/ {
        proxy_pass http://nacos/nacos/;
    }
}
```

## 安装 MySQL

**目录结构**

```
├─ master
│  ├─ Dockerfile
│  └─ my.cnf
├─ slave1
│  ├─ Dockerfile
│  └─ my.cnf
├─ slave2
│  ├─ Dockerfile
│  └─ my.cnf
└─ docker-compose.yml
```

**Dockerfile**

```properties
# master/Dockerfile
FROM mysql:5.7.17
MAINTAINER James
ADD ./master/my.cnf /etc/mysql/my.cnf

# slave1/Dockerfile
FROM mysql:5.7.17
MAINTAINER James
ADD ./slave1/my.cnf /etc/mysql/my.cnf

# slave2/Dockerfile
FROM mysql:5.7.17
MAINTAINER James
ADD ./slave2/my.cnf /etc/mysql/my.cnf
```

**master/my.cnf**

```properties
[mysqld]
## 设置server_id，一般设置为IP，注意要唯一
server_id=100

# 设置编码格式
character-set-server=utf8mb4
collation-server=utf8mb4_general_ci
character-set-client-handshake = FALSE
init_connect='SET NAMES utf8mb4'

#sql_mode='NO_ENGINE_SUBSTITUTION'
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

# 表名不区分大小写
lower_case_table_names=1

#开启慢查询
slow_query_log = ON
slow_query_log_file = /var/log/mysql/mysqlslowlog.log
long_query_time = 2

## 复制过滤：也就是指定哪个数据库不用同步（mysql库一般不同步）
binlog-ignore-db=mysql

## 开启二进制日志功能，可以随便取，最好有含义（关键就是这里了）
log-bin=mysql-master-bin

## 为每个session分配的内存，在事务过程中用来存储二进制日志的缓存
binlog_cache_size=1M

## 主从复制的格式（mixed,statement,row，默认格式是statement）
binlog_format=row

## 二进制日志自动删除/过期的天数。默认值为0，表示不自动删除。
expire_logs_days=7

## 跳过主从复制中遇到的所有错误或指定类型的错误，避免slave端复制中断。
## 如：1062错误是指一些主键重复，1032错误是因为主从数据库数据不一致
slave_skip_errors=1062

[mysqld_safe]
log-error=/var/log/mysql/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysql.server]
default-character-set = utf8mb4

[client]
default-character-set = utf8mb4
```

**slave1/my.cnf**

```properties
[mysqld]
## 设置server_id，一般设置为IP，注意要唯一
server_id=101

# 设置编码格式
character-set-server=utf8mb4
collation-server=utf8mb4_general_ci
character-set-client-handshake = FALSE
init_connect='SET NAMES utf8mb4'

#sql_mode='NO_ENGINE_SUBSTITUTION'
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

# 表名不区分大小写
lower_case_table_names=1

#开启慢查询
slow_query_log = ON
slow_query_log_file = /var/log/mysql/mysqlslowlog.log
long_query_time = 2


## 复制过滤：也就是指定哪个数据库不用同步（mysql库一般不同步）
binlog-ignore-db=mysql

## 开启二进制日志功能，可以随便取，最好有含义（关键就是这里了）
log-bin=mysql-slave1-bin

## 为每个session分配的内存，在事务过程中用来存储二进制日志的缓存
binlog_cache_size=1M

## 主从复制的格式（mixed,statement,row，默认格式是statement）
binlog_format=row

## 二进制日志自动删除/过期的天数。默认值为0，表示不自动删除。
expire_logs_days=7

## 跳过主从复制中遇到的所有错误或指定类型的错误，避免slave端复制中断。
## 如：1062错误是指一些主键重复，1032错误是因为主从数据库数据不一致
slave_skip_errors=1062

## relay_log 配置中继日志
relay_log=mysql-relay-bin

## log_slave_updates 表示 slave 将复制事件写进自己的二进制日志
log_slave_updates=1

## 防止改变数据(除了特殊的线程)
read_only=1

[mysqld_safe]
log-error=/var/log/mysql/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysql.server]
default-character-set = utf8mb4

[client]
default-character-set = utf8mb4
```

**slave2/my.cnf**

```properties
[mysqld]
## 设置server_id，一般设置为IP，注意要唯一
server_id=102

# 设置编码格式
character-set-server=utf8mb4
collation-server=utf8mb4_general_ci
character-set-client-handshake = FALSE
init_connect='SET NAMES utf8mb4'

#sql_mode='NO_ENGINE_SUBSTITUTION'
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

# 表名不区分大小写
lower_case_table_names=1

#开启慢查询
slow_query_log = ON
slow_query_log_file = /var/log/mysql/mysqlslowlog.log
long_query_time = 2


## 复制过滤：也就是指定哪个数据库不用同步（mysql库一般不同步）
binlog-ignore-db=mysql

## 开启二进制日志功能，可以随便取，最好有含义（关键就是这里了）
log-bin=mysql-slave2-bin

## 为每个session分配的内存，在事务过程中用来存储二进制日志的缓存
binlog_cache_size=1M

## 主从复制的格式（mixed,statement,row，默认格式是statement）
binlog_format=row

## 二进制日志自动删除/过期的天数。默认值为0，表示不自动删除。
expire_logs_days=7

## 跳过主从复制中遇到的所有错误或指定类型的错误，避免slave端复制中断。
## 如：1062错误是指一些主键重复，1032错误是因为主从数据库数据不一致
slave_skip_errors=1062

## relay_log 配置中继日志
relay_log=mysql-relay-bin

## log_slave_updates 表示 slave 将复制事件写进自己的二进制日志
log_slave_updates=1

## 防止改变数据(除了特殊的线程)
read_only=1

[mysqld_safe]
log-error=/var/log/mysql/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysql.server]
default-character-set = utf8mb4

[client]
default-character-set = utf8mb4
```

**docker-compose.yml**

```yaml
version: '3'
services:
  mysql-master:
    build:
      context: ./
      dockerfile: master/Dockerfile
    environment:
      - "MYSQL_ROOT_PASSWORD=Shiduai2020+"
      - "MYSQL_DATABASE=robot"
    links:
      - mysql-slave1
      - mysql-slave2
      - mysql-slave3
    ports:
      - "33067:3306"
    volumes:
      - ./master/conf:/etc/mysql/conf.d
      - ./master/data:/var/lib/mysql
      - ./master/logs:/logs
    networks:
      - dev
    restart: always
    hostname: mysql-master
    container_name: mysql-master

  mysql-slave1:
    build:
      context: ./
      dockerfile: slave1/Dockerfile
    environment:
      - "MYSQL_ROOT_PASSWORD=Shiduai2020+"
      - "MYSQL_DATABASE=robot"
    ports:
      - "33068:3306"
    volumes:
      - ./slave1/conf:/etc/mysql/conf.d
      - ./slave1/data:/var/lib/mysql
      - ./slave1/logs:/logs
    networks:
      - dev
    restart: always
    hostname: mysql-slave1
    container_name: mysql-slave1

  mysql-slave2:
    build:
      context: ./
      dockerfile: slave2/Dockerfile
    environment:
      - "MYSQL_ROOT_PASSWORD=Shiduai2020+"
      - "MYSQL_DATABASE=robot"
    ports:
      - "33069:3306"
    volumes:
      - ./slave2/conf:/etc/mysql/conf.d
      - ./slave2/data:/var/lib/mysql
      - ./slave2/logs:/logs
    networks:
      - dev
    restart: always
    hostname: mysql-slave2
    container_name: mysql-slave2
# 使用自定义网络
networks:
  dev:
    external: true
    driver: bridge
```

**配置过程**

```shell
# 启动 MySQL 容器
docker-compose up -d

# 查看编码
show variables like 'character%';
show variables like 'collation%';

# 查看时区
show variables like '%time_zone';
```

使用 `navicat` 连接数据库，可以直接外部连接，用户名为 `root` 或自定义用户名，密码为 `docker-compose.yml` 文件中配置的密码或自己配置的密码。

先连接主库，打开命令行页面，首先 **检查主库的状态**。

```shell
# 查看主库状态
show master status;
```

结果如下表所示：

| File                    | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
| ----------------------- | -------- | ------------ | ---------------- | ----------------- |
| mysql-master-bin.000003 | 154      |              | mysql            |                   |

记录 **主数据库** `binary-log` 的 **文件名称** 和 **数据同步起始位置**。

* File: mysql-master-bin.000003

* Position: 154

然后连接从库，打开从库的命令行界面，在从库上配置主库的信息，运行 SQL 语句如下：

```shell
# 从库下运行
CHANGE MASTER TO
    MASTER_HOST='mysql-master',
    MASTER_USER='root',
    MASTER_PASSWORD='root_password',
    MASTER_LOG_FILE='mysql-master-bin.000003',
    MASTER_LOG_POS=154;

# GTID
CHANGE MASTER TO
    MASTER_HOST='mysql-master',
    MASTER_USER='root',
    MASTER_PASSWORD='root_password',
    master_port=3306,
    master_auto_position=1;


# 运行后重启 slave
stop slave;
start slave;

# 检查 从库 的状态信息（最好在 Linux 中运行，navicat 显示格式有问题）
show slave status\G;
```

打开主库，并添加数据库，数据表，数据，然后查看主库是否同步。

如果配置成功之后，则可以修改账号密码。配置数据库的访问权限，默认是使用 root 登录，且允许外部访问所有权限，建议修改用户名，密码使用强密码，当所有配置完成后，建议将 root 账号修改为仅本地访问，另外开启一个用户，给外部访问。

```shell
# 进入 mysql-master 容器命令行
docker exec -it mysql-master bash

# 登录 MySQL，输入密码后进入
mysql -uroot -p

# 选择 mysql 数据库
use mysql;

# 权限赋予 - 所有权限
GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;

# 权限赋予 - 查询权限
GRANT SELECT ON *.* TO 'username'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;

# 刷新
FLUSH PRIVILEGES;

# MySQL 8 的操作
# 先创建用户
create user james@'%' identified WITH mysql_native_password by 'Shiduai2020+';

# 赋权 - 所有权限
grant all privileges on *.* to james@'%' with grant option;

# 赋权 - 只读权限
grant SELECT,LOCK TABLES,SHOW VIEW,PROCESS,REPLICATION SLAVE,REPLICATION CLIENT on *.* to james@'%' with grant option;

# 刷新
FLUSH PRIVILEGES;
```

配置完成后，再对主从库是否可以 同步进行检测。

## 安装 MaxScale

先搭建一个主从复制的MySQL集群，并开启GTID。（但是MaxScale好像并不支持）

**二进制文件安装**

下载 MaxScale 6.2 版本的RPM安装包。然后执行 `yum install -y maxscale_xxx.rpm` 命令安装。

```shell
# 生成密钥文件
maxkeys

# 生成密码
maxpasswd plainpassword

# 创建监控和路由所需的账号密码，可以分开创建，但我只创建一个
create user maxscale@'192.168.239.%' identified WITH mysql_native_password by 'your_password';
grant replication slave, replication client, select on *.* to maxscale@'192.168.239.%' with grant option;
flush privileges;

# 分开创建账号
# 监控账号
create user scalemon@'%' identified WITH mysql_native_password by "123456";
grant replication slave, replication client on *.* to scalemon@'%';

# 路由用户
create user maxscale@'%' identified WITH mysql_native_password by "123456";
grant select on mysql.* to maxscale@'%';
grant show databases on *.* to maxscale@'%';
flush privileges;

# 生成密码注意要使用 mysql_native_password 插件，否则无法登录。
# 要修改 caching_sha2_password 插件生成的密码使用下面的命令
alter user root@'%' identified WITH mysql_native_password by "V3Gezdrp1q3YD4mexFa1PzwN";
flush privileges;

# 查看用户信息
select host,user,plugin from mysql.user;
```

修改 `/etc/maxscale.cnf` 配置文件

```cnf
# maxscale 基本配置
[maxscale]
threads=auto
admin_host=0.0.0.0
admin_secure_gui=false

# 数据库集群配置
[mysql-master]
type=server
address=192.168.239.128
port=3306
protocol=MySQLBackend

[mysql-slave1]
type=server
address=192.168.239.129
port=3306
protocol=MySQLBackend

[mysql-slave2]
type=server
address=192.168.239.130
port=3306
protocol=MySQLBackend

# 监控模块
[MySQL-Monitor]
type=monitor
module=mysqlmon
servers=mysql-master,mysql-slave1,mysql-slave2
user=maxscale
password=4B6529D3E3353C59B4172CB3E903859E522E422BC2B0C6CC1550310F769A6DDAAEFD89D98566BB961E064C479A88B372
monitor_interval=2000
# 6.2 版本以下参数被废弃，不注释会异常
# 检查复制延迟
#detect_replication_lag=true
# 当前部 slave 都不可用时，select 查询请求会转发到 master.
#detect_stale_master=true

# ReadWriteSplit documentation:
# https://mariadb.com/kb/en/mariadb-maxscale-25-readwritesplit/

# 读写分离服务
[Read-Write-Service]
type=service
router=readwritesplit
servers=mysql-master,mysql-slave1,mysql-slave2
user=maxscale
password=4B6529D3E3353C59B4172CB3E903859E522E422BC2B0C6CC1550310F769A6DDAAEFD89D98566BB961E064C479A88B372
#max_slave_connections=100%
#max_slave_replication_lag=5
#use_sql_variables_in=all

# 监听器，也是外部连接数据库集群的入口
[Read-Write-Listener]
type=listener
service=Read-Write-Service
protocol=MySQLClient
port=4006
# 配置ipv4访问数据库，默认为ipv6
address=0.0.0.0

# MaxAdmin 服务，暂未测试
#[MaxAdmin-Service]
#type=service
#router=cli

#[MaxAdmin-Listener]
#type=listener
#service=MaxAdmin-Service
#protocol=maxscaled
#socket=default
```

修改完毕之后，启动 MaxScale。

```shell
# 启动
systemctl start   maxscale 
# 停止
systemctl stop    maxscale 
# 重启
systemctl restart maxscale 
# 状态
systemctl status  maxscale 

# 设置开机启动
systemctl enable  maxscale

# 查看端口 
ss -anptl | grep maxscale
```

查看运行状态。

```shell
# 列出 services
maxctrl list services
```

## 安装 MyCat

```shell
# 新建目录
mkdir /james/mycat
# 切换目录
cd /james/mycat
# 下载 mycat release1.6.7.6 到当前目录
wget http://dl.mycat.org.cn/1.6.7.6/20210303094759/Mycat-server-1.6.7.6-release-20210303094759-linux.tar.gz
mv Mycat-server-1.6.7.6-release-20210303094759-linux.tar.gz mycat-1.6.7.6.tar.gz
# 解压conf目录到当前目录，因为使用docker直接挂载conf目录会报错，mycat启动时需要依赖conf目录中的文件。
tar -zxvf mycat-1.6.7.6.tar.gz -C /james/ mycat/conf
```

## 安装 Nacos

**注：新版本Nacos的数据库文件是基于MySQL 8 的，权限表的 resource 字段长度要修改为190。否则索引会无法添加导致错误。**

**docker-compose.yml**

```yaml
version: "3"
services:
  nacos:
    image: nacos/nacos-server:2.0.2
    container_name: nacos
    volumes:
      - ./logs:/home/nacos/logs
      - ./config/custom.properties:/home/nacos/init.d/custom.properties
    environment:
      - "NACOS_SERVERS=192.168.142.139:15000 192.168.142.140:15000 192.168.142.141:15000"
      # 每台物理机使用各自的内网IP
      - "NACOS_SERVER_IP=192.168.142.139"
      - "NACOS_APPLICATION_PORT=15000"
      - "SPRING_DATASOURCE_PLATFORM=mysql"
      - "MYSQL_SERVICE_HOST=127.0.0.1"
      - "MYSQL_SERVICE_PORT=3306"
      - "MYSQL_SERVICE_DB_NAME=database_name"
      - "MYSQL_SERVICE_USER=username"
      - "MYSQL_SERVICE_PASSWORD=password"
      - "NACOS_AUTH_ENABLE=true"
      - "JVM_XMS=2g"
      - "JVM_XMX=2g"
      - "JVM_XMN=1g"
    ports:
      - 14000:14000
      - 15000:15000
      - 16000:16000
      - 16001:16001
    restart: always
```

**config/custom.properties**

```properties
### Connection pool configuration: hikariCP
db.pool.config.connectionTimeout=30000
db.pool.config.validationTimeout=10000
db.pool.config.maximumPoolSize=20
db.pool.config.minimumIdle=2

### Since 1.4.1, Turn on/off white auth for user-agent: nacos-server, only for upgrade from old version.
nacos.core.auth.enable.userAgentAuthWhite=false

### Since 1.4.1, worked when nacos.core.auth.enabled=true and nacos.core.auth.enable.userAgentAuthWhite=false.
### The two properties is the white list for auth and used by identity the request from other server.
nacos.core.auth.server.identity.key=nacosServer
# 建议使用高强度密码
nacos.core.auth.server.identity.value=valueSecret

#spring.security.enabled=false
#management.security=false
#security.basic.enabled=false
#nacos.security.ignore.urls=/**
#management.metrics.export.elastic.host=http://localhost:9200
# metrics for prometheus
#management.endpoints.web.exposure.include=*

# metrics for elastic search
#management.metrics.export.elastic.enabled=false
#management.metrics.export.elastic.host=http://localhost:9200

# metrics for influx
#management.metrics.export.influx.enabled=false
#management.metrics.export.influx.db=springboot
#management.metrics.export.influx.uri=http://localhost:8086
#management.metrics.export.influx.auto-create-db=true
#management.metrics.export.influx.consistency=one
#management.metrics.export.influx.compressed=true
```

**登录**

```shell
curl -X POST '127.0.0.1:15000/nacos/v1/auth/login' -d 'username=nacos&password=nacos'
```

**关闭双写**

```shell
curl -X PUT '127.0.0.1:15000/nacos/v1/ns/operator/switches?entry=doubleWriteEnabled&value=false&accessToken=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuYWNvcyIsImV4cCI6MTYyNzUwMTU5NX0.bhgCCThVyzqcPB_xbkFsdQHdjnaExKN9cCY-DMLFi50'
```

**查看状态**

```shell
curl localhost:15000/nacos/v1/ns/upgrade/ops/metrics?accessToken=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuYWNvcyIsImV4cCI6MTYyNzUwMTU5NX0.bhgCCThVyzqcPB_xbkFsdQHdjnaExKN9cCY-DMLFi50
```

## 安装 Redis

**docker-compose.yml**

```yaml
version: '3'
services:    
  redis:
    image: redis:6.0.5-alpine
    container_name: redis
    hostname: redis
    restart: always
    ports:
      - 6379:6379
    networks:
      - dev
    volumes:
      - ./conf/redis.conf:/usr/local/etc/redis/redis.conf
      - ./data:/data
    command: [ "redis-server", "/usr/local/etc/redis/redis.conf", "--appendonly yes" ]

networks:
  dev:
    external: true
```

## 安装 RabbitMQ

**docker-compose.yml**

```yaml
version: '3'
services:
  rabbit:
    image: rabbitmq:3.8-management
    container_name: rabbitmq
    hostname: rabbitmq
    restart: always
    ports:
      - 5672:5672
      - 15672:15672
    networks:
      - saturn
    volumes:
      - ./data:/var/lib/rabbitmq
    environment:
      - "RABBITMQ_DEFAULT_USER=james"
      - "RABBITMQ_DEFAULT_PASS=James2020+"

networks:
  saturn:
    external: true
```

## 安装 MongoDB

**docker-compose.yml**

```yml
version: '3.1'

services:
  mongo:
    image: mongo
    container_name: mongo
    restart: always
    networks:
      - dev
    ports:
      - 27017:27017
    volumes:
      - ./db:/data/db/
      - ./setup:/docker-entrypoint-initdb.d/
    environment:
      MONGO_INITDB_ROOT_USERNAME: shiduai
      MONGO_INITDB_ROOT_PASSWORD: ShiDuAI2020+
    command: mongod --auth

networks:
  dev:
    external: true
```

**命令安装**

```shell
参考地址：https://juejin.cn/post/6844903828811153421

# 创建 .repo 文件，生成 MongoDB 源
vim /etc/yum.repos.d/mongodb-org-4.4.repo

# 配置一下信息
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc

# 配置解释
name         # 名称
baseurl      # 获得下载的路径
gpkcheck=1   # 表示对从这个源下载的rpm包进行校验；
enable=1     # 表示启用这个源。
gpgkey       # gpg 验证

# 安装 mongodb 
sudo yum install -y mongodb-org

# 验证安装结果
rpm -qa |grep mongodb
rpm -ql mongodb-org-server

# 设置开机启动
systemctl enable mongod

# 启动
systemctl start mongod

# 关闭
systemctl stop mongod

# 重启
systemctl restart mongod

# 卸载 MongoDB
sudo yum erase $(rpm -qa | grep mongodb-org)    # 卸载MongoDB
sudo rm -r /var/log/mongodb  # 删除日志文件
sudo rm -r /var/lib/mongo    # 删除数据文件

# 修改配置文件
vi /etc/mongod.conf

# network interfaces
net:
  port: 27017
  bindIp: 0.0.0.0  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.

# 启用身份验证
security:
  authorization: "enabled"   # disable or enabled

# 本地连接 & 远程连接
mongo
mongo 10.128.218.14:27017

# 创建用户，设置账号、密码、权限
// admin数据库
> use admin
switched to db admin
> db.createUser({ user:"root", pwd:"123456", roles:["root"] })
Successfully added user: { "user" : "root", "roles" : [ "root" ] }

// 其他数据库
> use test
switched to db test
> db.createUser({ user:"admin", pwd:"123456", roles:["readWrite", "dbAdmin"] })
Successfully added user: { "user" : "root", "roles" : [ "root" ] }
```

## 安装 YApi

**普通安装**

```shell
# 1. 安装 MongoDB

# 2. 安装 YApi Server
npm install -g yapi-cli --registry https://registry.npm.taobao.org
yapi server 

# 3. 访问 127.0.0.1:9090 设置相关参数

# 4. 服务管理
npm install pm2 -g  //安装pm2
cd  {项目目录}
pm2 start "vendors/server/app.js" --name yapi //pm2管理yapi服务
pm2 info yapi //查看服务信息
pm2 stop yapi //停止服务
pm2 restart yapi //重启服务

# 5. 修改配置
{
   "port": "3000",
   "closeRegister": true,
   "adminAccount": "xingtuai@qq.com",
   "db": {
      "servername": "127.0.0.1",
      "DATABASE": "yapi",
      "port": "27017",
      "user": "yapi",
      "pass": "xxxxxxxxx"
   },
   "mail": {
      "enable": true,
      "host": "smtp.qq.com",
      "port": 465,
      "from": "xingtuai@qq.com",
      "auth": {
         "user": "xingtuai@qq.com",
         "pass": "xxxxxxxxx"
      }
   }
}
```

## 安装 Nexus

先创建持久化数据的目录并赋权

```shell
mkdir data && chown -R 200 data
```

**docker-compose.yml**

```yml
version: '3'
services:
  nexus:
    image: sonatype/nexus3
    container_name: nexus
    hostname: nexus
    restart: always
    ports:
      - 8081:8081
    volumes:
      - ./data:/nexus-data
```

**settings.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <pluginGroups>
  </pluginGroups>

  <proxies>
  </proxies>

  <servers>
    <server>
      <id>maven-releases</id>
      <username>admin</username>
      <password>sd123456ai</password>
    </server>

    <server>
      <id>maven-snapshots</id>
      <username>admin</username>
      <password>sd123456ai</password>
    </server>
  </servers>
  <mirrors>
    <mirror>
      <id>maven</id>
      <name>maven repository</name>
      <url>http://47.98.112.234:9081/repository/maven-public/</url>
      <mirrorOf>central</mirrorOf>
    </mirror>
  </mirrors>

  <profiles>
    <profile>
      <id>nexus</id> 
        <repositories>
            <repository>
                <id>maven</id>
                <name>maven repository</name>
                <url>http://47.98.112.234:9081/repository/maven-public/</url>
                <releases>
                    <enabled>true</enabled>
                </releases>
                <snapshots>
                    <enabled>false</enabled>
                </snapshots>
            </repository>
        </repositories>

        <pluginRepositories>
            <pluginRepository>
            <id>maven</id>
            <name>maven repository</name>
            <url>http://47.98.112.234:9081/repository/maven-public/</url>
            <releases>
                <enabled>true</enabled>
            </releases>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
            </pluginRepository>
        </pluginRepositories>
    </profile>
    <profile>
        <id>jdk-1.8</id>
        <activation>
          <activeByDefault>true</activeByDefault>
          <jdk>1.8</jdk>
        </activation>
        <properties>
          <maven.compiler.source>1.8</maven.compiler.source>
          <maven.compiler.target>1.8</maven.compiler.target>
          <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
        </properties>
    </profile>
  </profiles>


  <activeProfiles>
    <activeProfile>maven</activeProfile>
  </activeProfiles>
</settings>
```

## 安装 GitLab

先修改 SSH 端口，将 22 端口释放给 GitLab 使用。

**docker-compose.yml**

```yaml
web:
  image: 'gitlab/gitlab-ce:latest'
  restart: always
  container_name: 'gitlab'
  hostname: 'gitlab'
  ports:
    - '8000:8000'
    - '8443:443'
    - '22:22'
  volumes:
    - './conf:/etc/gitlab'
    - './logs:/var/log/gitlab'
    - './data:/var/opt/gitlab'
```

**配置过程**

```shell
# 启动 gitlab
docker-compose up -d

# 编辑 gitlab.rb，修改 external_url
external_url 'http://gitlab.junmoyu.com:8000'

# 配置邮箱 SMTP
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.qq.com"
gitlab_rails['smtp_port'] = 465
gitlab_rails['smtp_user_name'] = "moyu.j@qq.com"
gitlab_rails['smtp_password'] = "extnnmhlorptcadh"
gitlab_rails['smtp_domain'] = "qq.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
gitlab_rails['smtp_pool'] = false

gitlab_rails['gitlab_email_from'] = 'moyu.j@qq.com'
gitlab_rails['gitlab_email_display_name'] = '君莫语'

# 修改 Nginx 配置及监听端口
nginx['enable'] = true
nginx['listen_port'] = 8000

# 重新加载配置
docker exec -it gitlab gitlab-ctl reconfigure

# 进入 GitLab 容器
docker exec -it gitlab bash

# 进入 Rails console
gitlab-rails console

# 邮箱测试
Notify.test_email('moyu.j@qq.com', 'Message Subject', 'Message Body').deliver_now
```

## 安装 Jenkins

> 不要使用 Docker 安装，有不少问题。

```shell
# 添加 jenkins 源
sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# 更新（可不执行）
sudo yum upgrade

# 安装 jenkins
sudo yum install -y jenkins

sudo systemctl daemon-reload

# 启动 
sudo systemctl start jenkins

# 状态
sudo systemctl status jenkins

# 配置文件
vim /etc/sysconfig/jenkins
```

## 安装 ACME 脚本工具

```shell
# 安装 ACME 脚本
curl https://get.acme.sh | sh

# 创建别名
alias acme.sh=~/.acme.sh/acme.sh

# 配置阿里云的权限
# 上传 github 之前删除 secret
# https://ram.console.aliyun.com/users/james
export Ali_Key="LTAI4FwZLVXSxX7QfpwtigFu"
export Ali_Secret="Ksz26aBErU3NVxGejTsDoDH9nEPtK6"

# 生成域名证书
acme.sh --issue --dns dns_ali -d gitlab.junmoyu.com --keylength ec-256

# 复制到 Nginx 中
acme.sh --ecc --installcert -d gitlab.xingtuai.com \
        --key-file /root/cert/gitlab.xingtuai.com/gitlab.xingtuai.com.key \
        --fullchain-file /root/cert/gitlab.xingtuai.com/fullchain.cer \
        --reloadcmd "docker exec -it nginx service nginx reload"
```

## 安装 Prometheus 系列

**Prometheus Docker 安装**

**docker-compose.yaml**

```yaml
version: "2"
services:
  prometheus:
    container_name: prometheus
    image: prom/prometheus:latest
    volumes:
      - ./prometheus/prometheus-standalone.yaml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"
    restart: on-failure
  grafana:
    container_name: grafana
    image: grafana/grafana:latest
    ports:
      - 3005:3000
    restart: on-failure
```

**prometheus-standalone.yaml**

```yaml
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
# - "first_rules.yml"
# - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ['192.168.9.17:9090']

  - job_name: 'nacos'
    metrics_path: '/nacos/actuator/prometheus'
    static_configs:
      - targets: ['47.98.112.234:8848']
```

**Prometheus 安装包安装**

```shell
# 网页下载地址： https://prometheus.io/download/
# 下载
wget https://github.com/prometheus/prometheus/releases/download/v2.21.0/prometheus-2.21.0.linux-amd64.tar.gz

# 解压
tar -xvzf prometheus-2.21.0.linux-amd64.tar.gz
mv prometheus-2.21.0.linux-amd64.tar.gz prometheus-2.21.0

cd prometheus-2.21.0
cp prometheus /usr/local/bin/
cp promtool /usr/local/bin/

# 启动
nohup prometheus --config.file=/extcd1/soft/prometheus/prometheus-2.21.0/prometheus.yml --web.enable-lifecycle --web.listen-address=:19090 &

# 额外参数
--web.enable-admin-api : 开放api接口，快照功能、数据删除功能、数据清理功能
--web.enable-lifecycle : 允许热更新新配置

# 热加载配置文件
curl -X POST http://localhost:19090/-/reload

# 删除数据
curl -X POST -g 'http://localhost:9090/api/v1/admin/tsdb/delete_series?match[]={job="kubernetes-service-endpoints"}'
```

**grafana 安装**

```shell
# 安装
wget https://dl.grafana.com/oss/release/grafana-7.2.1-1.x86_64.rpm
sudo yum install grafana-7.2.1-1.x86_64.rpm

# 启动/关闭
sudo service grafana-server start
sudo service grafana-server status

# 开机启动
sudo /sbin/chkconfig --add grafana-server
```

**node exporter**

```shell
# 网页下载地址： https://prometheus.io/download/#node_exporter
# 下载
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz

# 解压
tar -xvzf node_exporter-1.0.1.linux-amd64.tar.gz
mv node_exporter-1.0.1.linux-amd64 node_exporter

cd node_exporter
cp node_exporter /usr/local/bin/

# 启动
node_exporter
nohup node_exporter &

# 查看版本
node_exporter --version
```

**Alert Manager**

```shell
# 网页下载地址： https://prometheus.io/download/#alertmanager
# 下载
export VERSION=0.21.0
curl -LO https://github.com/prometheus/alertmanager/releases/download/v$VERSION/alertmanager-$VERSION.linux-amd64.tar.gz

# 解压
tar -xvf alertmanager-$VERSION.linux-amd64.tar.gz

# 修改目录名
mv alertmanager-0.21.0.linux-amd64 alertmanager-0.21.0

cp alertmanager /usr/local/bin/
```

## 安装 RocketMQ

**普通安装**

```shell
# 下载文件地址：https://rocketmq.apache.org/dowloading/releases/
# 下载此文件到本地： rocketmq-all-4.7.1-bin-release.zip
# 解压
$ yum install -y unzip
$ unzip rocketmq-all-4.7.1-bin-release.zip
$ mv rocketmq-all-4.7.1-bin-release.zip rocketmq-4.7.1

$ cd rocketmq-4.7.1

# 配置内存
vim bin/runbroker.sh

JAVA_OPT="${JAVA_OPT} -server -Xms8g -Xmx8g -Xmn4g"
修改为
JAVA_OPT="${JAVA_OPT} -server -Xms512m -Xmx512m -Xmn128m"

vim bin/runserver.sh

JAVA_OPT="${JAVA_OPT} -server -Xms8g -Xmx8g -Xmn4g"
修改为
JAVA_OPT="${JAVA_OPT} -server -Xms512m -Xmx512m -Xmn128m"

# 启动 name server
$ nohup sh bin/mqnamesrv &
$ tail -f ~/logs/rocketmqlogs/namesrv.log
The Name Server boot success...

# 启动 broker server
$ nohup sh bin/mqbroker -n localhost:9876 &
$ tail -f ~/logs/rocketmqlogs/broker.log
The broker[%s, 172.30.30.233:10911] boot success...

# 发送消息测试
$ export NAMESRV_ADDR=localhost:9876
$ sh bin/tools.sh org.apache.rocketmq.example.quickstart.Producer
SendResult [sendStatus=SEND_OK, msgId= ...

# 接收消息测试
$ sh bin/tools.sh org.apache.rocketmq.example.quickstart.Consumer
 ConsumeMessageThread_%d Receive New Messages: [MessageExt...

 # 关闭服务
$ sh bin/mqshutdown broker
The mqbroker(36695) is running...
Send shutdown request to mqbroker(36695) OK

$ sh bin/mqshutdown namesrv
The mqnamesrv(36664) is running...
Send shutdown request to mqnamesrv(36664) OK
```

**Docker 安装**

**docker-compose.yml**

```yaml
version: '3.5'
services:
  rmqnamesrv:
    image: foxiswho/rocketmq:server
    container_name: rmqnamesrv
    ports:
      - 9876:9876
    volumes:
      - ./rmqs/logs:/opt/logs
      - ./rmqs/store:/opt/store
    networks:
        dev:
          aliases:
            - rmqnamesrv

  rmqbroker:
    image: foxiswho/rocketmq:broker
    container_name: rmqbroker
    ports:
      - 10909:10909
      - 10911:10911
    volumes:
      - ./rmq/logs:/opt/logs
      - ./rmq/store:/opt/store
      - ./rmq/conf/broker.conf:/etc/rocketmq/broker.conf
    environment:
        NAMESRV_ADDR: "rmqnamesrv:9876"
        JAVA_OPTS: " -Duser.home=/opt"
        JAVA_OPT_EXT: "-server -Xms128m -Xmx128m -Xmn128m"
    command: mqbroker -c /etc/rocketmq/broker.conf
    depends_on:
      - rmqnamesrv
    networks:
      dev:
        aliases:
          - rmqbroker

  rmqconsole:
    image: styletang/rocketmq-console-ng
    container_name: rmqconsole
    ports:
      - 8880:8080
    volumes:
      - ./console/data:/tmp/rocketmq-console/data
    environment:
        JAVA_OPTS: "-Drocketmq.namesrv.addr=rmqnamesrv:9876 -Dcom.rocketmq.sendMessageWithVIPChannel=false"
    depends_on:
      - rmqnamesrv
    networks:
      dev:
        aliases:
          - rmqconsole

networks:
  dev:
    name: dev
    driver: bridge
```

**broker.conf**

```
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.


# 所属集群名字
brokerClusterName=DefaultCluster

# broker 名字，注意此处不同的配置文件填写的不一样，如果在 broker-a.properties 使用: broker-a,
# 在 broker-b.properties 使用: broker-b
brokerName=broker-a

# 0 表示 Master，> 0 表示 Slave
brokerId=0

# nameServer地址，分号分割
# namesrvAddr=rocketmq-nameserver1:9876;rocketmq-nameserver2:9876

# 启动IP,如果 docker 报 com.alibaba.rocketmq.remoting.exception.RemotingConnectException: connect to <192.168.0.120:10909> failed
# 解决方式1 加上一句 producer.setVipChannelEnabled(false);，解决方式2 brokerIP1 设置宿主机IP，不要使用docker 内部IP
# brokerIP1=192.168.0.253

# 在发送消息时，自动创建服务器不存在的topic，默认创建的队列数
defaultTopicQueueNums=4

# 是否允许 Broker 自动创建 Topic，建议线下开启，线上关闭 ！！！这里仔细看是 false，false，false
autoCreateTopicEnable=true

# 是否允许 Broker 自动创建订阅组，建议线下开启，线上关闭
autoCreateSubscriptionGroup=true

# Broker 对外服务的监听端口
listenPort=10911

# 删除文件时间点，默认凌晨4点
deleteWhen=04

# 文件保留时间，默认48小时
fileReservedTime=120

# commitLog 每个文件的大小默认1G
mapedFileSizeCommitLog=1073741824

# ConsumeQueue 每个文件默认存 30W 条，根据业务情况调整
mapedFileSizeConsumeQueue=300000

# destroyMapedFileIntervalForcibly=120000
# redeleteHangedFileInterval=120000
# 检测物理文件磁盘空间
diskMaxUsedSpaceRatio=88
# 存储路径
# storePathRootDir=/home/ztztdata/rocketmq-all-4.1.0-incubating/store
# commitLog 存储路径
# storePathCommitLog=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/commitlog
# 消费队列存储
# storePathConsumeQueue=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/consumequeue
# 消息索引存储路径
# storePathIndex=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/index
# checkpoint 文件存储路径
# storeCheckpoint=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/checkpoint
# abort 文件存储路径
# abortFile=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/abort
# 限制的消息大小
maxMessageSize=65536

# flushCommitLogLeastPages=4
# flushConsumeQueueLeastPages=2
# flushCommitLogThoroughInterval=10000
# flushConsumeQueueThoroughInterval=60000

# Broker 的角色
# - ASYNC_MASTER 异步复制Master
# - SYNC_MASTER 同步双写Master
# - SLAVE
brokerRole=ASYNC_MASTER

# 刷盘方式
# - ASYNC_FLUSH 异步刷盘
# - SYNC_FLUSH 同步刷盘
flushDiskType=ASYNC_FLUSH

# 发消息线程池数量
# sendMessageThreadPoolNums=128
# 拉消息线程池数量
# pullMessageThreadPoolNums=128
```

## 安装 ZooKeeper

```shell
# 下载
wget https://mirrors.bfsu.edu.cn/apache/zookeeper/zookeeper-3.6.2/apache-zookeeper-3.6.2-bin.tar.gz

# 解压
tar -zxvf apache-zookeeper-3.6.2-bin.tar.gz

# 重命名
mv apache-zookeeper-3.6.2-bin zookeeper-3.6.2

# 创建配置文件
cd zookeeper-3.6.2/conf
cp zoo_sample.cfg zoo.cfg

# 启动
sh bin/zkServer.sh start

# 停止
sh bin/zkServer.sh stop

# 查看状态
sh bin/zkServer.sh status

# 客户端连接
# 本地
sh bin/zkCli.sh
# 远程
sh bin/zkCli.sh -server 127.0.0.1:2181
```

## 安装 ClamAV

```shell
# 安装
yum install -y epel-release
yum install -y clamav

# 更新病毒库
sudo freshclam

# 创建扫描日志目录及恶意软件存放目录
mkdir -p ~/clamav/log/
mkdir -p ~/clamav/quarantine/

# 开始扫描
clamscan -i -r --log=~/clamav/log/scan.log --move=~/clamav/quarantine/ ~/sda
```

参考文档：[记一次Linux木马清除过程](https://www.freebuf.com/articles/system/208804.html)

## 安装 elasticsearch

**安装前系统设置**

1. 修改/etc/security/limits.conf 
   
   ```shell
   # End of file
   root soft nofile 65535
   root hard nofile 65535
   * soft nofile 65535
   * hard nofile 65535
   ```

2. 修改/etc/security/limits.d/20-nproc.conf

要先给挂载目录赋予权限：

```shell
chown -R 1000:1000 ./es/data
```

**Docker 安装**

```yaml
version: '2.2'
services:
  es01:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.12.0
    container_name: es01
    environment:
      - node.name=es01
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es02,es03
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./data01:/usr/share/elasticsearch/data
    ports:
      - 18200:9200
    networks:
      - elastic
  es02:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.12.0
    container_name: es02
    environment:
      - node.name=es02
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es01,es03
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./data02:/usr/share/elasticsearch/data
    networks:
      - elastic
  es03:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.12.0
    container_name: es03
    environment:
      - node.name=es03
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es01,es02
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./data03:/usr/share/elasticsearch/data
    networks:
      - elastic

volumes:
  data01:
    driver: local
  data02:
    driver: local
  data03:
    driver: local

networks:
  elastic:
    driver: bridge
```

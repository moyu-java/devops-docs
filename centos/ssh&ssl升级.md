yum update -y

## 安装依赖库
yum install -y gcc zlib-devel pam-devel openssl-devel

## 备份
mv /etc/ssh /etc/ssh.bak && mv /usr/bin/ssh /usr/bin/ssh.bak && mv /usr/sbin/sshd /usr/sbin/sshd.bak

## 卸载 ssh
systemctl stop sshd
rpm -qa | grep openssh
yum remove openssh*

## 安装 openssl
## 下载 openssl
wget https://www.openssl.org/source/openssl-1.1.1k.tar.gz

## 解压并安装
tar -zxvf openssl-1.1.1k.tar.gz && cd openssl-1.1.1k
./config --prefix=/usr --openssldir=/etc/ssl shared
make && make install

## 安装 openssh
## 下载 openssh
wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.6p1.tar.gz

## 解压并安装
tar -zxvf openssh-8.6p1.tar.gz && cd openssh-8.6p1

./configure --with-zlib --with-ssl-dir --with-pam --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc/ssh

make && make install

## 授权
chmod 600 /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_ed25519_key

cp -a contrib/redhat/sshd.init /etc/init.d/sshd
cp -a contrib/redhat/sshd.pam /etc/pam.d/sshd.pam

chmod u+x /etc/init.d/sshd
vim /etc/ssh/sshd_config

## 修改配置

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config



## 设置开机自启

chkconfig --add sshd && chkconfig sshd on

## 重启SSH

systemctl daemon-reload
service sshd restart
systemctl restart sshd

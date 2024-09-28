# debian 12

## 信息查看

### 查看系统版本

```shell
# 查看系统发行版本
cat /etc/os-release

# 查看 debian 版本号
cat /etc/debian_version

# 查看 linux 内核版本号
uname -r
uname -a
cat /proc/version
```

## 切换国内源

debian 系统安装进行到 `Configure the package manager` 步骤时，可以在 `Debian archive mirror country` 选择软件仓库镜像国家为 `China`， 然后就可以选择很多国内镜像了，如中科大的镜像 `mirrors.ustc.edu.cn`。

如果系统已经安装好的话，也可以使用下面的命令配置国内镜像。

```shell
# 先备份原有软件源文件
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 编辑软件源文件
sudo vim /etc/apt/sources.list
```

原软件源文件中的内容可以直接删除，或者全部注释，然后将下面的内容复制进去就可以了。

```plaintext
# 中科大的源 - https://mirrors.ustc.edu.cn/help/debian.html
deb http://mirrors.ustc.edu.cn/debian/ bookworm main non-free-firmware
deb-src http://mirrors.ustc.edu.cn/debian/ bookworm main non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware

deb http://mirrors.ustc.edu.cn/debian/ bookworm-updates main non-free-firmware
deb-src http://mirrors.ustc.edu.cn/debian/ bookworm-updates main non-free-firmware
```

```shell
# 更新软件包列表以应用新的软件源
sudo apt update

# 更新软件包（可选）
sudo apt upgrade
```

## SSH

在 Debian 系统中，不建议直接允许远程 root 账号访问，因为这会带来较大的安全风险。但如果你确实需要进行这样的配置，可以按照以下步骤进行操作，但请务必谨慎并确保你的系统处于安全的网络环境中。

1. 打开 SSH 配置文件

```shell
sudo vim /etc/ssh/sshd_config
```

2. 找到以下行并进行修改

`PermitRootLogin prohibit-password`（默认可能是这个值）或者 `PermitRootLogin no`
将其修改为 `PermitRootLogin yes`

3. 重启 SSH 服务

保存配置文件后，重启 SSH 服务

```shell
sudo systemctl restart sshd
```

## 代理设置

### 终端代理

1. 开启 `Allow LAN` 功能

![Allow-LAN](https://cdn.jsdelivr.net/gh/moyu-jun/resource/img/clash-allow-lan.png)

2. 查看虚拟网卡的IP

如果是 vmware 安装的系统，可以设置网络模式为 NAT 模式，该模式会使用 `VMnet8` 虚拟网卡。

![VMnet8-ip](https://cdn.jsdelivr.net/gh/moyu-jun/resource/img/clash-vmnet8-ip.png)

3. 添加代理

编辑 `~/.bashrc` 文件，添加如下内容：

```shell
# http proxy
proxy_host=192.168.137.1
export https_proxy=http://$proxy_host:7890
export http_proxy=http://$proxy_host:7890
export all_proxy=socks5://$proxy_host:7890
```

`proxy_host` 为上一步中 `VMnet8` 虚拟网卡的IP，

4. 验证

设置代理后，可以使用以下命令请求 `google` 用以验证。

```shell
curl www.google.com
```

### 为特定应用程序设置代理

不同的应用程序可能有不同的方法来设置代理。例如，对于 git：

1. 设置全局代理：
```shell
git config --global http.proxy http://192.168.137.1:7890
git config --global https.proxy http://192.168.137.1:7890
```

2. 取消代理：
```shell
git config --global --unset http.proxy
git config --global --unset https.proxy
```
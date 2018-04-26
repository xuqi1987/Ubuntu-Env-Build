# Ubuntu-Evn-Build


### 修改SSH端口号
	vi /etc/ssh/sshd_config  
	Port 22222

### 安装Docker环境
	wget -qO- https://get.docker.com/ | sh

### 搭建SS翻墙服务器
	docker run -dt --name ss -p 6443:6443 mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k 123456 --fast-open"


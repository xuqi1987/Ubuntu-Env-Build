# Ubuntu-Evn-Build


### 修改SSH端口号
	vi /etc/ssh/sshd_config  
	Port 22222

### 安装Docker环境
	wget -qO- https://get.docker.com/ | sh

### 搭建SS翻墙服务器
	docker run -dt --name ss -p 6443:6443 mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k 123456 --fast-open"


### 安装mysql Server
	mkdir -p ~/mysql/data ~/mysql/logs ~/mysql/conf
	cd ~/mysql
	docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/mysql_data -e MYSQL_ROOT_PASSWORD=Xq111111 -d mysql

##### 使用Docker Client 连接Mysql
	alias mysql_c='docker run -it --rm mysql mysql'
	mysql_c -hx1000.top -uroot -p
	
### 安装Nginx
	mkdir -p ~/nginx/www ~/nginx/logs ~/nginx/conf
	cd ~/nginx
	chmod -R 755 www/
	docker run -p 80:80 --name mynginx -v $PWD/www:/www -v $PWD/conf/nginx.conf:/etc/nginx/conf.d/ -v $PWD/logs:/wwwlogs  -d nginx  

### 安装phpMyAdmin
	docker run --name myadmin -d --link mymysql:db -p 8080:80 phpmyadmin/phpmyadmin
	
### 安装adminer
	docker run --name myadminer -d --link mymysql:db -p 8081:8080 adminer

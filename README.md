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
	docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/mysql_data -e MYSQL_ROOT_PASSWORD=Xq111111 -d mysql:5.7

##### 使用Docker Client 连接Mysql
	alias mysql_c='docker run -it --rm mysql mysql'
	mysql_c -hx1000.top -uroot -p
	
### 安装Nginx
	mkdir -p ~/nginx/www ~/nginx/logs ~/nginx/conf
	cd ~/nginx
	chmod -R 755 www/
	docker run -p 80:80 --name mynginx -v $PWD/www:/www -v $PWD/conf/nginx.conf:/etc/nginx/conf.d/ -v $PWD/logs:/wwwlogs  -d nginx  

### 安装phpMyAdmin
	docker run --name myadmin -d --link mymysql:db -p 8082:80 phpmyadmin/phpmyadmin
	
### 安装adminer
	docker run --name myadminer -d --link mymysql:db -p 8081:8080 adminer

### 安装 WordPress
	docker run --name mywordpress -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=Xq111111 --link mymysql:mysql -p 8001:80 -d wordpress

###	Docker 安装 Redis
	mkdir -p ~/redis ~/redis/data
	cd ~/redis
	docker run --name myredis -p 6379:6379 -v $PWD/data:/data  -d redis:3.2 redis-server --appendonly yes

###	使用Docker Client 连接Redis
	alias redis-cli='docker exec -it myredis redis-cli'
	redis-cli

### 安装mongo
	mkdir -p ~/mongo  ~/mongo/db
	cd ~/mongo
	docker run --name mymongo -p 27017:27017 -v $PWD/db:/data/db -d mongo:3.2

### 使用Docker Client 连接mongo
	alias mongo='docker run -it mongo:3.2 mongo'
	mongo --host x1000.top

### 安装ownCloud
	mkdir -p ~/ownCloud/apps ~/ownCloud/config 
	ln -s ~/data ~/ownCloud/data
	cd ~/ownCloud
	docker run  --name myownCloud -p 8083:80 -v $PWD/apps:/var/www/html/apps -v $PWD/config:/var/www/html/config -v $PWD/data:/var/www/html/data -d owncloud:8.1
	
### 安装aria2-with-webui
	mkdir -p ~/aria2/conf 
	ln -s ~/data ~/aria2/data
	cd ~/aria2
	docker run -d --name myaria2 -p 6800:6800 -p 8084:80 -p 6888:8080 -v $PWD/data:/data -v $PWD/conf:/conf -e SECRET=Xq111111 xujinkai/aria2-with-webui
	
### 安装filebrowser
	mkdir -p  ~/filebrowser
	ln -s ~/data ~/filebrowser/data
	cd ~/filebrowser
	docker run -d --name myfilebrowser -v $PWD/data:/srv -p 8085:80 hacdias/filebrowser
	
### 安装h5ai
	mkdir -p ~/h5ai
	ln -s ~/data ~/h5ai/data
	cd ~/h5ai
	docker run -d --name myh5ai -p 8087:80 -v $PWD/data:/var/www -v $PWD/h5ai.nginx.conf:/etc/nginx/sites-enabled/h5.conf corfr/h5ai
	

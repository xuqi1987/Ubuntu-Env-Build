# Ubuntu 后端配置 Docker


## 修改SSH端口号
```shell
vi /etc/ssh/sshd_config  
Port 22222
```

### Docker 服务器搭建

#### 安装Docker软件安装

```shell
wget -qO- https://get.docker.com/ | sh
```

### 数据库相关

#### mysql Server

```powershell
mkdir -p ~/mysql/data ~/mysql/logs ~/mysql/conf
cd ~/mysql
docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/mysql_data -e MYSQL_ROOT_PASSWORD=Xq111111 -d mysql:5.7
```

#### Mysql Client

```powershell
alias mysql_c='docker run -it --rm mysql mysql'
mysql_c -hx1000.top -uroot -p
```

#### phpMyAdmin

```powershell
docker run --name myadmin -d --link mymysql:db -p 8082:80 phpmyadmin/phpmyadmin
```

#### adminer

```powershell
docker run --name myadminer -d --link mymysql:db -p 8081:8080 adminer
```

#### Redis

```
mkdir -p ~/redis ~/redis/data
cd ~/redis
docker run --name myredis -p 6379:6379 -v $PWD/data:/data  -d redis:3.2 redis-server --appendonly yes
```

#### Redis Client

```powershell
alias redis-cli='docker exec -it myredis redis-cli'
redis-cli
```

#### mongo

```powershell
mkdir -p ~/mongo  ~/mongo/db
cd ~/mongo
docker run --name mymongo -p 27017:27017 -v $PWD/db:/data/db -d mongo:3.2
```

#### mongo Client

```powershell
alias mongo='docker run -it mongo:3.2 mongo'
mongo --host x1000.top
```

### 其他功能

#### shadowsocks

```shell
docker run -dt --name ss -p 6443:6443 mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k 123456 --fast-open"
```

#### Nginx

```powershell
mkdir -p ~/nginx/www ~/nginx/logs ~/nginx/conf
cd ~/nginx
chmod -R 755 www/
docker run -p 80:80 --name mynginx -v $PWD/www:/www -v $PWD/conf/nginx.conf:/etc/nginx/conf.d/ -v $PWD/logs:/wwwlogs  -d nginx  
```



### 网站相关

####  WordPress
```powershell
docker run --name mywordpress -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=Xq111111 --link mymysql:mysql -p 8001:80 -d wordpress
```

#### ownCloud
	mkdir -p ~/ownCloud/apps ~/ownCloud/config 
	ln -s ~/data ~/ownCloud/data
	cd ~/ownCloud
	docker run  --name myownCloud -p 8083:80 -v $PWD/apps:/var/www/html/apps -v $PWD/config:/var/www/html/config -v $PWD/data:/var/www/html/data -d owncloud:8.1

#### aria2-with-webui
	mkdir -p ~/aria2/conf 
	ln -s ~/data ~/aria2/data
	cd ~/aria2
	docker run -d --name myaria2 -p 6800:6800 -p 8084:80 -p 6888:8080 -v $PWD/data:/data -v $PWD/conf:/conf -e SECRET=Xq111111 xujinkai/aria2-with-webui

#### filebrowser
	mkdir -p  ~/filebrowser
	ln -s ~/data ~/filebrowser/data
	cd ~/filebrowser
	docker run -d --name myfilebrowser -v $PWD/data:/srv -p 8085:80 hacdias/filebrowser

#### h5ai
	mkdir -p ~/h5ai
	ln -s ~/data ~/h5ai/data
	cd ~/h5ai
	docker run -d --name myh5ai -p 8087:80 -v $PWD/data:/var/www -v $PWD/h5ai.nginx.conf:/etc/nginx/sites-enabled/h5.conf corfr/h5ai

#### Hexo
	mkdir -p ~/hexo
	cd ~/hexo
	git clone https://github.com/xuqi1987/Hexo-Github-Blog.git
	git clone https://github.com/xuqi1987/xuqi1987.github.io.git
	docker run  -d --name myhexo -p 8090:4000 -v $PWD/Hexo-Github-Blog:/opt/hexo/ipple1986 ipple1986/hexo
	
	alias hexo='docker exec -it myhexo hexo'

#### Domoticz
	mkdir -p ~/Domoticz/config
	cd ~/Domoticz
	docker run -d -i -t --name mydomoticz -p 9000:31080 -p 443:31443 -v $PWD/config:/config dt27/domoticz-cn:Stable```
docker exec domoticz crond

网页登录帐号密码均为`domoticz`


### 安装frps
	git clone https://github.com/fatedier/frp.git
	cd frp
	docker build . -t xuqi/frps
	docker run -d --name myfrps -p 7000:7000 -p 6000:6000 -p 6001:6001 -v $PWD/conf:/conf xuqi/frps

### 安装aria2-ariang
	mkdir -p ~/aria2-ariang
	cd aria2-ariang
	ln -s ~/data ./data
	docker run -d --name myariang -p 8089:80 -p 6800:6800  -v $PWD/data/download:/data  wahyd4/aria2-ariang	

### Celery
	docker run --link myredis:redis -e CELERY_BROKER_URL=redis://localhost:6379/0 --name mycelery -d celery

### Node-RED

```powershell
mkdir -p ~/node-red-data
cd node-red-data
docker run -d --name mynodered -p 1880:1880 -v ~/node-red-data:/data  nodered/node-red-docker
```


### mosquitto
	mkdir -p ~/mosquitto/config
	mkdir -p ~/mosquitto/data
	mkdir -p ~/mosquitto/log
	cd mosquitto
	docker run -d --name mymosquitto -p 1883:1883 -p 9001:9001 -v mosquitto.conf:$PWD/config/mosquitto.conf -v $PWD/data -v $PWD/log eclipse-mosquitto



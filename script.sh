wget -qO- https://get.docker.com/ | sh

docker run -dt --name ss -p 6443:6443 mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k 123456 --fast-open"

mkdir -p ~/mysql/data ~/mysql/logs ~/mysql/conf
cd ~/mysql
docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/mysql_data -e MYSQL_ROOT_PASSWORD=Xq111111 -d mysql:5.7

mkdir -p ~/nginx/www ~/nginx/logs ~/nginx/conf
chmod -R 755 www/
cd ~/nginx
docker run -p 80:80 --name mynginx -v $PWD/www:/www -v $PWD/conf/nginx.conf:/etc/nginx/conf.d/ -v $PWD/logs:/wwwlogs  -d nginx  

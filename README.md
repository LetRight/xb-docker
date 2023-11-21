
### xboard-docker webman 安装指南

#### 1. 安装所需组件
安装 `curl` 和 `git`：
```bash
apt install curl git -y
```
此外，宿主机需要安装nginx和mysql服务，可使用aapanel，或手搓，请自便

#### 2. 安装 Docker
使用以下命令安装 Docker：
```bash
curl -fsSL https://get.docker.com | bash -s docker
```

#### 3. 克隆仓库
克隆 Git 仓库并初始化子模块：
```bash
git clone  -b webman --depth 1  --recurse-submodules https://github.com/LetRight/xb-docker.git && cd xb-docker
```

#### 4. 构建容器容器

```bash
docker build -t xboard .
```

#### 5. 启动容器
使用 Docker Compose 启动服务：
```bash
docker compose up -d
```

#### 6. 进入容器
进入运行中的 Docker 容器：
```bash
docker exec -ti xboard sh
```



#### 7. 初始化 PHP 环境
修改WebMan监听ip
```bash
sed -i 's/127.0.0.1/0.0.0.0/g' /www/webman.php
```
安装 Composer 并初始化 PHP 环境：
```bash
wget https://github.com/composer/composer/releases/latest/download/composer.phar -O composer.phar
php composer.phar install -vvv
php artisan xboard:install
```


该容器环境中没有内置 MySQL 服务，并且需要连接到安装在宿主机上的 MySQL 数据库，请在数据库连接设置中使用地址 172.17.0.1 作为服务器地址。

此外，为了确保容器可以成功连接到宿主机的 MySQL，您需要配置 MySQL 以允许来自 172.%.%.% 网段的连接请求。这涉及到调整 MySQL 的权限设置，以便为 Docker 容器提供适当的访问权限。


#### 8. 重启容器
退出容器并重启所有服务：
```bash
exit 
docker compose restart 
```

#### 9. Nginx 配置反向代理
创建一个新的 Nginx 网站配置，将其反向代理至 `http://127.0.0.1:7010`。


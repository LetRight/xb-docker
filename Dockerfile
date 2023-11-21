FROM phpswoole/swoole:php8.1-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions pcntl

RUN apk --no-cache add shadow supervisor nginx sqlite nginx-mod-http-brotli redis

#复制项目文件以及配置文件
WORKDIR /www
COPY .docker /

CMD [ "/usr/bin/supervisord", "--nodaemon", "-c" ,"/etc/supervisor/supervisord.conf" ]
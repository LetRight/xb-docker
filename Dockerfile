FROM phpswoole/swoole:php8.1-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions pcntl

RUN apk --no-cache add redis git nano shadow supervisor sqlite 

WORKDIR /www
COPY .docker /

CMD [ "/usr/bin/supervisord", "--nodaemon", "-c" ,"/etc/supervisor/supervisord.conf" ]
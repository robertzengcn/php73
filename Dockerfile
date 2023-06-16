FROM php:7.3-fpm

RUN apt-get -y install phpcpd \
php-codesniffer \
phploc \
php-mbstring

# ARG XDEBUG_VERSION="xdebug-2.9.0"
RUN apt-get update -y && apt-get upgrade -y
RUN  apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install  -o -f redis \
    && docker-php-ext-enable redis

RUN docker-php-ext-install pdo pdo_mysql

# RUN yes | pecl install xdebug
# RUN apt-get install php7.3-xdebug
# RUN apt-get install ${XDEBUG_VERSION}

RUN docker-php-ext-install mysqli

# RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.mode=develop,debug,trace" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.profiler_enable=false" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.auto_trace=true" >> /usr/local/etc/php/php.ini \
#     # && echo "xdebug.trace_output_dir = /var/www/html/amilog/" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     # && echo "xdebug.trace_output_name=trace.%t%R" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     # && echo "xdebug.profiler_output_dir = /var/www/html/amilog/" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.max_nesting_level=1500" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.remote_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.trace_output_name=trace.%t" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     # && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini
#     && echo "xdebug.start_with_request=no" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.trace_output_dir=/var/www/html/log" >> /usr/local/etc/php/conf.d/xdebug.ini
    



    # Install PHPUnit
RUN cd /tmp && curl -LO https://phar.phpunit.de/phpunit.phar > phpunit.phar && \
    chmod +x phpunit.phar && \
    mv /tmp/phpunit.phar /usr/local/bin/phpunit

RUN curl --silent --show-error https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer  


RUN apt-get update && \
    apt-get install openssl -y && \
    apt-get install libssl-dev -y && \
    apt-get install git -y && \
    apt-get install procps -y && \
    apt-get install htop -y

# RUN pecl install swoole
# RUN cd /tmp && curl -LO https://pecl.php.net/get/swoole-4.2.9.tgz && \
#     tar zxvf swoole-4.2.9.tgz && \
#     cd swoole-4.2.9  && \
#     phpize  && \
#     ./configure  --enable-openssl && \
#     make && make install

# RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
#     echo 'extension=swoole.so' > /usr/local/etc/php/conf.d/swoole.ini
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends zip

RUN apt-get update && \ 
    apt-get install -y \
    libzip-dev \
    unzip
RUN docker-php-ext-install sockets   
RUN docker-php-ext-install pcntl   
RUN composer self-update --1

RUN echo "upload_max_filesize = 100M" >> /usr/local/etc/php/php.ini

RUN apt-get update && apt-get install -y libpng-dev 
RUN apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir

RUN docker-php-ext-install gd

RUN apt-get install -y libmcrypt-dev
RUN pecl install mcrypt-1.0.4 && docker-php-ext-enable mcrypt
# install xsl
RUN apt install -y libxslt-dev
RUN docker-php-ext-install xsl



RUN apt -y install php7.3-dev php-pear
RUN pecl channel-update pecl.php.net ; pecl clear-cache
RUN pecl install xdebug



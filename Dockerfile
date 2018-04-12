FROM php:7.2-fpm

ENV TZ=Asia/Shanghai

COPY sources.list /etc/apt/sources.list

RUN set -xe \
    && echo "构建依赖" \
    && buildDeps=" \
    build-essential \
    libxml2-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    " \
    && echo "运行依赖" \
    && runtimeDeps=" \
    libfreetype6 \
    libjpeg62-turbo \
    libmcrypt4 \
    libpng12-0 \
    " \
    && echo "安装依赖包" \
    && apt-get update \
    && apt-get install -y \
    libxml2=2.9.1+dfsg1-5+deb8u6 \
    zlib1g=1:1.2.8.dfsg-2+b1 \
    ${runtimeDeps} ${buildDeps} \
    --allow-downgrades \
    --no-install-recommends \
    && echo "编译安装 php 组件" \
    && docker-php-ext-install -j$(nproc) \
    dom \
    hash \
    iconv \
    mysqli \
    pdo \
    pdo_mysql \
    && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && echo "清理" \
    && apt-get purge -y \
    --auto-remove \
    --allow-remove-essential \
    -o APT::AutoRemove::RecommendsImportant=false \
    -o APT::AutoRemove::SuggestsImportant=false \
    $buildDeps \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/cache/apt/* \
    && rm -rf /var/lib/apt/lists/*

COPY ./php.conf /usr/local/etc/php/conf.d/php.conf
COPY ./www /usr/share/nginx/html

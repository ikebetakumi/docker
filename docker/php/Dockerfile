# docker-composeから渡された変数を使用する準備
ARG PHP_VERSION
# イメージを取得
FROM php:${PHP_VERSION}-fpm

ENV TZ Asia/Tokyo

# パッケージやPHPの拡張モジュールをインストールするコマンドを実行

RUN apt-get update && apt-get install -y \
	git \
	curl \
	unzip \
	vim \
	# nodejs npm \
	libzip-dev \
	libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install zip

# 独自のphp.iniファイル(PHPの設定ファイル)を
# コンテナ内の/usr/local/etc/php/ディレクトリにコピー
COPY php.ini /usr/local/etc/php/
# composerをインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 作業ディレクトリの設定
WORKDIR /var/www/html


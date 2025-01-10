# docker-composeから渡された変数を使用する準備
ARG PHP_VERSION
# イメージを取得
FROM php:${PHP_VERSION}-fpm
# 独自のphp.iniファイル(PHPの設定ファイル)を
# コンテナ内の/usr/local/etc/php/ディレクトリにコピー
COPY php.ini /usr/local/etc/php/
# composerの最新バージョンをインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# パッケージやPHPの拡張モジュールをインストールするコマンドを実行
RUN apt-get update && apt-get install -y \
	git \
	curl \
	zip \
	unzip \
	vim \
	&& docker-php-ext-install pdo_mysql

# 作業ディレクトリの設定
WORKDIR /var/www/html

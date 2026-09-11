# README

ローカル開発環境をすぐ立ち上げるための Docker テンプレート。Nginx + PHP-FPM + MySQL + phpMyAdmin。

## ブランチについて

stack ごとにブランチを分けている。使う stack のブランチを checkout してから使うこと。

| ブランチ | 内容 |
| --- | --- |
| `main` | 共通のベース（素の PHP） |
| `php` | `main` と同内容 |
| `laravel` | Laravel 向けに nginx / Dockerfile を調整 |
| `wordpress` | WordPress 向けに mysqli / gd を追加 |

共通のインフラ修正（nginx 設定や compose ファイルなど）は現状 `main` にしか入っていない。他ブランチへの反映は都度手動でマージすること。

## セットアップ

```bash
cp .env.example .env
# 必要ならポート番号やDB名などを .env で調整
docker-compose up -d --build
```

- アプリ: http://localhost:8000 （`NGINX_HOST_HTTP_PORT`）
- phpMyAdmin: http://localhost:8080 （`PHPMYADMIN_PORT`、ユーザー名 `root` / `MYSQL_ROOT_PASSWORD`）

`src/index.php` は起動確認用のサンプル（Hello World 表示 + MySQL 接続テスト + `phpinfo()`）。実際のプロジェクトを置くときは削除して構わない。

## Xdebug

デフォルトは無効（`docker/php/xdebug.ini` で `xdebug.mode=off`）。常時有効だとデバッガに接続できない時に毎リクエストが詰まるため。

使うときは `docker/php/xdebug.ini` の `xdebug.mode=off` を `xdebug.mode=debug,develop` に変更して、

```bash
docker-compose restart app
```

IDE 側は `host.docker.internal:9003`、idekey `VSCODE` で待ち受ける設定にする。使い終わったら `off` に戻すこと。

## Docker コマンド

### sudo service docker start

最初にDocker デーモンを起動します。
たいていの Linux ディストリビューションでは systemctl を使ってサービスを起動します。
systemctl がない場合は service コマンドを使ってください。

:::
https://docs.docker.jp/v1.9/engine/articles/systemd.html
:::


### docker-compose up -d --build

サービス用のコンテナを構築、作成、起動、アタッチします。

:::
https://docs.docker.jp/compose/reference/up.html
:::


### docker-compose down

downはupで作成したコンテナ・ネットワーク・ボリューム・イメージを削除します。


### docker-compose stop

stopは稼働中のコンテナを停止しますが、削除はしません。
**docker-compose start**  コマンドで、再起動できます。


### docker-compose exec #{container} bash

コンテナの中でLINUX操作を行う必要がある場合はBashを起動します。
これでbashを起動する、コンテナに入るということになります。

※コンテナ名（#{container}）はdocker-compose.ymlの内容によって変更して下さい。


### docker-compose exec mysql bash

MySQLコンテナのBashシェルが起動します。
コンテナ内部でコマンドを実行することができます。

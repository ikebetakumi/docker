# README

ローカル開発環境をすぐ立ち上げるための Docker テンプレート。Nginx + PHP-FPM + MySQL + phpMyAdmin。

## 対応スタック

ブランチ分けはしていない（`main` 一本）。使うスタックに応じて `.env` のサンプルファイルを選んでコピーする。

| コピーするファイル | FRAMEWORK | 内容 |
| --- | --- | --- |
| `.env.example` | `php` | 素の PHP |
| `.env.laravel.example` | `laravel` | Laravel 向けに nginx のドキュメントルート / Dockerfile を調整（gd, zip） |
| `.env.wordpress.example` | `wordpress` | WordPress 向けに mysqli / gd を追加 |

`FRAMEWORK` の値によって `docker/php/Dockerfile.${FRAMEWORK}` と `docker/nginx/${FRAMEWORK}/default.conf` が使われる（`docker-compose.yml` 参照）。**プロジェクト開始時に1回決めたら、あとから切り替える想定はない**（切り替える場合は `.env` を編集後に `--build` で再ビルドが必要）。

共通のインフラ修正（`docker-compose.yml` や `php.ini` など）は全スタックで共有しているファイルなので、直せば自動的に全スタックに反映される。

## セットアップ

```bash
# 使うスタックに応じて選ぶ
cp .env.example .env             # 素のPHP
# cp .env.laravel.example .env   # Laravel
# cp .env.wordpress.example .env # WordPress

# 必要ならポート番号やDB名などを .env で調整
docker-compose up -d --build
```

- アプリ: http://localhost:8000 （`NGINX_HOST_HTTP_PORT`）
- phpMyAdmin: http://localhost:8080 （`PHPMYADMIN_PORT`、ユーザー名 `root` / `MYSQL_ROOT_PASSWORD`）

`src/index.php` は起動確認用のサンプル（Hello World 表示 + MySQL 接続テスト + `phpinfo()`）。実際のプロジェクトを置くときは削除して構わない。

nginx / app / mysql すべてに healthcheck を設定しており、`docker compose ps` で `healthy` になっていれば一通り疎通できる状態。

## よく使うコマンド（Makefile）

```bash
make up          # 起動（必要ならビルド）
make down        # 停止・削除（ボリュームは残る）
make fresh       # ボリュームごと作り直す（DBデータが消えるので注意）
make logs        # 全サービスのログを追従
make ps          # 起動状態を確認
make sh          # app コンテナに入る
make mysql       # mysql コンテナに入る
make xdebug-on   # Xdebug を有効化してapp再起動
make xdebug-off  # Xdebug を無効化してapp再起動
```

## Xdebug

デフォルトは無効（`docker/php/xdebug.ini` で `xdebug.mode=off`）。常時有効だとデバッガに接続できない時に毎リクエストが詰まるため。

`docker/php/xdebug.ini` はコンテナに bind mount しているので、値を変更して `docker compose restart app`（または `make xdebug-on` / `make xdebug-off`）するだけで反映される。イメージの再ビルドは不要。

IDE 側は `host.docker.internal:9003`、idekey `VSCODE` で待ち受ける設定にする。使い終わったら `off` に戻すこと。

## composer キャッシュ

`composer install` / `update` のダウンロードキャッシュは名前付きボリューム（`composer_cache`）に永続化される。コンテナを作り直しても毎回フルダウンロードにはならない。完全に空にしたい場合は `docker compose down -v`（`make fresh`）で消える。

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

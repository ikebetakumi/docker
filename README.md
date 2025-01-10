# README

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


## Composer コマンド

### composer install

composer.lockに書かれている各ライブラリをインストールします。
新しい環境ではじめにインストールするときなどに使用します。

### composer update

composer.jsonをもとに各ファイルを最新版にアップデートします。

.PHONY: up down build restart fresh logs ps sh mysql xdebug-on xdebug-off

# コンテナを起動（必要なら初回ビルド）
up:
	docker compose up -d --build

# コンテナを停止・削除（ボリュームは残る）
down:
	docker compose down

# イメージを再ビルドのみ
build:
	docker compose build

# app コンテナを再起動（Xdebug設定変更の反映などに使用）
restart:
	docker compose restart app

# ボリュームごと全部作り直す（DBデータも消えるので注意）
fresh:
	docker compose down -v
	docker compose up -d --build

# 全サービスのログを追従表示
logs:
	docker compose logs -f

# コンテナの起動状態を表示
ps:
	docker compose ps

# app コンテナに入る
sh:
	docker compose exec app bash

# mysql コンテナに入る
mysql:
	docker compose exec mysql bash

# Xdebug を有効化して app を再起動
xdebug-on:
	sed -i 's/^xdebug.mode=.*/xdebug.mode=debug,develop/' docker/php/xdebug.ini
	docker compose restart app

# Xdebug を無効化（デフォルト）に戻して app を再起動
xdebug-off:
	sed -i 's/^xdebug.mode=.*/xdebug.mode=off/' docker/php/xdebug.ini
	docker compose restart app

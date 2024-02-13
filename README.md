# Datagate アップローダーツール 更新サーバー

Datagate アップローダーツールは、更新サーバーとして "Nuts" を使用しています。これは、Datagate アップローダーツールをサポートするために一部修正を加えたオリジナルの Nuts プロジェクトのフォークです。
Nuts は、デスクトップアプリケーションのリリースを提供するアプリケーションです。

#### Datagate 更新サーバー
更新サーバーは、Google Cloud Run でホストされています。サーバーは以下のURLで利用可能です：

https://datagate-autoupdate-server-6iqrwlgqqq-an.a.run.app

#### 特徴
- :sparkles: GitHub リリースにアセットを保存する
- :sparkles: プライベートリポジトリからのリリースをユーザーにプロキシする
- :sparkles: シンプルで強力なダウンロードURL 
  - /download/latest
  - /download/latest/:os
  - /download/:version
  - /download/:version/:os
  - /download/channel/:channel
  - /download/channel/:channel/:os
- :sparkles: プレリリースチャンネルのサポート（beta、alpha、...）
- :sparkles: Squirrel を使用した自動更新
  - Mac 用の /update?version=<x.x.x>&platform=osx を使用します
  - Windows 用に Squirrel.Windows および Nugets パッケージを使用します
- :sparkles: プライベート API
- :sparkles: ミドルウェアとして使用：カスタムアナリティクス、認証の追加
- :sparkles: 完璧なタイプのアセットを提供します：Squirrel.Mac 用の .zip、Squirrel.Windows 用の .nupkg、Mac ユーザー用の .dmg、...
- :sparkles: リリースノートエンドポイント
  - /notes/:version
- :sparkles: 最新のリリース（GitHub webhook）
- :sparkles: バージョン/チャンネル用の Atom/RSS フィード 

### デプロイ / 開始方法
  Docker と Gcloud CLI がインストールされていること、そして GCP（mnes-datagate-prd）の正しいプロジェクトにログインしていることを確認してください。

https://cloud.google.com/sdk/docs/install

```bash
$ make docker/build

$ make docker/push

$ make gcloud/deploy
````

### 自動アップデーター / Squirrel
このサーバーは Squirrel auto-updater のためのエンドポイントを提供しており、OS X と Windows の両方をサポートしています。

ドキュメント
詳細については、[ドキュメント](https://nuts.gitbook.com) をご覧ください。


---
# Datagate Uploader Tool Update Server

Datagate Uploader Tool uses "Nuts" as an update server. This is a fork of the original Nuts project with some modifications to support the Datagate Uploader Tool.
Nuts is an application to serve desktop-application releases.

#### Datagate Update Server

The update server is hosted on Google Cloud Run. The server is available at the following URL:

https://datagate-autoupdate-server-6iqrwlgqqq-an.a.run.app

#### Features

- :sparkles: Store assets on GitHub releases
- :sparkles: Proxy releases from private repositories to your users
- :sparkles: Simple but powerful download urls
    - `/download/latest`
    - `/download/latest/:os`
    - `/download/:version`
    - `/download/:version/:os`
    - `/download/channel/:channel`
    - `/download/channel/:channel/:os`
- :sparkles: Support pre-release channels (`beta`, `alpha`, ...)
- :sparkles: Auto-updates with [Squirrel](https://github.com/Squirrel)
    - For Mac using `/update?version=<x.x.x>&platform=osx`
    - For Windows using Squirrel.Windows and Nugets packages
- :sparkles: Private API
- :sparkles: Use it as a middleware: add custom analytics, authentication
- :sparkles: Serve the perfect type of assets: `.zip` for Squirrel.Mac, `.nupkg` for Squirrel.Windows, `.dmg` for Mac users, ...
- :sparkles: Release notes endpoint
    - `/notes/:version`
- :sparkles: Up-to-date releases (GitHub webhooks)
- :sparkles: Atom/RSS feeds for versions/channels

#### Deploy it / Start it

Make sure that Docker and Gcloud CLI is installed and that you are logged in to the correct project in GCP (mnes-datagate-prd).

https://cloud.google.com/sdk/docs/install

```bash
$ make docker/build

$ make docker/push

$ make gcloud/deploy
```

#### Auto-updater / Squirrel

This server provides an endpoint for [Squirrel auto-updater](https://github.com/atom/electron/blob/master/docs/api/auto-updater.md), it supports both [OS X](https://nuts.gitbook.com/update-osx.html) and [Windows](https://nuts.gitbook.com/update-windows.html).

#### Documentation

[Check out the documentation](https://nuts.gitbook.com) for more details.

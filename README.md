# VSCode Extensions Manager

拡張機能 [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)を使って、VSCodeの拡張機能をJSONとMarkdownファイルで管理します。

拡張機能の追加を検知して、Github Actionsが自動でPRを作成します。

## Requirement
- `code`コマンド (https://code.visualstudio.com/docs/setup/mac)  
- 拡張機能 [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)
- Python 

## Usage

### 自動PR作成の設定手順

#### 1. インストール済みの拡張機能をファイルに書き出し
```
$ ./script/listup.sh
```
`extensions.json` が作成されます。

#### 2. 拡張機能のカテゴリを整理(任意)

`extensions.json` を編集して、拡張機能をカテゴリ毎に整理します。

#### 3. JSONファイルをMarkdownに変換
```
$ python script/convert.py
```
`extensions.md` が作成されます。

#### 4. Settings Syncの設定
作成したGistの extensions.json > Raw をクリックして、JSONが取得できるURLを記録します。

#### 5. GithubActionsの設定

Githubのページから、Settings > Secrets をクリックして、環境変数に`GIST_URL`(4で記録したURLからハッシュ値を取り除いたURL)を設定します。
(https://docs.launchdarkly.com/home/code/github-actions)

※ `https://gist.githubusercontent.com/[ユーザー名]/[Gist ID]/raw/[ハッシュ値]/extensions.json` 
⇨ `https://gist.githubusercontent.com/[ユーザー名]/[Gist ID]/raw/extensions.json` 

### ローカルでの使用

#### 拡張機能の一括インストール

```
$ ./script/bulk_install.sh
```
`extensions.json`に記載された拡張機能を一括でインストールします。

カテゴリを指定して、一部の拡張機能だけをインストールすることも可能です。(ex. `$ ./script/bulk_install.sh git`)

#### 拡張機能の一括アンインストール

```
$ ./script/bulk_uninstall.sh
```

`uninstall_extensions.json`に記載された拡張機能を一括でアンインストールします。

## 環境構築
1. リポジトリをfork
2. `git clone`して`cd rspec_app_exam`で移動
3. ブランチを各課題に応じて作成＆移動（参考：　git checkout -b ブランチ名）
4. docker compose build, docker compose upコマンドを実行
5. specファイルを修正して、テスト実行（docker compose upコマンドを実行しているターミナルとは別ターミナルを開いて docker compose exec web bundle exec rspecコマンドを実行）

## RSpec編 課題

RSpecの[GitHubのREADME](https://github.com/rspec/rspec-rails)を見て、RUNTEQの課題にそって環境構築やテストコードの作成を行いましょう。

## 注意点

この課題はforkしてご自身のリポジトリを作成して作業してください。  
また、PRのマージをfork元のブランチに対して行わないようにご注意ください。  

※このアプリはDockerを使用しているため、コマンドはDockerを使用したもので進めてください。

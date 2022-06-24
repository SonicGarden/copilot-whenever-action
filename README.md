# copilot-whenever-action

このアクションは、AWS Copilot によりデプロイされた Rails アプリケーションに対し、[elastic_whenever](https://github.com/wata727/elastic_whenever) を実行します。

現在、開発中です。

## Inputs

**Required** app:
Name of the application.

**Required** env:
Name of the environment.

**Required** file:
Schedule file, default `config/schedule.rb`.

## Outputs

## 使用例

```yml
uses: SonicGarden/copilot-whenever-action@develop
with:
  app: 'your-app-name'
  env: 'production'
```

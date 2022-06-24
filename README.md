# copilot-whenever-action

このアクションは、AWS Copilot によりデプロイされた Rails アプリケーションに対し、[elastic_whenever](https://github.com/wata727/elastic_whenever) を実行します。

現在、開発中です。

## Inputs

**Required** app-name:
Name of the application.

**Required** environment:
Name of the environment.

**Required** schedule-file:
Schedule file, default `config/schedule.rb`.

## Outputs

## 使用例

```yml
uses: SonicGarden/copilot-whenever-action@develop
with:
  app-name: 'your-app-name'
  environment: 'production'
```

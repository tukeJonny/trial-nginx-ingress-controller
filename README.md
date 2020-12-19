
## Install

```
$ ./scripts/install.sh
...

$ # 表示されたDNSゾーンに `$(yq .metadata.name aks-ingress.yaml)` のプレフィックスを足して、コピーしておく
$ vim aks-ingress.yaml # `$(yq '.spec.rules[].host' aks-ingress.yaml)` に <aks-ingress.yamlの .metadata.name>.<Azureに割り当てられたドメイン> を指定する
$ vim ./scripts/install.sh # apply_http_appl..., apply_appsをコメントアウトして、apply_ingressのコメントを外す
$ ./scripts/install.sh
```

## メモ

* Nginx Ingress Controllerだと `rewrite-target` が効かなかったが、Azureのhttp-application-routingアドオンだと意図通りに動作した (バグか何かなんだろうか)
* 事前にazコマンドを整える必要がある
* Apache, Nginx, Express.jsあたりで動作が確認できた
    * curl http://<ドメイン>/service{1,2,3,4}/path/to/resource で確認

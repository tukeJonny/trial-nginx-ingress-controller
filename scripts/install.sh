#!/usr/bin/env bash

set -euo pipefail


# apply_nginx_ingress_controller() {
#     echo "[*] Installing Nginx Ingress Controller by helm charts ..."
#     helm repo add nginx-stable https://helm.nginx.com/stable
#     helm repo update
#     helm install nginx-ingress-controller-1 nginx-stable/nginx-ingress

#     sleep 1
# }

apply_http_application_routing_addon() {
    # refer: https://docs.microsoft.com/ja-jp/azure/aks/http-application-routing

    # AKSクラスタごと新規作成の場合
    # az aks create --resource-group test-rg --name test-k8s --enable-addons http_application_routing

    # 既存のAKSクラスタを編集する場合
    az aks enable-addons --resource-group test-rg --name test-k8s --addons http_application_routing

    # ドメイン名を取得
    # これの結果をNginxのVirtualHost、 host: <> に指定する
    az aks show --resource-group test-rg --name test-k8s --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName -o table
}

apply_apps() {
    paths=$(find ./charts/app/values/ -mindepth 1 | sort)
    for path in $paths; do
        app=$(basename $path | cut -d. -f1)
        values_dir=$(dirname $path)
        dir=$(dirname $values_dir)
        helm install --values $path $app-1 $dir
    done
}

apply_ingress() {
    kubectl apply -f aks-ingress.yaml
}

#apply_apps
apply_http_application_routing_addon
#apply_ingress


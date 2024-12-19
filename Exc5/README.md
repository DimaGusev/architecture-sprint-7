# Инструкция

## Запустить minikube c calico

```bash
minikube start --cni calico
```

## Запустить сервисы
```bash
./createServices.sh
```

## Применить политики

```bash
kubectl apply -f ./non-admin-api-allow.yaml
```

## Проверка

Ошибка:
```bash
kubectl run test-$RANDOM --rm -i -t --image=alpine -- wget -qO- --timeout=2 http://admin-front-end-app:80
```

Работает:
```bash
kubectl exec -i -t front-end-app -- curl http://back-end-api-app
```

Ошибка:
```bash
kubectl exec -i -t front-end-app -- curl -m 5 http://admin-back-end-api-app
```
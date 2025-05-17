# Diploma Project

Этот репозиторий содержит финальный дипломный проект. В нем собраны все ключевые компоненты, разбитые по подмодулям.

## Структура репозитория

- **[devops-infra](https://github.com/Axel7720/devops-infra)** — содержит инфраструктурную часть проекта: Helm-чарты, Kubernetes-манифесты, CI/CD-конфигурации и другие DevOps-компоненты.
- **[django-chart](https://github.com/Axel7720/django-chart)** — Helm-чарт для деплоя Django-приложения в Kubernetes.
- **[django-pg-docker-tutorial](https://github.com/Axel7720/django-pg-docker-tutorial)** — основной Django-проект, с PostgreSQL, подготовленный для контейнеризации.
- **[monitoring](https://github.com/Axel7720/monitoring)** — система мониторинга, включающая Prometheus, Grafana и Alertmanager. Развёрнута на внешнем сервере (srv) для отслеживания состояния кластера и приложения.

## Описание

- Приложение развернуто в Kubernetes-кластере.
- Мониторинг и логирование настроены через стек Prometheus + Grafana + Alertmanager + Loki/Promtail.
- Все конфигурации и окружение зафиксированы в соответствующих подмодулях.


## Ручные шаги при установке Kubernetes

1. На master-узле:
    - Выключен swap: sudo swapoff -a
    - Проверен и очищен /etc/fstab от swap записей
    - Установлен kubeadm, kubelet, kubectl вручную (через официальный репозиторий)
    - Кластер инициализирован:
      
      sudo kubeadm init --pod-network-cidr=10.244.0.0/16
          - Настроен kubectl для пользователя:
      
      mkdir -p $HOME/.kube
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
      sudo chown $(id -u):$(id -g) $HOME/.kube/config
      
2. Установка CNI (Calico вместо Weave):
    
    curl https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml -O
    kubectl apply -f calico.yaml
    
3. На worker-узле:
    - Установлен Docker, kubelet, kubeadm, kubectl
    - Присоединение к кластеру:
      
      sudo kubeadm join <master-ip>:6443 --token ... --discovery-token-ca-cert-hash ...
      
4. Проверка:
    
    kubectl get nodes
    kubectl get pods -n kube-system -o wide
 
## Автор

**Aleksandr Ushakov**  
Email: sasha_ushi@mail.ru  
GitHub: [Axel7720](https://github.com/Axel7720)


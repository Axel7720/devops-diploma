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
 

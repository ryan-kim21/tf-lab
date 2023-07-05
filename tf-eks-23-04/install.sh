#!/bin/bash
cat ~/.aws/config
cat ~/.aws/credentials


sudo apt update
sudo apt install awscli -y

aws configure set aws_access_key_id [] --profile default
aws configure set aws_secret_access_key [] --profile default
aws configure set region ap-northeast-2 --profile default


curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256) kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
kubectl version --client



source <(kubectl completion bash) # bash-completion 패키지를 먼저 설치한 후, bash의 자동 완성을 현재 셸에 설정한다
echo "source <(kubectl completion bash)" >> ~/.bashrc # 자동 완성을 bash 셸에 영구적으로 추가한다

alias k=kubectl
complete -o default -F __start_kubectl k


curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

aws eks --region ap-northeast-2 update-kubeconfig --name dev-eks-cluster



##################################################################################

aws iam create-role \
  --role-name dev-ryan-eks-role \
  --assume-role-policy-document file://trust-policy.json

policy.json

aws iam create-policy \
  --policy-name dev-ryan-eks-role \
  --policy-document file://policy.json

aws iam attach-role-policy \
  --role-name dev-ryan-eks-role \
  --policy-arn arkn:aws:iam::960524191939:policy/dev-ryan-eks-role

#######################################################################################################
#oidc 생성 

eksctl utils associate-iam-oidc-provider --region=ap-northeast-2 --cluster=dev-eks-cluster --approve

# iam 생성

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \ 
  --policy-document file://alb-iam-policy.json

---> Created role name 

# isrl 생성 

eksctl create iamserviceaccount \
        --cluster=my-cluster \
        --name aws-load-balancer-controller \
        --role-name AmazoneEKSLoadBalancerControllerRole \
        --attach-policy-arn arn:aws:iam::1111111111:policy/Created role name \
        --approve

---> 확인 
kubectl -n kube-system get serviceaccount aws-load-balancer-controller


#eks alb controller install
helm repo add eks https://aws.github.io/eks-charts
helm repo update


CLUSTER_NAME="${your_eks_cluster_name}"
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=${CLUSTER_NAME} \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

kubectl -n kube-system get po



# test nlb 
# kubectl apply nlb.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-nlb-test
spec:
  selector:
    matchLabels:
      app: nginx-nlb-test
  replicas: 1
  template:
    metadata:
      labels:
        app: nginx-nlb-test
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-nlb-test
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: ip #
    service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
    service.beta.kubernetes.io/aws-load-balancer-healthcheck-port: "80"
spec:
  type: LoadBalancer
  loadBalancerClass: service.k8s.aws/nlb #
  selector:
    app: nginx-nlb-test
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP

# test alb

# kubectl apply -f alb.yaml

apiVersion: v1
kind: Pod
metadata:
  name: nginx-alb-test
  labels:
    app: nginx-alb-test
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-alb-test
spec:
  selector:
    app: nginx-alb-test
  ports:
  - name: http
    port: 80
    targetPort: 80
  type: ClusterIP
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-alb-test
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing #
    alb.ingress.kubernetes.io/target-type: ip
spec:
  ingressClassName: alb #
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: nginx-alb-test
            port:
              number: 80


























---------------

eksctl --profile default \
       --region=ap-northeast-2 \
       delete iamserviceaccount \
       --name aws-load-balancer-controller \
       --namespace kube-system \
       --cluster dev-eks-cluster


#aws load balancer controller iam 생성
eksctl --profile default\
   --region=ap-northeast-2 \
  delete iamserviceaccount \
  --name aws-load-balancer-controller \
  --namespace kube-system \
  --cluster dev-eks-cluster 


#rollbing
eksctl --profile default\
       --region=ap-northeast-2 \
        create iamserviceaccount \
        --name aws-load-balancer-controller \
        --namespace kube-system \
        --override-existing-serviceaccounts \
        --approve --cluster dev-eks-cluster \
        --attach-policy-arn \
        arn:aws:iam::960524191939:policy/dev-alb-iam-policy


##### ?

eksctl-dev-eks-cluster-addon-iamserviceacco-Role1-1Q8C86HI7DS1F

aws iam detach-role-policy --role-name eksctl-dev-eks-cluster-addon-iamserviceacco-Role1-1Q8C86HI7DS1F --policy-arn arn:aws:iam::960524191939:policy/dev-alb-iam-policy


## result
2023-06-27 14:50:29 [ℹ]  will create IAM Open ID Connect provider for cluster "dev-eks-cluster" in "ap-northeast-2"
2023-06-27 14:50:29 [✔]  created IAM Open ID Connect provider for cluster "dev-eks-cluster" in "ap-northeast-2"
ubuntu@ip-10-20-1-84:~$ 
ubuntu@ip-10-20-1-84:~$ eksctl --profile default\
>    --region=ap-northeast-2 \
>   delete iamserviceaccount \
>   --name aws-load-balancer-controller \
>   --namespace kube-system \
>   --cluster dev-eks-cluster 

2023-06-27 14:50:35 [ℹ]  1 iamserviceaccount (kube-system/aws-load-balancer-controller) was included (based on the include/exclude rules)
2023-06-27 14:50:35 [ℹ]  1 task: { delete serviceaccount "kube-system/aws-load-balancer-controller" }
2023-06-27 14:50:35 [ℹ]  serviceaccount "kube-system/aws-load-balancer-controller" was already deleted
ubuntu@ip-10-20-1-84:~$ 
ubuntu@ip-10-20-1-84:~$ 
ubuntu@ip-10-20-1-84:~$ #rollbing
ubuntu@ip-10-20-1-84:~$ eksctl --profile default\
>        --region=ap-northeast-2 \
>         create iamserviceaccount \
>         --name aws-load-balancer-controller \
>         --namespace kube-system \
>         --override-existing-serviceaccounts \
>         --approve --cluster dev-eks-cluster \
>         --attach-policy-arn \
>         arn:aws:iam::960524191939:policy/dev-alb-iam-policy
2023-06-27 14:50:36 [ℹ]  1 iamserviceaccount (kube-system/aws-load-balancer-controller) was included (based on the include/exclude rules)
2023-06-27 14:50:36 [!]  metadata of serviceaccounts that exist in Kubernetes will be updated, as --override-existing-serviceaccounts was set
2023-06-27 14:50:36 [ℹ]  1 task: { 
    2 sequential sub-tasks: { 
        create IAM role for serviceaccount "kube-system/aws-load-balancer-controller",
        create serviceaccount "kube-system/aws-load-balancer-controller",
    } }2023-06-27 14:50:36 [ℹ]  building iamserviceaccount stack "eksctl-dev-eks-cluster-addon-iamserviceaccount-kube-system-aws-load-balancer-controller"
2023-06-27 14:50:37 [ℹ]  deploying stack "eksctl-dev-eks-cluster-addon-iamserviceaccount-kube-system-aws-load-balancer-controller"
2023-06-27 14:50:37 [ℹ]  waiting for CloudFormation stack "eksctl-dev-eks-cluster-addon-iamserviceaccount-kube-system-aws-load-balancer-controller"
2023-06-27 14:51:07 [ℹ]  waiting for CloudFormation stack "eksctl-dev-eks-cluster-addon-iamserviceaccount-kube-system-aws-load-balancer-controller"
2023-06-27 14:51:53 [ℹ]  waiting for CloudFormation stack "eksctl-dev-eks-cluster-addon-iamserviceaccount-kube-system-aws-load-balancer-controller"
2023-06-27 14:51:53 [ℹ]  created serviceaccount "kube-system/aws-load-balancer-controller


aws eks update-cluster-config \
    --region ap-northeast-2 \
    --name dev-eks-cluster \
    --resources-vpc-config endpointPublicAccess=true,publicAccessCidrs="203.0.113.5/32",endpointPrivateAccess=true



curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh --version v3.8.2


helm repo add aws https://aws.github.io/eks-charts
helm install my-aws-load-balancer-controller aws/aws-load-balancer-controller --version 1.5.4 --set clusterName=dev-eks-cluster

helm pull aws/aws-load-balancer-controller --version 1.5.4


#####
helm repo add eks https://aws.github.io/eks-charts
helm repo update


helm install aws-load-balancer-controller eks/aws-load-balancer-controller --version 1.5.4 \
  --set clusterName=dev-eks-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  -n kube-system


###
# kube-system 네임스페이스로 전환
kubectl create namespace kube-system
kubectl config set-context --current --namespace=kube-system

# Helm 레포지토리 업데이트
helm repo update

# AWS Load Balancer Controller Helm 차트 설치
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  --set clusterName=dev-eks-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  -n kube-system

#cert-manager설치  
# cert-manager 네임스페이스로 전환
kubectl create namespace cert-manager
kubectl config set-context --current --namespace=cert-manager

# cert-manager Helm 차트 저장소 추가
helm repo add jetstack https://charts.jetstack.io

# Helm 레포지토리 업데이트
helm repo update

# cert-manager Helm 차트 설치
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version <cert-manager-version> \
  --set installCRDs=true



# alb 테스트 

# 테스트용 네임스페이스 생성
kubectl create namespace test

# Nginx 웹 서버 배포
kubectl create deployment nginx --image=nginx --namespace test

# Nginx 웹 서버를 위한 Service 생성
kubectl expose deployment nginx --port=80 --target-port=80 --type=ClusterIP --namespace test

# Ingress 리소스 생성
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  namespace: test
spec:
  rules:
    - host: example.com  # 테스트할 도메인 주소로 대체
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: nginx
                port:
                  number: 80
EOF

# 확인 
kubectl get ingress -n test


alb logs 확인
kubectl logs -n kube-system -l app.kubernetes.io/name=aws-load-balancer-controller


kubectl get serviceaccount aws-load-balancer-controller -n kube-system -o yaml


helm repo add eks https://aws.github.io/eks-charts

helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
  --set clusterName=dev-eks-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"="arn:aws:iam::960524191939:role/eksctl-dev-eks-cluster-addon-iamserviceaccou-Role1-114294HM3H7X8" \
  --namespace kube-system

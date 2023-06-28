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
  --policy-arn arn:aws:iam::960524191939:policy/dev-ryan-eks-role

#######################################################################################################

eksctl utils associate-iam-oidc-provider --region=ap-northeast-2 --cluster=dev-eks-cluster --approve

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


curl -L https://git.io/get_helm.sh | bash -s -- --version v3.8.2

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 ##< 이거 안됨

chmod 700 get_helm.sh
./get_helm.sh

helm repo add aws https://aws.github.io/eks-charts

helm install my-aws-load-balancer-controller aws/aws-load-balancer-controller --version 1.5.4 --set clusterName=dev-eks-cluster
helm pull aws/aws-load-balancer-controller --version 1.5.4




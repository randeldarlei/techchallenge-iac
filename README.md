# 💡 Introdução

## Objetivo ##
Este repositório contém uma estrutura de arquivos `hcl` para o provisionamento de infraestrutura na AWS. Esta arquitetura é composta por EKS, VPC e Security Groups organizados em módulos distintos para facilitar a manutenção e escalabilidade.

## 📦 Estrutura ##

- *eks:* Provisionamento do cluster EKS.
- *network:* Criação da VPC, subnets, tabelas de rotas e security groups.

### Pré-requisitos

- *AWS CLI:* Configurado com um perfil para autenticação.
- *Terraform:* Certifique-se de que a versão instalada seja compatível com os provedores declarados (~> 4.0).

### Configuração Inicial

- *Configurar o AWS CLI:* Execute ´aws configure´ e configure o perfil de autenticação com as credenciais apropriadas para provisionar a infraestrutura na região ´us-east-1´ juntamente com uma *access_key* e uma *secret_key*.
- *Configurar o backend do Terraform:* Cada pasta (´eks´ e ´network´) possui um backend remoto cujo state é salvo em um Workspace do Terraform Cloud, por isso é necessário em execuções locais executar o [Terraform Login](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-login#start-the-login-flow).

## Como Provisionar Recursos ##

### Configurar a Rede

Acesse e execute os seguintes comandos na pasta `network:`

```bash
terraform init
terraform apply

```

Isso irá inicializar todo o backend do Terraform e criar a VPC, subnets privadas e públicas, tabelas de rotas e um security group que serão compartilhados entre os módulos


### Provisionar o Cluster EKS

Acesse e execute os seguintes comandos na pasta `eks:`

```bash
terraform init
terraform apply

```

Isso criará o cluster EKS, associando-o às subnets privadas definidas.

Acesse e execute os seguintes comandos na pasta `rds:`

```bash
terraform init
terraform apply

```

## Licença
Este projeto é licenciado sob os termos da MIT License.


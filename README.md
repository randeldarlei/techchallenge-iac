# 💡 Introdução

## Objetivo ##
Este repositório contém uma estrutura de arquivos `hcl` para o provisionamento de infraestrutura na AWS. Esta arquitetura é composta por EKS, VPC, subnets e um banco de dados RDS, organizados em módulos distintos para facilitar a manutenção e escalabilidade.

## 📦 Estrutura ##

terraform/ ├── eks/ │ ├── cluster.tf │ ├── data.tf │ ├── ian.tf │ └── provider.tf ├── network/ │ ├── output.tf │ ├── provider.tf │ ├── sg.tf │ └── vpc.tf ├── rds/ │ ├── data.tf │ ├── provider.tf │ └── rds.tf 

- *eks:* Provisionamento do cluster EKS.
- *network:* Criação da VPC, subnets, tabelas de rotas e security groups.
- *rds:* Configuração do banco de dados RDS.

### Pré-requisitos

- *AWS CLI:* Configurado com um perfil para autenticação.
- *Terraform:* Certifique-se de que a versão instalada seja compatível com os provedores declarados (~> 4.0).

### Configuração Inicial

- *Configurar o AWS CLI:* Execute ´aws configure´ e configure o perfil de autenticação com as credenciais apropriadas para provisionar a infraestrutura na região ´us-east-1´.
- *Configurar o backend do Terraform:* Cada pasta (´eks´, ´network´, ´rds´) possui um backend local para armazenamento dos arquivos de estado (´tfstate´). Ajuste os caminhos conforme necessário para seu ambiente.

## Como Provisionar Recursos ##

### Configurar a Rede

Acesse e execute os seguintes comandos na pasta `network:`

```bash
terraform init
terraform apply

```

Isso irá inicializar todo o backend do Terraform e criar a VPC, subnets privadas e públicas, tabelas de rotas e um security group que serão utilizado tanto para o RDS como para o EKS.

Agora as informações relacionadas á VPC e Security Group foram criadas com sucesso e estão acessíveis no `state` salvo na pasta *network*. Estes arquivos são consumidos pelos módulos de `eks`e `rds`através do *data.tf* declarados em cada um deles.

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


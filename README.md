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

### Como as Actons Funcionam?
- Para executar o Apply ou Destroy em sua infraestrutura basta selcionar o workspace `Terraform Apply/Destroy`em seguida clique em `run workflow`. Selecione ação *(apply ou destroy)*, por último escolha o módulo desejado.
- As Actions utilizam um backend remoto da Hascorp para guardar o arquivo do State, para isso caso seja necessário gerenciar a infraestrutura por uma outra conta de AWS é necessário alterar dentro do Workflow criado no Terraform Cloud as vériaveis de ambiente *(AWS_ACCESS_KEY_ID e AWS_SECRET_ACCESS_KEY)* além do `HASHICORP_TOKEN` que será gerado em sua respectiva conta.

- Para que tudo integrar este backend com o terraform preciso declar esta estrutura no arquivo `providers.tf`:

```hcl
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "sua-org"

    workspaces {
      name = "seu-workspace"
    }
  }
}
```
- hostname = Sempre vai ser `app.terraform.io`
- organization = Aqui declaramos a organizarion em que estão inseridos os workspaces, caso necessário troque este valor para o sua organization criada posteriormente.
- workspaces = Aqui declaramos o nome do workspace, caso necessário troque este valor para o seu workspace criado posteriormente.


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

## Licença
Este projeto é licenciado sob os termos da MIT License.


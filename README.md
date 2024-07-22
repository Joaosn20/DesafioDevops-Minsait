🚀 Deploy de WordPress na Azure com Terraform e Docker

Descrição do Desafio:

Você deve criar um script Terraform que realiza o seguinte:

1. Sobe uma máquina virtual (VM) na Azure.
2. Configura a VM para instalar Docker.
3. Sobe um container com o WordPress instalado na VM.

Instruções

1. Crie um repositório público no GitHub e adicione o código criado.
2. Inclua um README.md com instruções detalhadas sobre como executar o código.
3. Preencha o formulário do Google fornecendo o link para o repositório GitHub (sem compartilhar informações pessoais, o repositório precisa estar marcado como publico).

Requisitos de conclusão:

    Terraform: O script Terraform deve criar uma máquina virtual na Azure.
    Instalação do Docker: Utilize um script de inicialização para instalar o Docker na VM.
    Container com WordPress: Após a instalação do Docker, suba um container com o WordPress.
    Automatização Completa: Todo o processo deve ser automatizado com Terraform. 
    Não deve ser necessário conectar-se manualmente à máquina para instalação e configuração.

Pontos Extras

    Containers Separados: Configure containers separados para o WordPress e o banco de dados, garantindo 
    a retenção de dados durante um upgrade do WordPress.
    Comentários no Código: Adicione comentários explicativos no código Terraform para indicar o que cada bloco faz.
    Arquivo docker-compose.yml: Forneça um arquivo docker-compose.yml para facilitar a criação dos containers.
    Senha do Banco de Dados: Configure a senha do usuário root do banco de dados para GAud4mZby8F3SD6P.
    Dockerfile para o Servidor Web: Forneça um arquivo Dockerfile para o servidor web, mesmo que use uma 
    imagem pública com as dependências instaladas.

Este repositório contém um projeto desenvolvido utilizando Terraform, Docker e React. A seguir, você encontrará um guia passo a passo interativo para provisionar o projeto.
Pré-requisitos

Antes de começar, verifique se você possui os seguintes requisitos:

✅ Terraform 
✅ AzureCLI
✅ Conta na Azure

Passo 1️⃣: Clonar o repositório

Comece clonando este repositório para sua máquina local. Para clonar o repositório, clique no botão "Clone" acima ou execute o seguinte comando no terminal:
```
git clone https://github.com/Joaosn20/DesafioDevops-Minsait.git
```
Isso criará uma cópia local do repositório em seu ambiente.

Passo 2️⃣: Se autenticar utilizando o AzureCLI

Navegue até o diretório raiz do projeto e execute o comando:
```
az login
```
Vai ser aberto uma aba de login no portal da azure. Faça o login para continuar o passo-a-passo.

Passo 3️⃣: Inicialização do terraform.

Após a autenticação execute o comando:
```
terraform init 
```
Isso deverá inicializar os arquivos
```
terraform plan
```
Nesse comando, o Terraform irá ler todo o arquivo de recursos (main.tf) e criará um plano de execução.
```
terraform apply
```
Esse é o comando responsável por aplicar realmente o plano de execução gerado no passo anterior, ou seja, ele vai acessar sua conta no provedor de nuvem e provisionará todos os recursos que foi definido.

Após o passo de inicialização feito, aguarde o provisionamento e a inicialização dos containers.

Passo 4️⃣: Conectar-se a virtual machine utilizando o IP público.

Para encontrar o seu IP público utilize o comando:
```
az vm list-ip-addresses --resource-group rg-desafio-devops --name vm-desafio-devops --output table
```
Após ter encontrado o seu IP público vamos fazer a conexão na VirtualMachine através do comando:
```
ssh admdevops@<ip_publico>
```
ao pedir a password deverá ser utilizado: "Senh4!"

Passo 5️⃣: Destruição 

Após realizar os testes caso deseja destruir os arquivos provisionados utilize o comando:
```
terraform destroy
```
🎉 Espero que este guia passo a passo tenha sido útil para você abrir e explorar o projeto.

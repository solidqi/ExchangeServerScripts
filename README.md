## Tabela de Conteúdo

* [Sobre o projeto](#sobre-o-projeto)
  * [Desenvolvimento](#desenvolvimento)
* [Início](#inicio)
  * [Pré-Requisitos](#prerequisitos)
  * [Instalação](#instalacao)
  * [Configuração](#Configuração)
* [Uso](#uso)
* [Scripts](#scripts)
* [Licença](#licenca)
* [Contato](#contato)

## Sobre o Projeto
Este projeto, visa manter uma repositório de scripts voltado para o Exchange Server. Os scripts, desenvolvidos em PowerShell, visam facilitar o gerenciamento e a administração de uma organização no Exchange Server On-Premises.

### Desenvolvimento
O desenvolvimento dos scripts são em Powershell e visam atender demandas para o Exchange Online, Exchange Server 2010 e versões superiores.

## Início
Os scripts encontram-se na pasta Scripts, subpastas ou arquivos diretamente publicados. Ainda assim, cada script possui um nome intuitivo e dentro do seu arquivo encontra-se uma sessão explicativa que pode ser lida diretamente ou no Powershell poderá ser obtida através do comando:
```
Get-Help -Name .\Connect-Exchange.ps1
```
### Pré-Requisitos
Para a execução dos scripts em Powershell, são necessários os pré-requisitos abaixo:

* [Windows Management Framework 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616);
* Powershell versão 5.1 ou superior;
* Exchange Management Tools;

### Instalação
Os scripts publicados possuem a extensão .PS1 e não precisam ser instalados.

### Configuração
Não são necessárias configurações adicionais, visto que cada script é assinado digitalmente pela "SolidQI - Negócios e Soluções em TI."
    ```
## Uso
O uso dos scripts, dependerá do script a ser executado e sua finalidade com que ele foi desenvolvido.

## Scripts
* **Connect-Exchange.ps1** ....: Script de conexão para o Exchange Server (On-Premises).
* **Connect-ExOnline.ps1** ....: Script de conexão para o Exchange Online.
* **Add-Ex.SMTPAddress.ps1** ..: Script para inclusão do SMTP Address "@<organizacao>.onmicrosoft.com"
* **Remove-Ex.SMTPAddress.ps1** ..: Script para remoção do SMTP Address com sufixo "solidqi.net.br"

## Licença
Não definido.

## Contato
Celso Ricardo Gubitoso - celso.gubitoso@solidqi.com.br - M: +55 47 99210 4400

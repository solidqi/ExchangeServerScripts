<#
.SYNOPSIS
Conecta remotamente via Powershell em servidores Exchange Server

.DESCRIPTION
O script em questão conecta nos servidores Exchange Server utilizando o Powershell remoto. É preciso informar o nome do fqdn do servidor e o usuário com permissões administrativas para acessar o Exchange Server.

.EXAMPLE

.\Connect-Exchange.ps1

.NOTES
Script: Connect-Exchange.ps1
Autor.: Celso Ricardo Gubitoso
E-mail: celso.gubitoso@solidqi.com.br
Date..: 15/12/2019

.LINK
Conectar-se a servidores do Exchange usando o PowerShell remoto
https://docs.microsoft.com/pt-br/powershell/exchange/exchange-server/connect-to-exchange-servers-using-remote-powershell?view=exchange-ps

Read-Host
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-6

Get-Help
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-help?view=powershell-7
#>

#Carrega o usuário com permissões administrativas para o Exchange Server
$UserCredential = Get-Credential

#Lê e armazena o FQDN do servidor Exchange Server
$ExchangeServer = Read-Host "Informe o FQDN do Servidor Exchange Server: "
#Cria uma nova sessão Powershell para acessar o Exchange Server
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$ExchangeServer/PowerShell/ -Authentication Kerberos -Credential $UserCredential

#Importa a sessão Powershell da variável $Session
Import-PSSession $Session -DisableNameChecking

#Sai da sessão Powershell previamente importada
Exit-PSSession -$Session
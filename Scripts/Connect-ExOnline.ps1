<#
.SYNOPSIS
Conecta remotamente via Powershell no Exchange Online.

.DESCRIPTION
O script em quest�o conecta no Exchange Online utilizando o Powershell remoto. � preciso que o usu�rio utilizado seja Global Administrator ou Exchange Admin.

.EXAMPLE

.\Connect-ExOnline.ps1

.NOTES
Script: Connect-ExOnline.ps1 v1.0
Autor.: Celso Ricardo Gubitoso
E-mail: celso.gubitoso@solidqi.com.br
Date..: 11/06/2020

.LINK
Connect to Exchange Online PowerShell
-------------------------------------
https://docs.microsoft.com/en-us/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps


Conectar-se a servidores do Exchange usando o PowerShell remoto
---------------------------------------------------------------
https://docs.microsoft.com/pt-br/powershell/exchange/exchange-server/connect-to-exchange-servers-using-remote-powershell?view=exchange-ps


Read-Host
---------
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-6


Get-Help
--------
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-help?view=powershell-7
#>

#Carrega o usu�rio com permiss�es administrativas para o Exchange Online
$UserCredential = Get-Credential

#Cria uma nova sess�o Powershell para acessar o Exchange Online
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

#Importa a sess�o Powershell da vari�vel $Session
Import-PSSession $Session -DisableNameChecking

#Remove a sess�o Powershell previamente importada
#Get-PSSession | Remove-PSSession $Session
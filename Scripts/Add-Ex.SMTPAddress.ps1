<#
.SYNOPSIS
Adiciona o sufixo "@<organization>.onmicrosoft.com" no atributo EmailAddresses de cada Mailbox.


.DESCRIPTION
Este script tem a finalidade de listar todos os Mailbox (On-Premises) que não possuem o SMTP Addresses do Exchange Online ("@<Organization>.onmicrosoft.com").
Uma vez que os mailbox forem listados, será identificado o SMTP Address padrão (por exemplo: SMTP:admin.celso@solidqi.com.br") e adicionado o novo SMTP Address
para o Exchange Online.

.EXAMPLE


.NOTES
Script: Add-Ex.SMTPAddress.ps1 v1.0
Autor.: Celso Ricardo Gubitoso
E-mail: celso.gubitoso@solidqi.com.br
Date..: 11/06/2020

.LINK
Conectar-se a servidores do Exchange usando o PowerShell remoto
---------------------------------------------------------------
https://docs.microsoft.com/pt-br/powershell/exchange/exchange-server/connect-to-exchange-servers-using-remote-powershell?view=exchange-ps


Get-Mailbox
-----------
https://docs.microsoft.com/pt-br/powershell/module/exchange/mailboxes/get-mailbox?view=exchange-ps


Split
-----
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_split?view=powershell-7


Set-Mailbox
-----------
https://docs.microsoft.com/pt-br/powershell/module/exchange/mailboxes/set-mailbox?view=exchange-ps


Get-Help
--------
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-help?view=powershell-7
#>

#Exibe no ecrã as informações abaixo
Write-Host Add-Ex.SMTPAddress.ps1 v1.0 - Adiciona SMTP Address
Write-Host SolidQI - Negócios e Soluções em TI
Write-Host `n

#Lê e armazena o FQDN do servidor Exchange Server
$ExchangeServer = Read-Host "Informe o FQDN do Servidor Exchange Server"

#Carrega o usuário com permissões administrativas para o Exchange Server
$UserCredential = Get-Credential

#Cria uma nova sessão Powershell para acessar o Exchange Server
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$ExchangeServer/PowerShell/ -Authentication Basic -Credential $UserCredential

#Importa a sessão Powershell da variável $Session
Import-PSSession $Session -DisableNameChecking

#Lista todos os mailbox que não contêm o sufixo "@onmicrosoft.com"
$Mailboxes = Get-Mailbox | where {($_.Emailaddresses -notmatch "@solidqi.onmicrosoft.com") -and ($_.RecipientTypeDetails -eq "UserMailbox")} | Select  Alias,Emailaddresses

#Processa cada mailbox individualmente
foreach ($Mailbox in $Mailboxes){

	#Divide o valor do atributo "EmailAddresses" do mailbox corrente separado por vírgula
	$SMTPAddresses = $Mailbox.EmailAddresses  -Split ", "

	#Processa cada SMTP Addresses do atributo "EmailAddresses"
	foreach ($SMTPAddress in $SMTPAddresses){

		#Verifica qual endereço possui o "SMTP" padrão
		if ($SMTPAddress -cmatch '[A-Z]'){
		
			#Extrai o endereço de mail antes da "@". Por exemplo: se o endereço for "admin.celso@solidqi.com.br". O resultado será "admin.celso".
			$SMTPOnMicrosoft = $SMTPAddress.Substring(5).Split("@")[0]

			try{

				#Imprime no monitor a saída do comando em Powershell
				Write-Host Set-Mailbox $Mailboxes.Alias -EmailAddresses "@{Add=$SMTPOnMicrosoft@solidqi.onmicrosoft.com}"
			}
			catch {

				$ErrorMessage = $_.Exception.Message
				Write-Warning $ErrorMessage
			}
		}
	}
}
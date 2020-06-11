## Tabela de Conteúdo

* [Sobre o projeto](#sobre-o-projeto)
  * [Desenvolvimento](#desenvolvimento)
* [Início](#inicio)
  * [Pré-Requisitos](#prerequisitos)
  * [Instalação](#instalacao)
  * [Configuração](#Configuração)
* [Uso](#uso)
* [Licença](#licenca)
* [Contato](#contato)

## Sobre o Projeto
O projeto da aplicação AD.Data.Import se deu na necessidade de clientes integrarem aplicações e dados do setor Recursos Humanos para o Active Directory Domain Services (AD DS).

### Desenvolvimento
Por se tratar de uma quantidade razoável de dados que serão lidos a partir de um arquivo .CSV e repetidos inúmeras vezes ao longo do dia. A aplicação precisaria atender no mínimo a confiabilidade e rapidez no processamento dos dados.
Nessas condições básicas, para o desenvolvimento da aplicação foi escolhido a linguagem C#, .Net Framework 4.6.1 e os pacotes: CsvHelper, Mailkit e Serilog.

* [C#](https://docs.microsoft.com/pt-br/dotnet/csharp/) - Linguagem de programação desenvolvida pela Microsoft como parte da plataforma .Net.
* [.Net Framework](https://docs.microsoft.com/pt-br/dotnet/) - É o framework para de desenvolvimento e execução de sistemas e aplicações.
* [CsvHelper](https://joshclose.github.io/CsvHelper/) - Uma biblioteca .Net para ler e escrever arquivos .CSV.
* [Mailkit](https://github.com/jstedfast/MailKit) - Uma biblioteca .Net para IMAP, POP3 e SMTP.
* [Serilog](https://serilog.net/) - Várias bibliotecas .Net para a criação e registro de logs para diagnóstico.

## Início
Das regras de negócio em si, a aplicação AD.Data.Import deverá atender um conjunto de condições específicas para o seu desenvolviento. Segue abaixo:

* Ler um arquivo de dados no formato .CSV com nome estático e possuir os seguintes cabeçalhos: 
```sh
COMPANY; SAMACCOUNTNAME; ENABLED; EMPLOYEEID; GIVENNAME; SN; DISPLAYNAME; DEPARTMENT; TITLE; TELEPHONENUMBER
```
* O arquivo de dados no formato .CSV deverá estar delimitado pelo caracter ";";
* Registrar as alterações e erros no log de Eventos do Windows Server nominado **AD Data Import**;
* Quando forem registrados erros durante a execução do AD.Data.Import, os erros deverão ser registrados no log de Eventos do Windows nominado **AD Data Import** e enviado via e-mail para o endereço **chamados@dohler.com.br**;

### Pré-Requisitos
Para a execução da aplicação AD.Data.Import, são necessários os pré-requisitos abaixo:

* Servidor com Windows Server 2012 R2 ou superior;
* .Net Framework 4.6.1 ou superior;
* Path do arquivo .CSV;
* No do domínio utilizado no Active Directory Domain Services (AD DS);
* Path do domínio ou contêiner (OU) que deverão ser pesquisados as contas de usuário;
* Usuário do Active Directory Domain Services (AD DS) com permissão para alterar os atributos das contas de usuário;
* Senha do usuário do Active Directory Domain Services (AD DS);
* Endereço de email para envio de e-mail;
* Endereço do MTA (Mail Transport Agent) para envio de e-mail utilizando o protocolo SMTP;
* Porta de envio do protocolo SMTP;
* Usuário para autenticação durante o processo de envio de e-mail;
* Senha do usuário autenticado para envio de e-mail;
* Informar se haverá o uso de Certificado SSL (true ou false).

### Instalação
Para a instalação da aplicação AD.Data.Import foi desenvolvido uma instalador e armazenado na pasta [Installer](https://github.com/solidqi/addataimport/tree/master/Installer). Entretanto, a aplicação AD.Data.Import pode ser descompactada em qualquer pasta e o arquivo .Zip pode ser encontrado [aqui](https://github.com/solidqi/addataimport/tree/master/Installer).

### Configuração
Para a configuração e funcionamento da aplicação AD.Data.Import são necessários os passos abaixo:

1. Incluir o grupo NETWORK SERVICE na chave de registro abaixo com permissão READ;
```
Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Security
```
2. Executar o instalador da pasta [Installer](https://github.com/solidqi/addataimport/tree/master/Installer) ou descompactar o arquivo .ZIP em qualquer pasta desejada. Caso seja optado o pelo instalador automatizado, a aplicação AD.Data.Import será executada rapidamente uma única vez;

3. Após a execução do instalador ou descompactação do arquivo .ZIP, é necessário editar o arquivo AD.Data.Import.config e preencher as informações abaixo:

   * No campo ***csvFile*** deve ser informado o path do arquivo .CSV que será carregado pela aplicação.
   ```XML
   <add key="csvFile" value="C:\Users\CelsoGubitoso\Documents\Temp\integracao.csv"/>
   ```
   * No campo ***ldaptDomain*** informe o fqdn do domínio do AD DS.
   ```XML
   <add key="ldapDomain" value="nofingers.net" />
   ```
   * No campo ***ldapPath*** informe o valor de pesquisa no AD DS.
   ```XML
   <add key="ldapPath" value="LDAP://DC=nofingers,DC=net" />
   ```
   * No campo ***ldapUsername*** informe a conta do usuário que realizará as pesquisas no AD DS.
   ```XML
   <add key="ldapUsername" value="Administrator" />
   ```
   * No campo ***ldapPassword*** informa a senha da conta do usuário que realizará as pesquisas no AD DS.
   ```XML
   <add key="ldapPassword" value="Pa$$w0rd" />
   ```
   * O conjunto de configurações abaixo, trata-se das configurações de e-mail que são: remetente, SMTP Server, Porta de envio, usuário e senha para autenticação durante o envio e se o uso do SSL está ativo.
   Sendo assim, os campos que devem ser preenchidos são: ***from***, ***host***, ***port***, ***userName***, ***password*** e ***enableSsl***.
   ```XML
   <mailSettings>
      <smtp deliveryMethod="Network" from="operacao@intrdohler.com.br">
        <network host="vmzimbra.dohler.com.br" port="587" userName="operacao@intrdohler.com.br" password="formiga" enableSsl="false" />
      </smtp>
    </mailSettings>
    ```
## Uso
A aplicãção AD.Data.Import poderá ser executada manualmente ou utilizar o agendador de tarefas para sua execução em períodos de tempo pré-definidos.
Uma vez que a aplicação for executada, irão acontecer os seguinte passos:

1. Será definido o tipo o tipo de log da aplicação (Log Mínimo para Debug) no arquivo **ADDataImport.log**;

2. É verificado a existência do Log de Eventos **AD Data Import** com a fonte **ADDataImport**;

   2.1 Serão definidos os valores abaixo no registro do Windows:
      ```
   HKLM\SYSTEM\CurrentControlSet\Services\EventLog\AD Data Import\AutoBackupLogFiles = 0
   HKLM\SYSTEM\CurrentControlSet\Services\EventLog\AD Data Import\MaxSize = 102400
   HKLM\SYSTEM\CurrentControlSet\Services\EventLog\AD Data Import\Retention = 0
      ```
   Cada chave tem a sua respectiva definição:

   * **AutoBackupLogFiles**, está com o valor "0" e não realizará o auto backup do log de eventos;
   * **MaxSize**, o valor em Kilobytes(KB) define o tamanho do log de eventos para 100MB;
   * **Retention**, não haverá retenção do log de eventos.

3. Registra o no log de eventos nominado **AD Data Import** o evento: 
```
Information, Event ID 1, Source: ADDataImport: A aplicação AD.Data.Import.exe foi executada com sucesso.
```
4. Lê o arquivo .CSV informado na chave ***csvFile*** do arquivo AD.Data.Import.config;

5. Para cada registro lido no arquivo .CSV, ocorrem as seguintes ações:

   5.1 Pesquisa o valor do atributo **sAMAccountName** no Active Directory Domain Services. Caso o valor do atributo sAMAccountName for encontrado, os seguintes atributos do AD DS receberão os novos valores lidos do arquivo .CSV e é gravado a alteração no AD DS.
   ```c
   user.Properties["company"].Value        = $"{person.COMPANY}";
   user.Properties["enabled"].Value        = $"{person.ENABLED}";
   user.Properties["employeeID"].Value     = $"{person.EMPLOYEEID}";
   user.Properties["description"].Value    = $"{person.EMPLOYEEID}";
   user.Properties["department"].Value     = $"{person.DEPARTMENT}";
   user.Properties["title"].Value          = $"{person.TITLE}";
   user.CommitChanges();
   ```
   Registra no log de eventos nominado **AD Data Import** o evento:
   ```
   Information, Event ID 2, Source: ADDataImport: O login sandro.dalri foi alterado com sucesso.
   ```
   5.2 Caso o valor do atributo **sAMAccountName** não seja encontrado no Active Directory Domain Services, é registrado no log de eventos **AD Data Import** o evento:
   ```
   Warning, Event ID 1, Source: ADDataImport: O login/username: sandro.dalri não foi localizado no Active Directory Domain Services.
   ```
   Por fim, envia o e-mail para chamados@dohler.com.br com o assunto "AD Data Import - Usuário não encontrado" e a mensagem: "O username sandro.dalri não foi encontrado no Active Directory Domain Services.".
   
## Licença
Não definido.

## Contato
Celso Ricardo Gubitoso - celso@gubitoso.com - M: +55 47 99210 4400.

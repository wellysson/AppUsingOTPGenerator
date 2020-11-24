# Bem Vindo

Este guia dem por objetivo facilitar o entendimento do projeto gerador de senhas OTP.

Indice:

[[_TOC_]]

# Sobre

O projeto se trata de uma biblioteca responsável por gerar chaves OTP e realizar suas validações no servidor da Raro.

# Utilização

A utilização deve ser feita atravéz de “pod instal” e todos os pods dependentes serão incluidos automaticamente.
Como por exemplo a linha abaixo:

`pod 'OTPGenerator', git: 'https://git.rarolabs.com.br/bmg/otp-generator-ios.git'`

# Passo a passo

1)	É necessário instanciar um objeto do tipo OTPGenerator.

As propriedades que fazem parte da instância devem ser únicas, por usuário e aparelho.
Com exceção da chave pública e chave privada.

2) Após instancia da classe, executar método startActivation()

Esse método é responsável, por iniciar integração/autenticação com o servidor e armazenar localmente a chave de acesso para geração dos otp
Caso a integração já tenha sido efetuada e a chave de integração já esteja armazenada localmente. nenhuma chamada no servidor é realizada.

3) Após inicialização, pode-se utilizar os seguintes métodos:
    
    a.	getCurrentKey()
    Retorna o código otp corrente.
    
    b.	getTimeToEndValidate()
    Retorna o tempo, em segundos, até a expiração do código atual.
    
    c.	Validation()
    Retorna se o código atual é válido no servidor.





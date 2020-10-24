#language: pt
Funcionalidade: Eu como usuario, preciso criar uma conta no site para realizar uma compra

@cadastro
Esquema do Cenario: Cadastrar-se no site
 Dado que eu acesse o link
 E preencho o novo "<email>"
 E preencho as informacoes pessoais
 E preencho o endereco
 Entao finalizo o cadastro

 Exemplos: Inserir na tabela abaixo o e-mail a ser cadastrado. Caso deixa em branco será aleatório
  | email |
  |       |
 
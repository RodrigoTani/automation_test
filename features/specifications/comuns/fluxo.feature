#language: pt

@teste_completo
Funcionalidade: fluxo

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
 
@comprar
Cenario: Realizar uma compra
 Dado que eu esteja logado no sistema
 Quando acesso o menu "Dresses", submenu "Evening Dresses"
 E escolho o vestido
 E adiciono um vestido da cor "Pink", tamanho "M"
 E adiciono um vestido da cor "Beige", tamanho "S"
 E valido o carrinho
 E valido o endereco
 E aceito os termos do servico
 E utilizo a forma de pagamento "Check"
 Entao finalizo a compra
 E valido os vestidos em "Historicos de Pedidos"

@avaliar
Cenario: Avaliar os ultimos pedidos
 Dado que eu esteja logado no sistema
 E estou na tela de Historicos
 E avalio os ultimos vestidos comprados

#language: pt

Funcionalidade: Eu como usuario logado, desejo realizar uma compra de dois vestidos na loja

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
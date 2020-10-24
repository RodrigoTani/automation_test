Dado('que eu esteja logado no sistema') do
    visit("http://automationpractice.com/")

    find(".login").click
    assert_selector("#email_create", wait: 30)

    if $email.blank?
        $email = "Beatrice.Lindgren@orbia.ag"
    end
    if $senha.blank?
        $senha = "cJ1Ht"
    end
    find("#email").set($email)
    find("#passwd").set($senha)
    find("#SubmitLogin").click
    assert_selector(".navigation_page", wait: 30)
end

Quando('acesso o menu {string}, submenu {string}') do |menu, submenu|
    click_link menu 
    first(:link, submenu).click 
end

Dado('escolho o vestido') do
    assert_selector(".category-name", wait: 30)
    all(:link,'Printed Dress')[1].click
    assert_selector("#product_reference", wait: 30)  
    @lista_vestidos = []
end

Quando('adiciono um vestido da cor {string}, tamanho {string}') do |cor, tamanho|   
    @comprar = ComprarPages.new    
    vestido = @comprar.add_vestido(cor, tamanho)
    @lista_vestidos << vestido
end

Dado('valido o carrinho') do
    $dados["ListaVestidos"] = @lista_vestidos
    click_link 'cart'
    assert_selector("#cart_title", wait: 30) 

    for qtd_vestidos in 0...$dados["ListaVestidos"].count
        dados = $dados["ListaVestidos"][qtd_vestidos].split("/")

        within all("tbody")[0].all("tr")[qtd_vestidos] do
        #Valida cor
            raise "Cor inconsistente" if !all(".cart_description")[0].text.include?(dados[0])
        #Valida Tamanho
            raise "Tamanho inconsistente" if !all(".cart_description")[0].text.include?(dados[1])
        #valida Preco
            raise "Preco inconsistente" if !all('.price')[0].text.include?(dados[2])
        end
    end

    click_link_or_button 'Proceed to checkout'
end

Dado('valido o endereco') do
    assert_selector(".page-heading", wait: 30) 

    click_link_or_button 'Proceed to checkout'
end

Quando('aceito os termos do servico') do
    assert_selector(".page-heading", wait: 30) 

    find("#uniform-cgv").click
    click_link_or_button 'Proceed to checkout'
end

Quando('utilizo a forma de pagamento {string}') do |formapagamento|
    assert_selector(".page-heading", wait: 30) 

    if formapagamento == "Check"
        find('.cheque').click
    elsif formapagamento == "Bank"
        find('.bankwire').click
    else
        raise "Não existe esta forma de pagamento!"
    end
    $dados.merge!("FormaPagamento" => formapagamento)
end

Entao('finalizo a compra') do
    assert_selector(".page-heading", wait: 30) 
    click_link_or_button 'I confirm my order'
end

Entao('valido os vestidos em {string}') do |string|
    click_link_or_button 'Back to orders'
    assert_selector(".page-heading", wait: 30) 

    preco_total = all('.price')[0].text
    metodo_pagamento = find('.history_method').text

    raise "Forma de pagamento incosistente" if !metodo_pagamento.include?($dados["FormaPagamento"].downcase)

    click_link 'Details'
end
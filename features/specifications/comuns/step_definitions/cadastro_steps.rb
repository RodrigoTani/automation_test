Dado('que eu acesse o link') do
    visit("http://automationpractice.com/")

    find(".login").click
end

Dado('preencho o novo {string}') do |email|
    assert_selector("#email_create", wait: 120)
    
    if email.blank?
        email = "#{Faker::Name.first_name}.#{Faker::Name.last_name}@orbia.ag"
    end
    $email = email

    find("#email_create").set($email)
    find("#SubmitCreate").click

    if page.has_css?("#create_account_error")
        raise "Usuario ja cadastrado! Favor escolher outro e-mail\n"
    end
end

Dado('preencho as informacoes pessoais') do
    assert_selector("#customer_firstname", wait: 120)

    find("#uniform-id_gender1").click
    find("#customer_firstname").set("Rodrigo")
    find("#customer_lastname").set("Tani")
    
    $senha = CadastroPages.new.generate_code(5)
    find("#passwd").set($senha)

    find("#uniform-days").all('option', text:2)[0].click
    find("#uniform-months").select("August").click
    find("#uniform-years").select("1997").click

    all("label[for='optin']")[0].click
end

Dado('preencho o endereco') do
    find("#firstname").set("Rodrigo")
    find("#lastname").set("Tani")
    find("#company").set("ORBIA")
    find("#address1").set("Avenida das Nações Unidas")
    find("#city").set("São Paulo")

    find("#uniform-id_state").select('Alabama').click
    find("#postcode").set("00000")
    find("#phone_mobile").set("11963925158")
    
    find("#alias").native.clear
    find("#alias").set("12901 North Tower - 3o floor")
end

Entao('finalizo o cadastro') do
    find("#submitAccount").click

    assert_selector(".navigation_page", wait: 120)

    if all("span[class='navigation_page']")[0].text != "My account"
        raise "Não está na pagina do My account"
    end
end
Dado('estou na tela de Historicos') do
    click_link 'Order history and details'
    assert_selector("#center_column", wait: 30) 
    first(:link, "Reorder").click 
end

Dado('avalio os ultimos vestidos comprados') do
    assert_selector("#cart_title", wait: 30)

    all(:link, 'Printed Dress')[0].click
    assert_selector("#product_reference", wait: 30)  

    #Avaliar
    all(".open-comment-form")[0].click
    assert_selector(".page-subheading", wait: 30)     
    all("a[title='5']")[0].click
    find("#comment_title").set("Perfeito")
    find("#content").set("Vestido lindo e confortavel")
    find("#submitNewMessage").click

    #Msg Adm Aprovacao
    assert_selector(".fancybox-inner", wait: 30)  
    click_link_or_button('OK', wait:5)

    click_link 'cart'
    assert_selector("#cart_title", wait: 30) 
end

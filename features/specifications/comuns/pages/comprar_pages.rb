class ComprarPages
    include Capybara::DSL

    def add_vestido(cor, tamanho)
        case cor 
        when "Pink"
            find("#color_24").click
        when "Beige"
            find("#color_7").click
        end
        preco = find("#our_price_display").text
        
        vestido = ""
        vestido = "#{cor}/#{tamanho}/#{preco}"

        find("#uniform-group_1").find('option', exact_text: tamanho).click
        find("#add_to_cart").click
        all("span[class='continue btn btn-default button exclusive-medium']")[0].click
        return vestido
    end
end
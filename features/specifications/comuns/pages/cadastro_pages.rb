class CadastroPages
    include Capybara::DSL

    def generate_code(number)
        charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
        Array.new(number) { charset.sample }.join
    end
end
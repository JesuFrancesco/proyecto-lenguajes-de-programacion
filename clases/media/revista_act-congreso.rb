require_relative "revista.rb"

class ActaCongreso < Revista
    def initialize(titulo, area, autor, year, stock)
        super(titulo, area, autor, year, stock)
    end

    # def exp_json()
    # {
    #     titulo: @titulo,
    #     area: @area,
    #     autor: @autor,
    #     yearPublicacion: @yearPublicacion,
    #     stock: @stock
    # }
    # end

    def self.leer_json(dicc)
        l = ActaCongreso.new(dicc["titulo"], dicc["area"], dicc["autor"], dicc["yearPublicacion"], dicc["stock"])
        return l
    end
end

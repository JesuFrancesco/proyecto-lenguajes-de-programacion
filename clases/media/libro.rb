require_relative "material.rb"

class Libro < Material
  def initialize(titulo, area, autor, paginas, year, stock)
    super(titulo, area, autor, year, stock)
    @paginas = paginas
  end

  # def exp_json()
  #   {
  #     titulo: @titulo,
  #     area: @area,
  #     autor: @autor,
  #     paginas: @paginas,
  #     yearPublicacion: @yearPublicacion,
  #     stock: @stock
  #   }
  # end

  def self.leer_json(dicc)
    l = Libro.new(dicc["titulo"], dicc["area"], dicc["autor"], dicc["paginas"], dicc["yearPublicacion"], dicc["stock"])
    return l
  end

end

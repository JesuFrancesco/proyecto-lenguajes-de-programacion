require_relative "material.rb"

class Libro < Material
  def initialize(titulo, area, autor, paginas)
    super(titulo, area, autor)
    @paginas = paginas
  end

  def exp_json()
    {
      titulo: @titulo,
      area: @area,
      autor: @autor,
      paginas: @paginas
    }
  end

  def self.leer_json(diccionario)
    l = Libro.new(diccionario["titulo"], diccionario["area"], diccionario["autor"], diccionario["paginas"])

    return l
  end

end

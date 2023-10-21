require_relative "material.rb"

class Libro < Material
  def initialize(titulo, area, autor, paginas)
    super(titulo, area, autor)
    @paginas = paginas
  end

end

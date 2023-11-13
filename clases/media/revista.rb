require_relative "material.rb"

class Revista < Material
  def initialize(titulo, area, autor, year, stock)
    super(titulo, area, autor, year, stock)
  end
end

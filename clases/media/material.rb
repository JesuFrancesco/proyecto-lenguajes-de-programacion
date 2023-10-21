class Material
  attr_accessor :titulo, :area, :autor

  def initialize(titulo, area, autor)
    if self.class == Material then # Terminar si es Material
      raise Exception, "#{self.class} es clase abstracta y solo debe instanciarse en subclases"
    end
    @titulo = titulo
    @area = area
    @autor = autor
  end

end

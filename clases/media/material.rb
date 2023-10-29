class Material
  attr_accessor :titulo, :area, :autor, :yearPublicacion

  def initialize(titulo, area, autor, yearPublicacion)
    if self.class == Material then # Terminar si es Material
      raise Exception, "#{self.class} es clase abstracta y solo debe instanciarse en subclases"
    end
    @titulo = titulo
    @area = area
    @autor = autor
    @yearPublicacion = yearPublicacion
  end

end

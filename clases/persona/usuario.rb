class Usuario
  attr_accessor :nombre, :maxLibro, :maxTiempo
  private :nombre
  
  def initialize
    raise Exception, "#{self.class} es abstracto y solo debe instanciarse en subclases"
  end
end

class Usuario
  attr_accessor :maxLibro, :maxTiempo
  def initialize()
    raise Exception, "#{self.class} es abstracto y solo debe instanciarse en subclases"
  end
end

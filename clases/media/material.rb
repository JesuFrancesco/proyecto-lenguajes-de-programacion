class Material
  attr_accessor :titulo, :area, :autor
  def initialize()
    raise Exception, "#{self.class} es clase abstracta."
  end

  def datos(titulo, area, autor)
    @titulo = titulo
    @area = area
    @autor = autor
  end
end

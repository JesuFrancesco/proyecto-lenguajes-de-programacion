class Usuario
  attr_accessor :apellidoPaterno, :apellidoMaterno, :nombre, :adeudaLib, :librosAdeudados, :cntLibAdeudados, :tieneLibSeparado, :libReservados, :ctnLibReservados
  attr_reader :maxLibro, :maxTiempo
  
  def initialize
    raise Exception, "#{self.class} es abstracto y solo debe instanciarse en subclases"
  end
end

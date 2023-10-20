class Usuario
  attr_accessor :apellidoPaterno, :apellidoMaterno, :nombre, :maxLibro, :maxTiempo, :adeudaLib, :librosAdeudados, :cntLibAdeudados, :tieneLibSeparado, :libReservados, :ctnLibReservados
  
  def initialize
    raise Exception, "#{self.class} es abstracto y solo debe instanciarse en subclases"
  end
end

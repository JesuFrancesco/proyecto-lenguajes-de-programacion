class Usuario
  attr_accessor :apellidoPaterno, :apellidoMaterno, :nombre, :adeudaLib, :librosAdeudados, :tieneLibSeparado, :libReservados, :tiempo
  attr_reader :maxLibro, :maxTiempo

  def initialize(apellidoPaterno, apellidoMaterno, nombre)
    if self.class == Usuario then
      raise Exception, "#{self.class} es abstracto y solo debe instanciarse en subclases"
    end
    @apellidoPaterno = apellidoPaterno
    @apellidoMaterno = apellidoMaterno
    @nombre = nombre
    # Datos de biblioteca
    @adeudaLib = false
    @librosAdeudados = []
    @tieneLibSeparado = false
    @libReservados = []
  end

end

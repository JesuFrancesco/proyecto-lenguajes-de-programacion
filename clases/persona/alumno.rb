require_relative "usuario.rb"

class Alumno < Usuario
  @@maxLibro = 5
  @@maxTiempo = 7
  attr_accessor :codAlumno

  def initialize(codAlumno, apellidoPaterno, apellidoMaterno, nombre)
    @codAlumno = codAlumno
    super(apellidoPaterno, apellidoMaterno, nombre)
  end

end

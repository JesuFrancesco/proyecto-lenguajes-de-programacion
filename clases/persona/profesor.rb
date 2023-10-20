require_relative "usuario.rb"

class Profesor < Usuario
  attr_accessor :codProfesor

  def initialize(codProfesor, apellidoPaterno, apellidoMaterno, nombre)
    @codProfesor = codProfesor
    @apellidoPaterno = apellidoPaterno
    @apellidoMaterno = apellidoMaterno
    @nombre = nombre
    @maxLibro = 8
    @maxTiempo = 3*7
  end
end

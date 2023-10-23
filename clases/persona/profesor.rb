require_relative "usuario.rb"

class Profesor < Usuario
  @@maxLibro = 8
  @@maxTiempo = 3*7
  attr_accessor :codProfesor

  def initialize(codProfesor, apellidoPaterno, apellidoMaterno, nombre)
    @codProfesor = codProfesor
    super(apellidoPaterno, apellidoMaterno, nombre)
  end

  def exp_json()
    {
      codProfesor: @codProfesor,
      apellidoPaterno: @apellidoPaterno,
      apellidoMaterno: @apellidoMaterno,
      nombre: @nombre
    }
  end

  def self.leer_json(diccionario)
    return Profesor.new(diccionario["codProfesor"], diccionario["apellidoPaterno"], diccionario["apellidoMaterno"], diccionario["nombre"])
  end

end

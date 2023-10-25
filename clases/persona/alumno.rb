require_relative "usuario.rb"

class Alumno < Usuario
  @@maxLibro = 5
  @@maxTiempo = 7
  attr_accessor :codAlumno

  def initialize(codAlumno, apellidoPaterno, apellidoMaterno, nombre)
    # Datos personales
    @codAlumno = codAlumno
    super(apellidoPaterno, apellidoMaterno, nombre)
  end

  # Metodo expresión en JSON
  def exp_json()
    {
      codAlumno: @codAlumno,
      apellidoPaterno: @apellidoPaterno,
      apellidoMaterno: @apellidoMaterno,
      nombre: @nombre,
      # Adeuda
      adeudaLib: @adeudaLib,
      librosAdeudados: @librosAdeudados,
      # Reserva
      tieneLibSeparado: @tieneLibSeparado,
      libReservados: @libReservados
    }
  end

  # Método "parse" de JSON a clase Alumno
  # Self. marca que es static
  def self.leer_json(diccionario)
    a = Alumno.new(diccionario["codAlumno"], diccionario["apellidoPaterno"], diccionario["apellidoMaterno"], diccionario["nombre"])
    a.adeudaLib = diccionario["adeudaLib"]
    a.librosAdeudados = diccionario["librosAdeudados"]
    a.tieneLibSeparado = diccionario["tieneLibSeparado"]
    a.libReservados = diccionario["libReservados"]
    return a
  end

end

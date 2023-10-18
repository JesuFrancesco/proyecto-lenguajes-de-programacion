require_relative "usuario.rb"

class Alumno < Usuario
  def initialize
    @maxLibro = 5
    @maxTiempo = 7
  end
end

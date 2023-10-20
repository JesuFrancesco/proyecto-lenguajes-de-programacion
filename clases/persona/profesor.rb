require_relative "usuario.rb"

class Profesor < Usuario
  def initialize()
    @maxLibro = 8
    @maxTiempo = 3*7
  end
end

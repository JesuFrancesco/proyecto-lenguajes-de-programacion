Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

# TEST
x = Alumno.new()
y = Profesor.new()
# z = Usuario.new() <= Agarra excepcion
puts x.maxLibro
puts y.maxTiempo

# w1 = Material.new() <= Agarra excepcion
w = Libro.new()
w.datos("el","pepe","potasio")
puts w.titulo

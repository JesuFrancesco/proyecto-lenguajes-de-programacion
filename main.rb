if __FILE__ != $0 then exit end

Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

def printObj(objeto)
    if objeto.is_a?(Material) then
    "- Libro #{objeto.titulo} del autor #{objeto.autor} perteneciente al area #{objeto.area}"
    elsif objeto.is_a?(Alumno)
    "- Alumno #{objeto.apellidoPaterno} #{objeto.apellidoMaterno}, #{objeto.nombre} de codigo #{objeto.codAlumno}"
    elsif objeto.is_a?(Profesor)
    "- Profesor #{objeto.apellidoPaterno} #{objeto.apellidoMaterno}, #{objeto.nombre} de codigo #{objeto.codProfesor}"
    end
end


require 'multi_json'

# Modelo USUARIO
puts "***************************************"
puts "**********               **************"
puts "*********  biblioteca ul  *************"
puts "**********               **************"
puts "***************************************"

# TEST LIBROS
libros = [
    Libro.new("el","pepe","123", 60),
    Libro.new("potaxio","wwwww","234", 70),
    Libro.new("wowoaowoawo","ttt","345", 80),
    Libro.new("el","pepe","123", 30)
]
# w = Libro.new()
# w1 = Material.new("d", "e", "f") # <= Agarra excepcion
# libros << w

# TEST ALUMNOS
alumnos = [
    Alumno.new(1, "a", "b", "c"),
    Alumno.new(2, "d", "e", "f"),
    Alumno.new(3, "g", "h", "i")
]
al_json = MultiJson.dump(alumnos)

profesores = [
    Profesor.new(10, "a", "b", "c")
]
# z = Usuario.new(0, "d", "d") # <= Agarra excepcion

# Flujo terminal
while true do
    puts "1. Ver libros"
    puts "2. Ver usuarios"
    puts "3. Salir"
    opcion = gets.to_i
    # Salir
    if opcion == 3 then
        break
    else
        # Opcion 1 y 2
        case opcion
        when 1
            for i in libros do
                puts printObj(i)
            end
        when 2
            for i in alumnos do
                puts printObj(i)
            end
            for j in profesores do
                puts printObj(j)
            end
        else
            puts "Opción inválida."
        end
    end
end

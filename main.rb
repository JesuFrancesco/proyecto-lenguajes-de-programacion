if __FILE__ != $0 then exit end

Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

# Modelo USUARIO

puts "***************************************"
puts "**********               **************"
puts "*********  biblioteca ul  *************"
puts "**********               **************"
puts "***************************************"

# TEST LIBROS
libros = []
w = Libro.new()
w.datos("el","pepe","123")
# w1 = Material.new() <= Agarra excepcion
libros << w

# TEST ALUMNOS
alumnos = []
x = Alumno.new(1, "a", "b", "c")
x1 = Alumno.new(2, "d", "e", "f")
x2 = Alumno.new(3, "g", "h", "i")
alumnos << x
alumnos << x1
alumnos << x2

profesores = []
y = Profesor.new(10, "a", "b", "c")
# z = Usuario.new() <= Agarra excepcion
profesores << y

def printLibro(libro)
    "- Libro #{libro.titulo} del autor #{libro.autor} perteneciente al area #{libro.area}"
end

def printAlumno(alumno)
    "- Alumno #{alumno.apellidoPaterno} #{alumno.apellidoMaterno}, #{alumno.nombre} de codigo #{alumno.codAlumno}"
end

def printProfesor(profesor)
    "- Profesor #{profesor.apellidoPaterno} #{profesor.apellidoMaterno}, #{profesor.nombre} de codigo #{profesor.codProfesor}"
end

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
                puts printLibro(i)
            end
        when 2
            for i in alumnos do
                puts printAlumno(i)
            end
            for j in profesores do
                puts printProfesor(j)
            end
        else
            puts "Opción inválida."
        end
    end
end


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

def guardarJSON_Array(objeto, ruta)
    array = []
    for objeto in objeto
      array << objeto.exp_json()
    end
    x = JSON.generate(array)
    File.open("#{ruta}", "w") { | archivo | archivo.write(x) }
end

def leerJSON_Array(objeto, ruta)
    array = []
    cadena_json = File.read(ruta)
    data = JSON.parse(cadena_json)
    # TODO
    return array
end

# Librerías
require 'json'

# Modelo USUARIO
puts "***************************************"
puts "**********               **************"
puts "*********  biblioteca ul  *************"
puts "**********               **************"
puts "***************************************"

# TEST TDA
libros = [
    Libro.new("Luna de Pluton","Terror","Ángel David Revilla Lenoci", 60),
    Libro.new("Sueños de acero y neón","Ciberpunk","Jordi Wild", 70),
    Libro.new("El libro troll","Troll","Rubius", 2),
]

alumnos = [
    Alumno.new(1, "A", "B", "Juana"),
    Alumno.new(2, "C", "D", "Maria"),
    Alumno.new(3, "E", "F", "Roberto")
]

profesores = [
    Profesor.new(10, "A", "B", "Luis")
]

# TEST CLASE ABSTRACTA
# w1 = Material.new("d", "e", "f") # <= Agarra excepcion
# z = Usuario.new(0, "d", "d") # <= Agarra excepcion

# Flujo terminal
while true do
    # Opciones
    puts "1. Ver libros"
    puts "2. Ver usuarios"
    puts "3. Salir"
    print "-> "
    opcion = gets.to_i
    # Salir
    if opcion == 3 then
        break
    else
        # Opcion 1 y 2
        case opcion
        when 1
            guardarJSON_Array(libros, "data_material/libros.json")
            # Otros TDA's (TODO)

        when 2
            guardarJSON_Array(alumnos, "data_usuario/alumnos.json")
            guardarJSON_Array(profesores, "data_usuario/profesores.json")
        else
            puts "Opción inválida."
        end
    end
end

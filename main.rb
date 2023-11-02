if __FILE__ != $0 then exit end

Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

def printObj(objeto)
    if objeto.is_a?(Libro) then
    "- Libro #{objeto.titulo} del autor #{objeto.autor} perteneciente al area #{objeto.area}" + "\n\t-> Stock #{objeto.stock}"
    elsif objeto.is_a?(Alumno)
    "- Alumno #{objeto.apellidoPaterno} #{objeto.apellidoMaterno}, #{objeto.nombre} de codigo #{objeto.codAlumno}"
    elsif objeto.is_a?(Profesor)
    "- Profesor #{objeto.apellidoPaterno} #{objeto.apellidoMaterno}, #{objeto.nombre} de codigo #{objeto.codProfesor}"
    end
end

# def guardarJSON_Array(objeto, ruta)
#     array = []
#     for objeto in objeto
#       array << objeto.exp_json()
#     end
#     x = JSON.generate(array)
#     File.open("#{ruta}", "w") { | archivo | archivo.write(x) }
# end

def leerJSON_Array(clase, ruta)
    array = []
    cadena_json = File.read(ruta)
    data = JSON.parse(cadena_json)
    # Lectura de json a objeto de ruby & almacenamiento en array
    for i in data do
        array << clase.leer_json(i)
    end
    return array
end

# Librerías
require 'json'

alumnos = [
    Alumno.new(1, "A", "B", "Juana"),
    Alumno.new(2, "C", "D", "Maria"),
    Alumno.new(3, "E", "F", "Roberto")
]

profesores = [
    Profesor.new(10, "A", "B", "Luis")
]

module ACCION
    ORDENAMIENTO = 1
    BUSQUEDA = 2
    FILTRO = 3
end

# TEST CLASE ABSTRACTA
# w1 = Material.new("d", "e", "f") # <= Agarra excepcion
# z = Usuario.new(0, "d", "d") # <= Agarra excepcion

# Flujo terminal
while true do
    system "cls"
    # Modelo USUARIO
    system "color A0"
    puts "***************************************"
    puts "**********               **************"
    puts "*********  biblioteca ul  *************"
    puts "**********               **************"
    puts "***************************************"
    system "color 0A"

    # Opciones
    puts "1. Ver libros"
    puts "2. Ver usuarios"
    puts "3. Salir"
    print "-> "
    opcion = gets.to_i
    system "cls"
    # Salir
    if opcion == 3 then
        puts "Hasta pronto"
        break

    # Opciones 1 y 2 (Libros y Usuarios)
    else
        case opcion
        when 1
            # guardarJSON_Array(libros, "data_material/libros.json")
            # Otros TDA's (TODO)

            # Lectura de json a array de libros
            l = leerJSON_Array(Libro, "data_material/libros.json")
            for i in l do
                puts printObj(i)
            end
            system "pause"

            # Preguntar por acción a realizar
            puts "\n* Defina acción a realizar:"
            puts "1. Ordenamiento"
            puts "2. Búsqueda"
            puts "3. Filtro"
            puts "4. Salir"
            print "-> "
            opAccion = gets.to_i
            while opAccion < 1 || opAccion > 4 do
                puts "Opción inválida"
                print "-> "
                opAccion = gets.to_i
            end
            if opAccion == 4 then next end # Para salir
            system "cls"

            # Ordenamiento C
            case opAccion
            when ACCION::ORDENAMIENTO
                puts "Ingrese método de ordenamiento"
                puts "1. Año de publicacion"
                puts "2. Numero de paginas"
                puts "3. Salir"
                print "-> "
                opOrd = gets.to_i
                while opOrd < 1 || opOrd > 3 do
                    puts "Opción inválida"
                    print "-> "
                    opOrd = gets.to_i
                end
                if opAccion == 3 then next end # Para salir
                system "cls"
                # Ordenamiento en base a atributo
                case opOrd
                when 1
                    #TODO
                when 2
                    #TODO
                else
                    puts "Opción inválida."
                end

            # Búsqueda C
            when ACCION::BUSQUEDA
                puts "Ingrese método de búsqueda"
                puts "1. Autor"
                puts "2. Titulo"
                puts "3. Salir"
                print "-> "
                opBusq = gets.to_i
                while opBusq < 1 || opBusq > 3 do
                    puts "Opción inválida"
                    print "-> "
                    opBusq = gets.to_i
                end
                if opBusq == 3 then next end # Para salir
                system "cls"
                # Ordenamiento en base a atributo
                case opBusq
                when 1
                    puts "Ingrese autor a buscar"
                    autor = gets.chomp # para quitar el /n del final
                    cmd = `modulos_c\\cprog.exe #{1} "#{autor}"`
                    system "cls"
                    puts(cmd) # Realiza la función en el programa compilado de C mediante un cmd interno (?)
                when 2
                    puts "Ingrese titulo a buscar"
                    autor = gets.chomp # para quitar el /n del final
                    cmd = `modulos_c\\cprog.exe #{2} "#{autor}"`
                    system "cls"
                    puts(cmd) # Realiza la función en el programa compilado de C mediante un cmd interno (?)
                else
                    puts "Opción inválida."
                end
                system "pause"

            # Filtros con Haskell
            when ACCION::FILTRO
                #TODO FILTRO
            else
                puts 'pos no se'
            end


        when 2
            # Prueba para guardar el array a json
            # guardarJSON_Array(alumnos, "data_usuario/alumnos.json")
            # guardarJSON_Array(profesores, "data_usuario/profesores.json")

            puts "Elija tipo de usuarios"
            puts "1. Alumnos"
            puts "2. Profesores"
            puts "3. Salir"
            print "-> "
            opUsu = gets.to_i
            while opUsu < 1 || opUsu > 3 do
                puts "Opción inválida"
                print "-> "
                opUsu = gets.to_i
            end
            if opUsu == 3 then next end

            if (opUsu == 1) then
                # Lectura de json a array de alumnos
                a = leerJSON_Array(Alumno, "data_usuario/alumnos.json")
                for i in a do
                    puts printObj(i)
                end

            elsif (opUsu == 2)
                # Lectura de json a array de profesores
                p = leerJSON_Array(Profesor, "data_usuario/profesores.json")
                for i in p do
                    puts printObj(i)
                end
            end
            system "pause"

        else
            puts "Opción inválida."
            system "pause"
        end
    end
end

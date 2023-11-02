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

    def getOp(inf, sup)
      op = gets.to_i
      while op < inf || op > sup do
        puts "Opcion invalida"
        print "-> "
        op = gets.to_i
      end
      return op
    end

    # Librerías
    require 'json'

    module ACCION
        BUSQUEDA = 1
        ORDENAMIENTO = 2
        FILTRO = 3
    end

    # Flujo terminal
    while true do
        system "cls"
        # Modelo USUARIO
        system "color a"
        puts "***************************************"
        puts "**********               **************"
        puts "*********  biblioteca ul  *************"
        puts "**********               **************"
        puts "***************************************"
        system "color a"

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
                # Lectura de json a array de libros
                l = leerJSON_Array(Libro, "data_material/libros.json")
                for i in l do
                    puts printObj(i)
                end
                system "pause"

                # Preguntar por acción a realizar
                puts "\n* Defina acción a realizar:"
                puts "1. Búsqueda"
                puts "2. Préstamo"
                puts "3. Salir"
                print "-> "
                opAccion = getOp(1,3)
                if opAccion == 3 then next end # Para salir
                system "cls"

                case opAccion
                # Búsqueda C
                when ACCION::BUSQUEDA
                    puts "Ingrese método de búsqueda"
                    puts "1. Autor"
                    puts "2. Titulo"
                    puts "3. Area"
                    puts "4. Disponibilidad"
                    puts "5. Material ya reservado"
                    puts "6. Usuarios deudores"
                    puts "7. Salir"
                    print "-> "
                    opBusq = getOp(1,7)
                    if opBusq == 7 then next end # Para salir
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
                    when 3
                        puts "Ingrese el área a buscar"
                        area = gets.chomp
                        cmd = `modulos_c\\cprog.exe #{3} "#{area}"`
                        system "cls"
                        puts(cmd)
                    when 4
                        puts "Libros disponibles"
                        stock = "si me quitas no funciono"
                        cmd = `modulos_c\\cprog.exe #{4} "#{stock}"` #Devuelve todos los libros con stock diferente de 0
                        system "cls"
                        puts(cmd)
                    when 5
                        puts "Libros ya reservados"
                        system "cls"
                    when 6
                        puts "Usuarios deudores"
                        system "cls"
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
                puts "Elija tipo de usuarios"
                puts "1. Alumnos"
                puts "2. Profesores"
                puts "3. Salir"
                print "-> "
                opUsu = getOp(1,3)
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

if __FILE__ != $0 then exit end

    Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
    Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

    def printObj(objeto)
        if objeto.is_a?(Material) then
            tipo = objeto.class
            tipo == ActaCongreso ? tipo="Acta de Congreso": tipo=objeto.class
            return "- #{tipo} #{objeto.titulo} del autor #{objeto.autor} perteneciente al area #{objeto.area}" + "\n\t-> Stock #{objeto.stock}"

        else
            tipo = objeto.class
            if(tipo == Alumno)
                return "- #{tipo} #{objeto.apellidoPaterno} #{objeto.apellidoMaterno}, #{objeto.nombre} de codigo #{objeto.codAlumno}"
            else
                return "- #{tipo} #{objeto.apellidoPaterno} #{objeto.apellidoMaterno}, #{objeto.nombre} de codigo #{objeto.codProfesor}"
            end

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

    def leerJSON_Array(ruta, clases)
        array = []
        cadena_json = File.read(ruta)
        data = JSON.parse(cadena_json)
        # Lectura de json a objeto de ruby & almacenamiento en array
        for i in data do
            clase = i["clase"]
            if !clases.include? clase then next end
            case clase
            when CLASE::ALUMNO
                array << Alumno.leer_json(i)
            when CLASE::PROFESOR
                array << Profesor.leer_json(i)
            when CLASE::LIBRO
                array << Libro.leer_json(i)
            when CLASE::JOURNAL
                array << Journal.leer_json(i)
            when CLASE::ACTA_CONGRESO
                array << ActaCongreso.leer_json(i)
            else
                puts "wtf tu no existes"
            end
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

    module CLASE
      ALUMNO = 'Alumno'
      PROFESOR = 'Profesor'
      LIBRO = 'Libro'
      JOURNAL = 'Journal'
      ACTA_CONGRESO = 'ActaCongreso'
    end

    # Flujo terminal
    while true do
        system "cls"
        # Modelo USUARIO
        system "color 0a"
        puts "***************************************"
        puts "**********               **************"
        puts "*********  biblioteca ul  *************"
        puts "**********               **************"
        puts "***************************************"
        system "color a"

        # Opciones
        puts "1. Ver material"
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
                # Lectura de json a array de materiales
                l = leerJSON_Array("data_material/material.json", [CLASE::LIBRO, CLASE::JOURNAL, CLASE::ACTA_CONGRESO])
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
                # system "cls"

                case opAccion
                # Búsqueda C
                when ACCION::BUSQUEDA
                    puts "Ingrese método de búsqueda"
                    puts "1. Autor"
                    puts "2. Titulo"
                    puts "3. Area / Género"
                    puts "4. Tipo (e.g. Libro, Journal...)"
                    puts "5. Disponibilidad"
                    puts "6. Material ya reservado"
                    puts "7. Usuarios deudores"
                    puts "8. Salir"
                    print "-> "
                    opBusq = getOp(1,8)
                    if opBusq == 8 then next end # Para salir
                    system "cls"
                    # Ordenamiento en base a atributo
                    case opBusq
                    when 1
                        puts "Ingrese autor a buscar"
                        autor = gets.chomp # para quitar el /n del final
                        cmd = `modulos_c\\cprog.exe #{1} "#{autor}"`
                        system "cls"
                        puts(cmd) # Realiza la función en el programa compilado de C mediante un cmd interno
                    when 2
                        puts "Ingrese titulo a buscar"
                        autor = gets.chomp # para quitar el /n del final
                        cmd = `modulos_c\\cprog.exe #{2} "#{autor}"`
                        system "cls"
                        puts(cmd) # Realiza la función en el programa compilado de C mediante un cmd interno
                    when 3
                        puts "Ingrese el área a buscar"
                        area = gets.chomp
                        cmd = `modulos_c\\cprog.exe #{3} "#{area}"`
                        system "cls"
                        puts(cmd)
                    when 4
                        puts "Ingrese el tipo a buscar"
                        tipo = gets.chomp
                        cmd = `modulos_c\\cprog.exe #{4} "#{tipo}"`
                        system "cls"
                        puts(cmd)
                    when 5
                        puts "Libros disponibles"
                        stock = "si me quitas no funciono"
                        cmd = `modulos_c\\cprog.exe #{5} "#{stock}"` #Devuelve todos los libros con stock diferente de 0
                        system "cls"
                        puts(cmd)
                    when 6
                        puts "Libros ya reservados"
                        cmd = `modulos_hs\\hsprog.exe "arg1" "arg2"`
                        puts(cmd)
                    when 7
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
                puts "3. Ambos"
                puts "4. Salir"
                print "-> "
                opUsu = getOp(1,4)
                if opUsu == 4 then next end

                clases = []
                case opUsu
                when 1
                    # Lectura de json a array de alumnos
                    clases = [CLASE::ALUMNO]
                when 2
                    # Lectura de json a array de profesores
                    clases = [CLASE::PROFESOR]
                when 3
                    # Lectura de json a array de usuarios
                    clases = [CLASE::ALUMNO, CLASE::PROFESOR]
                end

                # Lectura de json a array de alumnos
                array = leerJSON_Array("data_usuario/usuarios.json", clases)
                for material in array do
                    puts printObj(material)
                end
                system "pause"

            else
                puts "Opción inválida."
                system "pause"
            end
        end
    end

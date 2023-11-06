Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

require 'json'

def seleccionar_libro(diccionario)
  encontrado = false
  while !encontrado # Mientras "encontrado" sea falso, repite el siguiente bloque de código
    puts "Ingresa el título del libro a buscar:"
    print "-> "
    titulo = gets.chomp # Lee la entrada del usuario y la asigna a la variable "titulo"
    if diccionario[titulo]
      puts "Libro encontrado"
      return diccionario[titulo]["titulo"] # Retorna el nombre del libro
    else
      puts "El libro no se encuentra en el repositorio!"
      puts " "
    end # Fin del bloque condicional
  end # Fin del ciclo while
end # Fin de la definición de la función


def contarLibReservadoPorRuta(ruta, nombre)
  # Cargar los datos de los usuarios
  usuarios = leerJSON(ruta)

  # Contar el número de libros reservados
  contador = 0

  for usuario in usuarios
    if usuario["nombre"] == nombre
      contador += usuario["librosAdeudados"].length
    end
  end

  return contador
end


def actualizar_libro(usuario_codigo, titulo_libro)
  # Cargar datos de usuarios y material desde los archivos JSON
  usuarios_data = leerJSON("./data_usuario/usuarios.json")
  material_data = leerJSON("./data_material/material.json")

  # Buscar al usuario por su código de alumno o Profesor
  usuario = usuarios_data.detect { |user| user["codAlumno"] == usuario_codigo.to_i || user["codProfesor"] == usuario_codigo.to_i }

  if usuario
    # Buscar el libro por su título
    libro = material_data.find { |libro| libro["titulo"] == titulo_libro }

    if libro && libro["stock"] > 0
      # Restar 1 al stock del libro
      libro["stock"] -= 1

      # Agregar el título del libro a la lista de libros reservados del usuario
      usuario["librosAdeudados"] << titulo_libro

      #Verificar si usuario tiene libros adeudados
      if !usuario["librosAdeudados"].empty?
        usuario["adeudaLib"] = true
      end

      # Guardar los datos actualizados en los archivos JSON
      guardar_json("./data_usuario/usuarios.json", usuarios_data)
      guardar_json("./data_material/material.json", material_data)

      puts "Libro actualizado: #{titulo_libro} reservado para el usuario #{usuario_codigo}."
    else
      puts "El libro no está disponible en stock o no existe."
      puts "¿Desea que se le notifique cuando este disponible? (S/N)"
      print "-> "
      op = gets.chomp
      while op != "S" && op != "N" do
        puts "Solo Si (S) o No (N)"
        print "-> "
        op = gets.chomp
      end

      # Desea reservar un libro
      if op == "S" then
        # Se agrega el libro
        usuario["libReservados"] << titulo_libro
        # Si la lista no esta vacia poner true
        usuario["tieneLibSeparado"] = !usuario["libReservados"].empty?
        # Guardar el JSON final
        guardar_json("./data_usuario/usuarios.json", usuarios_data)
        # Mensaje de confirmación
        puts "Listo, " + titulo_libro + " se ha guardado en la lista de libros reservados del usuario " + usuario_codigo + "."

      else
        puts "Listo, " + titulo_libro + " no se ha guardado en la lista de libros"
      end

    end
  else
    puts "El usuario no fue encontrado."
  end
end

#Lectura sin restricciones
def leerJSON(archivo)
  # Lee el contenido del archivo y lo almacena en la variable 'contenido'.
  contenido = File.read(archivo)
  # Utiliza 'JSON.parse' para decodificar el contenido del archivo JSON y lo almacena en la variable 'datos'.
  datos = JSON.parse(contenido)
  # Devuelve los datos decodificados.
  return datos
end

#Funcion para guardar datos en archivo json
def guardar_json(archivo, datos)
  # Abre el archivo en modo escritura ('w').
  File.open(archivo, 'w') do |file|
    # Con 'JSON.dump' o 'JSON.pretty_generate', convierte la estructura de datos 'datos' en una cadena JSON y la escribe en el archivo.
    file.write(JSON.pretty_generate(datos))
  end
end

# Lee el JSON en búsqueda de los libros
def obtenerLibrosJSON(archivo)
  contenido = File.read(archivo)
  # Decodificar el contenido
  datos = JSON.parse(contenido)
  diccionario = {}
  # Iterar sobre los datos del archivo
  datos.each do |dato|
      # Guarda el título del libro y el libro
      diccionario[dato["titulo"]] = dato
  end
  # Devolvemos el diccionario
  return diccionario
end

def existe_codigo(ruta_archivo, usuario_codigo)
  if usuario_codigo == "0" then
    return true
  end

  usuarios_data = leerJSON(ruta_archivo)
  # Buscar al usuario por su código de alumno o Profesor
  usuario = usuarios_data.detect { |user| user["codAlumno"] == usuario_codigo.to_i || user["codProfesor"] == usuario_codigo.to_i }
  if usuario
    return true
  else
    return false
  end
end

def retornarDatosDelUsuario(ruta, codigo)
  datos = leerJSON(ruta)
  usuario = datos.detect { |user| user["codAlumno"] == codigo.to_i || user["codProfesor"] == codigo.to_i }
  if usuario
    return usuario["nombre"], usuario["clase"], usuario["tiempo"]
  else
    return nil
  end
end

def verificarReserva(codUsuario)
  # Cargar datos de usuarios y material desde los archivos JSON
  usuarios_data = leerJSON("./data_usuario/usuarios.json")
  material_data = leerJSON("./data_material/material.json")

  # Buscar al usuario por su código de alumno o Profesor
  usuario = usuarios_data.detect { |user| user["codAlumno"] == codUsuario.to_i || user["codProfesor"] == codUsuario.to_i }

  # Verificar disponibilidad
  if usuario
    librosReservados = usuario["libReservados"]

    for lib in librosReservados do
      libro = material_data.find { |x| x["titulo"] == lib }
      if libro && libro["stock"] > 0 then
        puts "\t¡Ahora tu libro " + libro["titulo"] + " está disponible!"
        system "pause"
      else
        puts "\tEl libro " + libro["titulo"] + " todavía no está disponible."
      end
    end
  end

end

=begin

==========================================================================================================================================
=end

def hacer_prestamo
  rutaLocal = "data_material/material.json"
  rutaExterna = "proyecto-lp/data_material/material.json"
  rutaLocalUsuarios = "data_usuario/usuarios.json"
  verificacionCodigo = false

  # Mientras el usuario no ingrese un código válido, se quedará en este bucle
  puts "=======Ingrese código======= (Ingrese 0 para salir)"
  print "-> "
  codigo = gets.chomp
  verificacionCodigo = existe_codigo(rutaLocalUsuarios, codigo)
  while !verificacionCodigo
    puts "* Codigo no valido! Ingrese otra vez"
    print "-> "
    codigo = gets.chomp
    verificacionCodigo = existe_codigo(rutaLocalUsuarios, codigo)
  end
  if codigo == "0" then return end

  puts "======= Código válido ======="
  puts " "

  #Obtener el nombre, clase y atributo tiempo del usuario
  data = retornarDatosDelUsuario(rutaLocalUsuarios,codigo)
  nombre = data[0]
  maxLib = (data[1] == "Alumno") ? Alumno.maxLibro : Profesor.maxLibro
  maxTime = (data[1] == "Alumno") ? Alumno.maxTiempo : Profesor.maxTiempo

  #Obtener la cantidad de libros reservados por el usuario
  cantLibReservado = contarLibReservadoPorRuta(rutaLocalUsuarios,nombre)
  puts "* Cantidad de libros adeudados: " + cantLibReservado.to_s

  horasDeuda = data[2]
  puts "* Tiempo transcurrido desde préstamo: " + horasDeuda.to_s

  #Verificar si puede reservar más libros
  if cantLibReservado >= maxLib then
    puts "¡No puedes realizar el prestamo, has excedido el numero de libros adeudados!\n"
    puts " "
    return
  end

  if horasDeuda >= maxTime then
    puts "¡No puedes realizar el prestamo, has excedido el tiempo de retorno de libros!"
    puts " "
    return
  end

  # Caso positivo
  puts "¡Habilitado para préstamo!"
  puts " "

  # Notificacion (si es que hay stock)
  verificarReserva(codigo)

  # Cargar datos de libros cuyo stock sea != 0
  diccionario = obtenerLibrosJSON(rutaLocal)

  # Obtener el libro para reservar
  libroParaReservar = seleccionar_libro(diccionario)

  #Hace el préstamo
  actualizar_libro(codigo, libroParaReservar)
end

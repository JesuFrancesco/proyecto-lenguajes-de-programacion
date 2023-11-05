require 'json'

def seleccionar_libro(diccionario)
  encontrado = false
  while !encontrado # Mientras "encontrado" sea falso, repite el siguiente bloque de código
    puts "Ingresa el título del libro a buscar:"
    titulo = gets.chomp # Lee la entrada del usuario y la asigna a la variable "titulo"
    if diccionario[titulo]
      puts "Libro encontrado"
      return diccionario[titulo]["titulo"] # Retorna el nombre del libro
    else
      puts "El libro no se encuentra en el repositorio"
      puts " "
    end # Fin del bloque condicional
  end # Fin del ciclo while
end # Fin de la definición de la función

def contar_libros_reservados_por_ruta(ruta, nombre)
  # Cargar los datos de los usuarios
  usuarios = leer_json_v2(ruta)

  # Contar el número de libros reservados
  contador = 0

  for usuario in usuarios
    if usuario["nombre"] == nombre
      contador += usuario["libReservados"].length
    end
  end

  return contador
end



def actualizar_libro(usuario_codigo, titulo_libro)
  # Cargar datos de usuarios y material desde los archivos JSON
  usuarios_data = leer_json_v2("./data_usuario/usuarios.json")
  material_data = leer_json_v2("./data_material/material.json")

  # Buscar al usuario por su código de alumno o Profesor
  usuario = usuarios_data.detect { |user| user["codAlumno"] == usuario_codigo.to_i || user["codProfesor"] == usuario_codigo.to_i }

  if usuario
    # Buscar el libro por su título
    libro = material_data.find { |libro| libro["titulo"] == titulo_libro }

    if libro && libro["stock"] > 0
      # Restar 1 al stock del libro
      libro["stock"] -= 1

      # Agregar el título del libro a la lista de libros reservados del usuario
      usuario["libReservados"] << titulo_libro

      # Guardar los datos actualizados en los archivos JSON
      guardar_json("./data_usuario/usuarios.json", usuarios_data)
      guardar_json("./data_material/material.json", material_data)

      puts "Libro actualizado: #{titulo_libro} reservado para el usuario #{usuario_codigo}."
    else
      puts "El libro no está disponible en stock o no existe."
    end
  else
    puts "El usuario no fue encontrado."
  end
end

#Lectura sin restricciones
def leer_json_v2(archivo)
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
    # Con 'JSON.dump', convierte la estructura de datos 'datos' en una cadena JSON y la escribe en el archivo.
    file.write(JSON.dump(datos))
  end
end

def leer_json(archivo)
  contenido = File.read(archivo)
  # Decodificar el contenido
  datos = JSON.parse(contenido)
  diccionario = {}
  # Iterar sobre los datos del archivo
  datos.each do |dato|
    if dato["stock"] != 0
      # Guarda el título del libro y el libro
      diccionario[dato["titulo"]] = dato
    end
  end
  # Devolvemos el diccionario
  return diccionario
end



def existe_codigo(ruta_archivo, usuario_codigo)
  usuarios_data = leer_json_v2(ruta_archivo)

  # Buscar al usuario por su código de alumno o Profesor
  usuario = usuarios_data.detect { |user| user["codAlumno"] == usuario_codigo.to_i || user["codProfesor"] == usuario_codigo.to_i }
  if usuario
    return true
  else
    return false
  end
end

def nombre_usuario_por_codigo(ruta, codigo)
  datos = leer_json_v2(ruta)
  usuario = datos.detect { |user| user["codAlumno"] == codigo.to_i || user["codProfesor"] == codigo.to_i }
  if usuario
    return usuario["nombre"]
  else
    return nil
  end
end

=begin

==========================================================================================================================================
=end
rutaLocal = "./data_material/material.json"
rutaExterna = "proyecto-lp/data_material/material.json"
rutaLocalUsuarios = "./data_usuario/usuarios.json"
verificarcionCodigo = false
codigo = 0

# Mientras el usuario no ingrese un código válido, se quedará en este bucle
while !verificarcionCodigo
  puts "=======Ingrese código======="
  codigo = gets.chomp
  verificarcionCodigo = existe_codigo(rutaLocalUsuarios, codigo)
end

puts "======= Código válido ======="


# Cargar datos de libros cuyo stock sea != 0
diccionario = leer_json(rutaLocal)

# Obtener el libro para reservar
libroParaReservar = seleccionar_libro(diccionario)

#Obtener el nombre del usuario
nombre = nombre_usuario_por_codigo(rutaLocalUsuarios,codigo)

#Obtener la cantidad de libros reservados por el usuario
cantidadLibrosReservados = contar_libros_reservados_por_ruta(rutaLocalUsuarios,nombre)
puts cantidadLibrosReservados

#Verificar si puede reservar más libros


#Hace el préstamo
actualizar

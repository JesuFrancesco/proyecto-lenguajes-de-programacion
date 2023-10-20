if __FILE__ != $0 then exit end

Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

# Modelo USUARIO

puts "***************************************"
puts "**********               **************"
puts "********** biblioteca ul **************"
puts "**********               **************"
puts "***************************************"

# TEST
x = Alumno.new(1, "a", "b", "c")
y = Profesor.new(2, "a", "b", "c")
# z = Usuario.new() <= Agarra excepcion

w = Libro.new()
w.datos("el","pepe","123")
# w1 = Material.new() <= Agarra excepcion

while true do
    puts "1. Ver libros"
    puts "2. Ver usuarios"
    puts "3. Salir"
    opcion = gets.to_i
    if opcion == 3 then 
        break
    else 
        puts "ok"
        case opcion
        when 1
            puts w.titulo
        when 2
            puts "- Alumno #{x.apellidoPaterno} #{x.apellidoMaterno} #{x.nombre} de codigo #{x.codAlumno}"
            # puts y.maxLibro
        else
            puts "no hacer nada"
        end
    end
end


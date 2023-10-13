if __FILE__ != $0 then exit end

Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

puts "***************************************"
puts "**********               **************"
puts "********** biblioteca ul **************"
puts "**********               **************"
puts "***************************************"

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
            puts "hacer 1"
        when 2
            puts "hacer 2"
        else
            puts "no hacer nada"
        end
    end
end

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

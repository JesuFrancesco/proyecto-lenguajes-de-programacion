if __FILE__ != $0 then exit end

Dir["clases/persona/*.rb"].each { |clasePer| require_relative clasePer }
Dir["clases/media/*.rb"].each { |claseMe| require_relative claseMe }

# Require
require 'tk'

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

ventana = TkRoot.new  {title "Proyecto Integrador | Biblioteca"}
TkLabel.new(ventana) do
    text 'Inicio sesion'
    font 'Times 16 bold'    
    pack { padx 15 ; pady 15; side 'left' }
end
TkLabel.new(ventana) do
    text 'Apellido Paterno'
    font 'Times 16 bold'    
    pack { padx 15 ; pady 15; side 'left' }
end
TkLabel.new(ventana) do
    text 'Apellido Materno'
    font 'Times 16 bold'    
    pack { padx 15 ; pady 15; side 'left' }
end
TkLabel.new(ventana) do
    text 'Nombre'
    font 'Times 16 bold'    
    pack { padx 15 ; pady 15; side 'left' }
end
Tk.mainloop


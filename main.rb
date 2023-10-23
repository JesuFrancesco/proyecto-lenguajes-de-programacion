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

ventana = TkRoot.new {title "Proyecto Integrador | Biblioteca"}
ventana.geometry = '800x800'
#code to add a label widget
TkLabel.new(ventana){
   text 'Registro'
   font 'Times 20 bold'
   background "orange"
   grid('row'=>0, 'column'=>0, 'columnspan'=>2)
}

TkLabel.new(ventana){
    text 'Apellido Paterno'
    font 'Times 16 bold'
    grid('row'=>1, 'column'=>0)
}

TkLabel.new(ventana){
    text 'Apellido Materno'
    font 'Times 16 bold'
    grid('row'=>2, 'column'=>0)
}

TkLabel.new(ventana){
    text 'Nombre'
    font 'Times 16 bold'
    grid('row'=>3, 'column'=>0)
}

$aP = TkVariable.new
lab_ApPaterno = TkEntry.new(ventana){
    font 'Arial 12'
    textvariable $aP
    grid('row'=>1, 'column'=>1)
}

$aM = TkVariable.new
lab_ApMAterno = TkEntry.new(ventana){
    font 'Arial 12'
    textvariable $aM
    grid('row'=>2, 'column'=>1)
}

$n = TkVariable.new
lab_Nombre = TkEntry.new(ventana){
    font 'Arial 12'
    textvariable $n
    grid('row'=>3, 'column'=>1)
}

def registrar()
    alumno = Alumno.new(222, $aP.get, $aM.get, $n.get)
    puts alumno
    # puts "heyy"
end

botonR = TkButton.new(ventana){
    font 'Times 14 bold'
    text 'Registrar'
    command (proc {registrar})
    grid('row'=>4,'column' =>0, 'columnspan'=>2)
}

Tk.mainloop


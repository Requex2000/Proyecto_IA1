#Python 3.10 
Warning #Python 3.11
#pip install tensorflow
#pip install Pillow
#pip install image
from tkinter import Tk, Label, Button, Text, Canvas, messagebox
from PIL import ImageTk, Image

respuestas = {}

def inicio():
    ventana = Tk()
    ventana.title('Proyecto Final - I.A. diagnóstico de pc por red neuronal')
    ventana.geometry('530x600')

    canvas = Canvas(ventana, width=530, height=600)
    canvas.pack()

    # Cargar y ajustar la imagen de fondo
    imagen_fondo = Image.open("ubi.jpg")
    imagen_fondo = imagen_fondo.resize((530, 600), Image.ANTIALIAS)
    imagen_fondo = ImageTk.PhotoImage(imagen_fondo)
    canvas.create_image(0, 0, anchor='nw', image=imagen_fondo)

    L = Label(ventana, text='INTELIGENCIA ARTIFICIAL', font=('Arial', 16, 'bold'))
    L.place(x=130, y=20)

    A = Label(ventana, text='Estudiante: Joel Reque', font=('Arial', 12))
    A.place(x=320, y=360)

    texto = Label(ventana, text='Por favor responda a las preguntas para diagnosticar su PC', font=('Arial', 12))
    texto.place(x=20, y=100)

    respl = Text(ventana, width=60, height=10)
    respl.place(x=20, y=130)

    def salir():
        ventana.destroy()

    salir_btn = Button(ventana, text='SALIR', command=salir, width=10, font=('Arial', 12), relief='raised', bd=2, bg='#f44336', fg='white')
    salir_btn.place(x=20, y=400)

    def botones():
        respuestas.clear()
        falla = fallas()
        texto.config(text='La solución es:')
        respl.delete('1.0', 'end')
        respl.insert('1.0', falla)

    boton_diagnostico = Button(ventana, text='Información', command=lambda: messagebox.showinfo('Diagnóstico de PC', 'Realiza el diagnóstico de tu PC.'), width=15, font=('Arial', 12), relief='raised', bd=2, bg='#4caf50', fg='white')
    boton_diagnostico.place(x=20, y=55)

    boton_revision = Button(ventana, text='INICIAR DIAGNOSTICO', command=botones, width=20, font=('Arial', 12, 'bold'), relief='raised', bd=2, bg='#2196f3', fg='white')
    boton_revision.place(x=270, y=55)

    ventana.mainloop()

def fallas():
    if limpieza_ventilador():
        return 'El sonido fuerte que ocasiona el ventilador puede deberse a que no se hizo la limpieza correspondiente al equipo. Se recomienda llevar el equipo a mantenimiento para que le hagan una limpieza profunda.'
    elif mantenimiento_disco():
        return 'Su equipo está lento porque puede tener el disco duro lleno o muchos archivos dispersos. Se recomienda llevar el equipo a mantenimiento.'
    elif mantenimiento_procesador():
        return 'Su equipo puede estar con sobrecalentamiento porque el procesador requiere un cambio de pasta térmica. Se recomienda llevar este equipo a mantenimiento.'
    elif mantenimiento_video():
        return 'Su equipo enciende pero no muestra nada en la pantalla, probablemente porque no se instaló la tarjeta gráfica correctamente. Se recomienda llamar al técnico.'
    elif mantenimiento_sistema():
        return 'Su equipo no termina de iniciar, probablemente por una falla en el sistema operativo. Se recomienda llamar al técnico.'
    elif mantenimiento_equipo():
        return 'Su equipo no enciende por una falla en los componentes. Se recomienda llevar el equipo a una revisión profunda.'
    else:
        return 'Sin resultados. Debido a la cantidad de fallos, se recomienda llamar al técnico.'

def limpieza_ventilador():
    return pregunta('¿Tienes problemas de ruido?')

def mantenimiento_disco():
    return pregunta('¿Tienes problemas de lentitud?')

def mantenimiento_procesador():
    return pregunta('¿Tienes problemas de sobrecalentamiento de tu equipo?')

def mantenimiento_video():
    return pregunta('¿Tu PC está encendida pero no se muestra nada en el monitor?')

def mantenimiento_sistema():
    return pregunta('¿Tu PC se queda en el logo del sistema al encender?')

def mantenimiento_equipo():
    return pregunta('¿Tu PC no enciende?')

def pregunta(problema):
    if problema in respuestas:
        return respuestas[problema]
    else:
        respuesta = messagebox.askyesno('Diagnóstico de PC', problema)
        respuestas[problema] = respuesta
        return respuesta

inicio()

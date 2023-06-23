%declaracion de librerias

:-use_module(library(pce)).
:-use_module(library(pce_style_item)).

% metodo de interfaz.
inicio:-
	new(Menu, dialog('Proyecto Final', size(1000,800))),
	new(L,label(nombre,'Inteligencia Artificial')),
	new(A,label(nombre,'Estudiantes: Rafael Hidalgo y Victor Yugar')),
	new(@texto,label(nombre,'Responde a la preguntas')),
	new(@respl,label(nombre,'')),
	new(Salir,button('SALIR',and(message(Menu, destroy),message(Menu,free)))),
	new(@boton,button('realizar test',message(@prolog,botones))),


	send(Menu,append(L)),new(@btncarrera,button('Diagnostico?')),
	send(Menu,display,L,point(125,20)),
	send(Menu,display,A,point(80,360)),
	send(Menu,display,@boton,point(100,150)),
	send(Menu,display,@texto,point(20,100)),
	send(Menu,display,Salir,point(20,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).

%posibles soluciones a las fallas del equipo

fallas('El Sonido fuerte que ocasiona el ventilador puede deberse a que no
se hizo la limpieza correspondiente al equipo por lo que se recomenda llevar
el equipo a mantenimiento para que le hagan una limpieza profunda'):-ventilador,!.

fallas('Su equipo esta lento por que puede tener el disco duro lleno o muchos archivos dispersos
recomendamos llevar el equipo a mantenimiento'):-disco,!.

fallas('su equipo puede estar con sobrecalentamiento por que el
procesador requiere de un cambio de pasta termica recomendamos
llevar este equipo a mantenimiento'):-procesador,!.

fallas('Su equipo enciende pero no muestra nada en la pantalla probablemente
por que no se instalo la tarjeta grafica de manera correcta recomendamos
que llame al tecnico.'):-video,!.

fallas('su equipo no termina de iniciar probablemente por una falla en el sistema operativo
recomendamos llamar al tecnico'):-sistema,!.

fallas('su equipo no enciende por una falla en los componentes recomendamos llevar el equipo a
una revision profunda'):-componente,!.


fallas('sin resultados! debido a la cantidad de fallos recomendamos llamar al tecnico ').

% preguntas para saber razon de las fallas
ventilador:- limpieza_ventilador,
	pregunta('escucha ruidos fuertes al encender la PC?'),
	pregunta('su equipo se calienta mucho?'),
	pregunta('su equipo emite un sonido muy fuerte? '),
	pregunta('su equipo no ha sido limpiado ultimamente?'),
	pregunta('su equipo no ha sido llevado a mantenimiento ultimamente? ').

disco:- mantenimiento_disco,
	pregunta('tiene problemas por que el equipo demora mucho en iniciar?'),
	pregunta('tiene problemas por demora al abrir programas basicos?'),
	pregunta('tiene problemas de lentitud al navegar? '),
	pregunta('tiene problemas para revisar archivos comunes?').

procesador:- mantenimiento_procesador,
	pregunta('tienes problemas de temperatura con el equipo?'),
	pregunta('tiene problemas al trabajar en multitarea?'),
	pregunta('tiene problemas para abrir programas que antes funcionaban de manera normal?'),
	pregunta('tiene problemas con el rendimiento que antes no tenia?').

video:- mantenimiento_video,
	pregunta('tu pc esta encendida pero no muestra nada en el monitor?'),
	pregunta('al abrir programas de edicion se cierran automaticamente?'),
	pregunta('al abrir juegos exigentes te muestra un error? ').

sistema:- mantenimiento_sistema,
	pregunta('tu pc al encender se quedq con la pantalla que muestra el logo?'),
	pregunta('sigues esperando por mucho tiempo pero la carga sigue igual?').

componente:- mantenimiento_equipo,
	pregunta('apretas el boton de encendido pero sigue igual?'),
	pregunta('el problema persiste despues de cambiar el cable de energia?').

%variable para identificar fallas

limpieza_ventilador:-pregunta('tienes problemas de ruido?'),!.
mantenimiento_disco:-pregunta('tienes problemas de lentitud?'),!.
mantenimiento_procesador:-pregunta('tiene problemas de sobrecalentamiento de tu equipo?'),!.
mantenimiento_video:-pregunta('tu equipo esta encendido pero no se muestra nada en el monitor?'),!.
mantenimiento_sistema:-pregunta('tu pc se queda en el logo del sistema a la hora de encender?'),!.
mantenimiento_equipo:-pregunta('tu pc no enciende?'),!.


% proceso para saber la falla segun las preguntas

:-dynamic si/1,no/1.
preguntar(Problema):- new(Di,dialog('Diagnostico de PC')),
     new(L2,label(texto,'Responde las siguientes preguntas')),
     new(La,label(prob,Problema)),
     new(B1,button(si,and(message(Di,return,si)))),
     new(B2,button(no,and(message(Di,return,no)))),

         send(Di,append(L2)),
	 send(Di,append(La)),
	 send(Di,append(B1)),
	 send(Di,append(B2)),

	 send(Di,default_button,si),
	 send(Di,open_centered),get(Di,confirm,Answer),
	 write(Answer),send(Di,destroy),
	 ((Answer==si)->assert(si(Problema));
	 assert(no(Problema)),fail).

% limpiar pantalla para responder cada pregunta

pregunta(S):-(si(S)->true; (no(S)->false; preguntar(S))).
limpiar :- retract(si(_)),fail.
limpiar :- retract(no(_)),fail.
limpiar.

% proceso de eleccion de acuerdo al diagnostico basado en las preguntas
% anteriores

botones :- lim,
	send(@boton,free),
	send(@btncarrera,free),
	fallas(Falla),
	send(@texto,selection('la solucion es ')),
	send(@respl,selection(Falla)),
	new(@boton,button('inicia revision ',message(@prolog,botones))),
        send(Menu,display,@boton,point(40,50)),
        send(Menu,display,@btncarrera,point(20,50)),
limpiar.
lim :- send(@respl, selection('')).

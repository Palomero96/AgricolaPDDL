(define (domain Agricola)
(:requirements :strips :typing :fluents)
(:types jugador recurso accion animal espacio almacenado guardado contador)
(:constants jugadorUno jugadorDos - jugador
one two three four five six seven eight nine ten - counter)
(:predicates 
		(disponible ?accion - accion)
		(bloqueado ?accion - accion ?)

)

(:functions (Almacenado ?j-jugador ?material-recurso)
			(Accion ?accion- accion)
			(Reponer) ;Duda si hace falta

)

;Empezar por la accion de poner disponible y las relacionadas con el turno
)
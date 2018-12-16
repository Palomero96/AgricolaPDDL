(define (domain Agricola)
(:requirements :strips :typing :fluents)
(:types jugador recurso accion animal espacio almacenado guardado contador)
(:constants jugadorUno jugadorDos - jugador
one two three four five six seven eight nine ten - counter)
(:predicates
		(desbloquear ?accion - accion ?ronda - counter) ;Acciones a desbloquear en cada ronda
		(disponible ?accion - accion) ;Acciones disponibles
		(bloqueado ?accion - accion ?) ;Acciones bloqueadas
		(nextFase ?f1 ?f2 - counter) ;Para los cambios de fase
		(actualFase ?f - counter) ;Fase actual
		(maxFase ?fase ?ronda - counter) ;Máximas fases por cada ronda, por si hay cosecha
		(jugadaFase ?f - counter) ;Para saber que fases se han jugado
		(nextRonda ?r1 ?r2 - counter) ;Para los cambios de ronda
		(actualRonda ?r - counter) ;Ronda actual
		(maxRonda ?r - counter) ;Para definir la ronda final
		(jugadaRonda ?r - counter) ;Para saber cuales hemos jugado
)

(:functions (Almacenado ?j-jugador ?material-recurso)
			(Accion ?accion- accion)
			(Reponer) ;Duda si hace falta
)

;Empezar por la accion de poner disponible y las relacionadas con el turno
(:action habilitar
         :parameters (?accion - accion) (?ronda - counter)
         :precondition (and (desbloquear ?accion ?ronda))
         :effect (disponible ?accion))
)
(:action cambioFase
		:parameters (?f - counter) (?r - counter)
		:vars (?nf - counter)
		:precondition (and (not (maxFase ?f ?r)))
		:effect (nextFase ?f ?nf)
)

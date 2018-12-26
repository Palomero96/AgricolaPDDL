(define (domain Agricola)
(:requirements :strips :typing :fluents)
(:types jugador recurso accion animal espacio almacenado guardado counter)
(:constants jugadorUno jugadorDos - jugador
	madera adobe juncal piedra cereal hortaliza comida - recurso
	oveja cerdo vaca - animal
	ampliacionGranja semillasCereales bosque labranza mina juncal jornalero pesca adquisicionMayor reformarCasa mercadoPorcino mercadoBovino cultivo reformasGranja mercadoOvino familiaPlanificada familiaPrecipitada semillasHortalizas canteraOriental vallado canteraOccidental siembra - accion
one two three four five six seven eight nine ten eleven twelve thirteen fourteen - counter)
(:predicates
		(desbloquear ?accion - accion ?ronda - counter) ;Acciones a desbloquear en cada ronda
		(disponible ?accion - accion) ;Acciones disponibles
		(acumulable ?accion - accion ?counter - counter) ;Para las acciones que acumulan recursos, hay que ver como poner el numero
		(repuesto ?accion - accion)
		(bloqueado ?accion - accion ) ;Acciones bloqueadas
		(nextFase ?f1 ?f2 - counter) ;Para los cambios de fase
		(actualFase ?f - counter) ;Fase actual
		(maxFase ?fase ?ronda - counter) ;Máximas fases por cada ronda, por si hay cosecha
		(jugadaFase ?f - counter) ;Para saber que fases se han jugado
		(nextRonda ?r1 ?r2 - counter) ;Para los cambios de ronda
		(actualRonda ?r - counter) ;Ronda actual
		(maxRonda ?r - counter) ;Para definir la ronda final
		(jugadaRonda ?r - counter) ;Para saber cuales hemos jugado
		(cambiarFase) ;VARIABLE Para que se indique cuando vamos a cambiar fase y a cual
		(habilitar)
		(fin)
)
;Empezar por la accion de poner disponible y las relacionadas con el turno
(:functions (acumulado ?accion - accion)(almacenRecursoJug ?r - recurso ?j - jugador))


(:action reponer ;Accion para reponer todos los recursos 
         :parameters (?accion - accion )
         :vars (?counter - counter)
         :precondition (and (actualFase two) (disponible ?accion) (acumulable ?accion ?counter) (not (repuesto ?accion)))
         :effect ; En funcion de que recurso sea habra que sumarle una cantidad u otra
				(and 
				(when (acumulable ?accion one) (and (repuesto ?accion) (increase (acumulado ?accion) 1)(fin))
				)
				(when (acumulable ?accion two) (and (repuesto ?accion) (increase (acumulado ?accion) 2) (fin))
				)
				(when (acumulable ?accion three) (and (repuesto ?accion) (increase (acumulado ?accion) 3) (fin))
				)
	 )
)

(:action habilitar
         :parameters (?accion - accion ?ronda - counter)
         :precondition (and (habilitar)(desbloquear ?accion ?ronda))
         :effect (and (disponible ?accion)(cambiarFase)(not (habilitar)))
)

(:action cambioFase
		:parameters (?fase - counter ?nextFase - counter)
		:vars (?ronda - counter ?nextRonda - counter) ;Next fase, para calcularlo en ejecución y pasarlo
		:precondition (and (actualRonda ?ronda)(actualFase ?fase)(cambiarFase)(nextFase ?fase ?nextFase)(nextRonda ?ronda ?nextRonda))
		:effect
		(and
			(when (maxFase ?fase ?ronda)
			(and
				(not (actualFase ?fase))
				(actualFase one)
				(not (actualRonda ?ronda))
				(actualRonda ?nextRonda)
				)
				)
		(when (not (maxFase ?fase ?ronda))
				(and
					(not (actualFase ?fase))
					(actualFase ?nextFase)
					
				)
			)
		)
	)
)

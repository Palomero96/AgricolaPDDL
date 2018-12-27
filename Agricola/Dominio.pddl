(define (domain Agricola)
(:requirements :strips :typing :fluents :equality :adl)
(:types jugador recurso accion animal espacio almacenado guardado counter)
(:constants jugadorUno jugadorDos - jugador
	oveja cerdo vaca - animal
	ampliacionGranja semillasCereales bosque labranza mina juncal jornalero pesca adquisicionMayor reformarCasa mercadoPorcino mercadoBovino cultivo reformasGranja mercadoOvino familiaPlanificada familiaPrecipitada semillasHortalizas canteraOriental vallado canteraOccidental siembra - accion
	one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen - counter)
(:predicates
	(desbloquear ?accion - accion ?ronda - counter) ;Acciones a desbloquear en cada ronda
			(disponible ?accion - accion) ;Acciones disponibles
			(utilizada ?accion - accion ) ;Para controlar que no la puedan realizar mas de un jugador en un mismo turno
			(nextFase ?f1 ?f2 - counter) ;Para los cambios de fase
			(actualFase ?f - counter) ;Fase actual
			(maxFase ?fase ?ronda - counter) ;Máximas fases por cada ronda, por si hay cosecha
			(turno ?jugador - jugador) ;Para saber a quien le toca
			(nextRonda ?r1 ?r2 - counter) ;Para los cambios de ronda
			(actualRonda ?r - counter) ;Ronda actual
			(maxRonda ?r - counter) ;Para definir la ronda final
			(cambiarFase) ;VARIABLE Para que se indique cuando vamos a cambiar fase y a cual
			(cambioTurno ?j1 ?j2 - jugador) ;Para saber cual es el siguiente jugador
			(recursoAccion ?r - recurso ?accion - accion) ;Auxiliar para saber que recursos dan cada accion
			(habilitar)
			(reponer)
			(fin)
)

(:functions (acumulado ?accion - accion)
            (habitantes ?jugador - jugador)
            (habrestantes ?jugador - jugador)
            (almacenRecursoJug ?r - recurso ?j - jugador)
            (costeTotal)
            (costeJug ?jugador - jugador)
)

;Operador para la fase uno de habilitar acciones
(:action habilitar
         :parameters (?accion - accion ?ronda - counter)
         :precondition (and (habilitar)(desbloquear ?accion ?ronda) (actualRonda ?ronda))
         :effect (and (disponible ?accion)(cambiarFase)(not (habilitar)) (reponer) (not (desbloquear ?accion ?ronda)))
)

(:action reponer ;Accion para reponer todos los recursos
         :precondition (and (actualFase two) (reponer))
         :effect ;En funcion de cual sea la accion habra que reponer un valor u otro, ademas, habra que tener en cuenta su disponibilidad y en algunos casos su valor acumulado
				(and
				(increase (acumulado bosque) 3)
				(increase (acumulado mina) 1)
				(increase (acumulado juncal) 1)
				(increase (acumulado pesca) 1)
				(when (= (acumulado jornalero) 0) (increase (acumulado jornalero) 2))
				(when (= (acumulado semillasCereales) 0) (increase (acumulado semillasCereales) 1))
				(when (disponible mercadoBovino) (increase (acumulado mercadoBovino) 1))
				(when (disponible mercadoOvino) (increase (acumulado mercadoOvino) 1))
				(when (disponible mercadoPorcino) (increase (acumulado mercadoPorcino) 1))
				(when (disponible canteraOccidental) (increase (acumulado canteraOccidental) 1))
				(when (disponible canteraOriental) (increase (acumulado canteraOriental) 1))
				(when (and (disponible semillasHortalizas) (= (acumulado semillasHortalizas) 0)) (increase (acumulado semillasHortalizas) 1))
				(not (reponer))
				(cambiarFase)
				(habilitar)
				)
)


;Operador para cambiar de Fase
(:action cambioRonda
		:parameters (?ronda - counter ?nextRonda - counter)
		:vars (?fase - counter ?nextFase - counter)
		:precondition (and (actualRonda ?ronda)(actualFase ?fase)(maxFase ?ronda ?fase)(cambiarFase)(nextRonda ?ronda ?nextRonda))
		:effect
		(and
			(when (maxRonda ?ronda)(fin))
				(not (actualFase ?fase))
					(actualFase one)
					(not (actualRonda ?ronda))
					(actualRonda ?nextRonda)
					(not (cambiarFase))
					)
				)

(:action cambioFase
		:parameters (?fase - counter ?nextFase - counter)
		:vars (?ronda - counter ?nextRonda - counter)
		:precondition (and (actualRonda ?ronda)(actualFase ?fase)(cambiarFase)(nextFase ?fase ?nextFase)(not (maxFase ?ronda ?fase)))
		:effect
		(and
					(not (actualFase ?fase))
					(actualFase ?nextFase)
					(not (cambiarFase))
				)
			)
		;Para cambiar de un jugador a otro lo hará en el propio operador de la accion
		;Necesitamos un operador para cuando un jugador tiene mas habitantes que otro
		;Otro operador para saber cuando se han acabado los habitantes de ambos jugadores y eliminar los predicados utilizados y restablecer los habitantes utilizados

		;Operador para las acciones de los recursos
		(:action AccionesdeRecursos
		         :parameters (?accion - accion ?jugadoractual - jugador)
		         :vars (?jugadorsiguiente - jugador ?recurso - recurso)
		         :precondition (and (actualFase three) (disponible ?accion) (not (utilizada ?accion )) (> (habrestantes ?jugadoractual) 0)
		              (turno ?jugadoractual) (> (acumulado ?accion) 0) (cambioTurno ?jugadoractual ?jugadorsiguiente) (recursoAccion ?recurso ?accion)
		         )
		         :effect
		                 (and
		                 (not (turno ?jugadoractual)) (turno ?jugadorsiguiente) ;Indicamos que le toca al otro jugador
		                (decrease (habrestantes ?jugadoractual) 1) ;Disminuimos el numero de habitantes
		                ;Aumentamos los costes
		                (increase (costeJug ?jugadoractual) 3)
		                (increase (costeTotal) 3)
		                (increase (almacenRecursoJug ?recurso ?jugadoractual) (acumulado ?accion))
		                (decrease (acumulado ?accion) (acumulado ?accion))
		                (utilizada ?accion)
		         )
		)
)

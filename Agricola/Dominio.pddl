(define (domain Agricola)
(:requirements :strips :typing :fluents :equality)
(:types jugador recurso accion animal espacio almacenado guardado counter)
(:constants jugadorUno jugadorDos - jugador
	madera adobe juncal piedra cereal hortaliza comida - recurso
	oveja cerdo vaca - animal
	ampliacionGranja semillasCereales bosque labranza mina juncal jornalero pesca adquisicionMayor reformarCasa mercadoPorcino mercadoBovino cultivo reformasGranja mercadoOvino familiaPlanificada familiaPrecipitada semillasHortalizas canteraOriental vallado canteraOccidental siembra - accion
	one two three four five six seven eight nine ten eleven twelve thirteen fourteen - counter)
(:predicates
		(desbloquear ?accion - accion ?ronda - counter) ;Acciones a desbloquear en cada ronda
		(disponible ?accion - accion) ;Acciones disponibles
		(utilizada ?accion - accion ) ;Acciones bloqueadas
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
		(reponer)
		(fin)
)



(:functions (acumulado ?accion - accion)(almacenRecursoJug ?r - recurso ?j - jugador))


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
				(fin)
				)

)

(:action habilitar
         :parameters (?accion - accion ?ronda - counter)
         :precondition (and (habilitar)(desbloquear ?accion ?ronda) (actualRonda ?ronda))
         :effect (and (disponible ?accion)(cambiarFase)(not (habilitar)) (reponer))
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

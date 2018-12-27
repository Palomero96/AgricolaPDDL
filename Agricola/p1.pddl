(define (problem p1) ;Problema para comprobar el primer cambio de fase
(:domain Agricola)
(:objects ampliacionGranja lugarEncuentro semillasCereales bosque labranza mina juncal jornalero pesca adquisicionMayor reformarCasa mercadoPorcino mercadoBovino cultivo reformasGranja mercadoOvino familiaPlanificada familiaPrecipitada semillasHortalizas canteraOriental vallado canteraOccidental siembra - accion
madera adobe junco piedra cereal hortaliza comida - recurso
one two three four five six seven eight nine ten eleven twelve thirteen fourteen - counter)
(:INIT
  (nextFase one two)(nextFase two three)(nextFase three four)
  (actualRonda one)
  (actualFase one)
  (nextRonda one two)
  (nextRonda two three)
  (nextRonda three four)
  (nextRonda four five)
  (nextRonda five six)
  (nextRonda six seven)
  (nextRonda seven eight)
  (nextRonda eight nine)
  (nextRonda nine ten)
  (nextRonda ten eleven)
  (nextRonda eleven twelve)
  (nextRonda twelve thirteen)
  (nextRonda thirteen fourteen)
  (nextRonda fourteen fifteen)
  (maxRonda fourteen)
  (maxFase one two)
  (maxFase two two)
  (maxFase three two)
  (maxFase four two)
  (maxFase five two)
  (maxFase six two)
  (maxFase seven two)
  (maxFase eight two)
  (maxFase nine two)
  (maxFase ten two)
  (maxFase eleven two)
  (maxFase twelve two)
  (maxFase thirteen two)
  (maxFase fourteen two)
  (cambioTurno jugadorUno jugadorDos)
  (cambioTurno jugadorDos jugadorUno)
  (= (almacenRecursoJug madera jugadorUno) 0)
  (= (almacenRecursoJug madera jugadorDos) 0)
  ;Inicializamos los valores de las acciones
  (= (acumulado bosque) 0)
  (= (acumulado mina) 0)
  (= (acumulado juncal) 0)
  (= (acumulado pesca) 0)
  (= (acumulado mercadoBovino) 0)
  (= (acumulado mercadoOvino) 0)
  (= (acumulado mercadoPorcino) 0)
  (= (acumulado canteraOccidental) 0)
  (= (acumulado canteraOriental) 0)
  (= (acumulado jornalero) 0)
  (= (acumulado semillasCereales) 0)
  (= (acumulado semillasHortalizas) 0)
  ;Acciones disponibles desde el principio
  (disponible bosque)
  (disponible ampliacionGranja)
  (disponible semillasCereales)
  (disponible lugarEncuentro)
  (disponible labranza)
  (disponible mina)
  (disponible jornalero)
  (disponible juncal)
  (disponible pesca)

  ;Predicados auxiliares para saber que recursos da cada
  (recursoAccion madera bosque)
  (recursoAccion adobe mina)
  (recursoAccion comida pesca)
  (recursoAccion comida jornalero)
  (recursoAccion junco juncal)
  (recursoAccion piedra canteraOccidental)
  (recursoAccion piedra canteraOriental)
  (recursoAccion cereal semillasCereales)
  (recursoAccion hortaliza semillasHortalizas)

  ;Predicados de las acciones que se van a desbloquear
  (desbloquear semillasHortalizas one)
  (desbloquear mercadoOvino two)
  (desbloquear vallado three)
  (desbloquear siembra four)
  (desbloquear reformarCasa five)
  (desbloquear familiaPlanificada six)
  (desbloquear canteraOccidental seven)
  (desbloquear mercadoPorcino eight)
  (desbloquear semillasHortalizas nine)
  (desbloquear mercadoBovino ten)
  (desbloquear canteraOriental eleven)
  (desbloquear cultivo twelve)
  (desbloquear familiaPrecipitada thirteen)
  (desbloquear reformasGranja fourteen)

  (habilitar)
)
(:goal
  (fin)
)
)

(define (problem p1) ;Problema para comprobar el primer cambio de fase
(:domain Agricola)
(:objects labranza bosque - accion)
(:INIT

  (nextFase one two)(nextFase two three)(nextFase three four)
  (actualRonda one)
  (actualFase one)
  (nextRonda one two)
  (maxRonda two)
  (maxFase three one)
  (= (almacenRecursoJug madera jugadorUno) 0)
  (= (almacenRecursoJug madera jugadorDos) 0)
  (= (acumulado bosque) 0)
  ;Acciones disponibles desde el principio
  (disponible bosque)

  ;Predicados necesarios para el operador reponer 
  (acumulable bosque three)

  ;Predicados de las acciones que se van a desbloquear
  (desbloquear labranza one)
  (habilitar)
)
(:goal
  (fin)
)
)

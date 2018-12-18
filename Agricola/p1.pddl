(define (problem p1) ;Problema para comprobar el primer cambio de fase
(:domain Dominio)
(:objects arar - accion)
(:INIT
  (nextFase one two)(nextFase two three)
  (desbloquear arar one)
  (nextRonda one two)
  (maxRonda two)
  (maxFase three one)
)
(:goal
  (fin)
)
)

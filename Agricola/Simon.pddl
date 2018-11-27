(define (domain SIMON)
(:requirements :strips :typing :fluents)
(:types player - object
counter colour - object)
(:constants human robot - player
one two three four five six seven eight nine ten - counter)
(:predicates (turn ?p - player)
(coloured ?i - counter ?c - colour)
(current-instant ?i - counter)
(instant-limit ?i - counter)
(current-round ?r - counter)
(round-limit ?r - counter)
(round-played ?r - counter)
(game-over)
(next ?c1 ?c2 - counter)
(previous-colour ?c - colour))
(:functions (colour-penalty)
(colour-cost ?c - colour))

(:action robot-plays
:parameters (?c - colour)
:vars (?cp - colour ?il ?ic ?in - counter)
:precondition (and (current-instant ?ic) (instant-limit ?il) (next ?ic ?in) (turn robot)
(not (previous-colour ?c)) (previous-colour ?cp))
:effect
(and (coloured ?ic ?c) (not (current-instant ?ic))
(not (previous-colour ?cp)) (previous-colour ?c)
(when (= ?il ?ic) (and (turn human) (not (turn robot))
(current-instant one)))
(when (not (= ?il ?ic)) (and (current-instant ?in)))
;;; (increase (colour-penalty) (colour-cost ?c)) COSTE NO UNIFORME, EL PLANIFICADOR NO PODRA EJECUTARLO
(increase (colour-cost ?c) 1))
)
(:action check-human
:parameters (?c - colour)
:vars (?il ?ic ?in - counter ?r - counter)
:precondition (and (current-instant ?ic) (instant-limit ?il) (next ?ic ?in) (turn human)
(coloured ?ic ?c) (current-round ?r))
:effect
(and (not (coloured ?ic ?c)) (not (current-instant ?ic))
(when (and (= ?il ?ic)) (and (round-played ?r) (current-instant one)))
(when (not (= ?il ?ic)) (and (current-instant ?in))))
)
(:action finish-game
:parameters (?rc - counter)
:precondition (and (round-limit ?rc) (round-played ?rc))
:effect (game-over)
)
(:action new-round
:parameters (?rc - counter)
:vars (?rn ?ci - counter)
:precondition (and (round-played ?rc) (current-round ?rc) (next ?rc ?rn) (instant-limit ?ci))
:effect
(and (not (current-round ?rc)) (current-round ?rn) (turn robot)
(not (instant-limit ?ci)) (instant-limit ?rn)))
)
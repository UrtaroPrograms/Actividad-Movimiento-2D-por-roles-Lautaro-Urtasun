extends CharacterBody2D

#Vamos a gestionar todo su movimiento desde los states.
@export var target: CharacterBody2D

func _ready():	#Al inicializar al enemigo, asignamos la variable de objetivo del enemigo a los states correspondientes.
	$EnemyStateMachine/EnemyChase.target = target
	$EnemyStateMachine/EnemyWander.target = target
	$EnemyStateMachine/EnemyPatrolling.target = target

func _physics_process(delta: float):  #Cuando el juego calcula las físicas, el enemigo se encarga de realizar el move_and_slide(), pero los states controlan la dirección.
	move_and_slide()

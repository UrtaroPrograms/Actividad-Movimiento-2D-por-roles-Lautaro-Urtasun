extends CharacterBody2D

#Vamos a gestionar todo su movimiento desde los states.
@export var target: CharacterBody2D

func _ready():
	$EnemyStateMachine/EnemyChase.target = target
	$EnemyStateMachine/EnemyWander.target = target

func _physics_process(delta: float): 
	move_and_slide()

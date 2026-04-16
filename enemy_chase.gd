extends State
class_name EnemyChase

@export var character: CharacterBody2D
@export var target: CharacterBody2D
@export var move_speed:= 50.0

func _enter():
	pass
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):
	var distance = target.global_position - character.global_position
	
	if distance.length() < 200:
		character.velocity = distance.normalized() * move_speed
	else:
		Transitioned.emit(self, "EnemyWander")

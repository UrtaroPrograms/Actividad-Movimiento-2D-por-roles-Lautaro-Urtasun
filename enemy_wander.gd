extends State
class_name EnemyWander

var move_direction : Vector2
var wander_time : float

@export var character: CharacterBody2D
@export var target: CharacterBody2D
@export var move_speed:= 10.0
	
func _enter():
	_randomize_wander()
	print(move_speed)
	print(move_direction)

	
func _exit():
	pass
	
func _randomize_wander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	
func _update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		_randomize_wander()
		
func _physics_update(_delta: float):
	var distance = target.global_position - character.global_position
	
	if (distance.length() <= 200):
		Transitioned.emit(self, "EnemyChase")
	else:
		character.velocity = move_direction * move_speed
	

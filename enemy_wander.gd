extends State
class_name EnemyWander

var move_direction : Vector2
var wander_time : float

@export var character: CharacterBody2D
@export var target: CharacterBody2D
@export var move_speed:= 10.0
@export var max_wander_count = 5.0
var wander_count = 0

func _enter():
	_randomize_wander()
	wander_count = 0

	
func _exit():
	pass
	
func _randomize_wander():
	if wander_count < max_wander_count:
		move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
		wander_time = randf_range(1,3)
		
	else:
		Transitioned.emit(self, "EnemyPatrolling")
	
func _update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		wander_count += 1
		_randomize_wander()
		
func _physics_update(_delta: float):
	var distance = target.global_position - character.global_position
	
	
	if (distance.length() <= 200):
		Transitioned.emit(self, "EnemyChase")
	else:
		character.velocity = move_direction * move_speed
	

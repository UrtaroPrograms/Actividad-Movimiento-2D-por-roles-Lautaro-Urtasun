extends State
class_name Airborne

@export var character: CharacterBody2D
	
func _enter():
	pass
	
func _exit():
	pass
	
func _update(_delta: float):
	if(character.velocity.y > 50):
		character._call_animation("Fall")
	else: if(character.velocity.y < -50):
		character._call_animation("Jump")
	else:
		character._call_animation("MaxHeight")
	
func _physics_update(_delta: float):
	
	if (abs(character.velocity.x) > 400):
		Transitioned.emit(self,"Dashing")
	
	if character.is_on_floor():
		if(character.velocity.x == 0):
			Transitioned.emit(self,"Idle")
		else:
			Transitioned.emit(self,"Walking")

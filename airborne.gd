extends State
class_name Airborne

@export var character: CharacterBody2D
	
func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	if(character.velocity.y > 50):
		character.Call_animation("Fall")
	else: if(character.velocity.y < -50):
		character.Call_animation("Jump")
	else:
		character.Call_animation("MaxHeight")
	
func Physics_Update(_delta: float):
	
	if abs(character.velocity.x) > 400:
		Transitioned.emit(self,"dashing")
	
	if character.is_on_floor():
		if(character.velocity.x == 0):
			Transitioned.emit(self,"Idle")
		else:
			Transitioned.emit(self,"Walking")

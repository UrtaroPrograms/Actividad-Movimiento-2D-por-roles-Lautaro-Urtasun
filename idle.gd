extends State
class_name Idle

@export var character: CharacterBody2D
	
func Enter():
	character.Call_animation("Idle")
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	if (abs(character.velocity.x) > 0):
		Transitioned.emit(self, "Walking")
		
	if (!character.is_on_floor()):
		Transitioned.emit(self, "Airborne")
	
	if (abs(character.velocity.x) > 400):
		Transitioned.emit(self,"Dashing")

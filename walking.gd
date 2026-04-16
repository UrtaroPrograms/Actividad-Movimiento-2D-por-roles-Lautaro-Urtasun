extends State
class_name Walking

@export var character: CharacterBody2D
	
func Enter():
	character.Call_animation("Walk")
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	if (character.velocity.x == 0 && character.is_on_floor()):
		Transitioned.emit(self, "Idle")
		
	if (!character.is_on_floor()):
		Transitioned.emit(self, "Airborne")
	
	if (abs(character.velocity.x) > 400):
		Transitioned.emit(self,"Dashing")

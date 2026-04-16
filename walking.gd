extends State
class_name Walking

@export var character: CharacterBody2D
	
func _enter():
	character._call_animation("Walk")
	
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):
	if (character.velocity.x == 0 && character.is_on_floor()):
		Transitioned.emit(self, "Idle")
		
	if (!character.is_on_floor()):
		Transitioned.emit(self, "Airborne")
	
	if (abs(character.velocity.x) > 400):
		Transitioned.emit(self,"Dashing")

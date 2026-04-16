extends State
class_name Idle

@export var character: CharacterBody2D
	
func _enter():
	character._call_animation("Idle")
	
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):
	if (abs(character.velocity.x) > 0):
		Transitioned.emit(self, "Walking")
		
	if (!character.is_on_floor()):
		Transitioned.emit(self, "Airborne")
	
	if (abs(character.velocity.x) > 400):
		Transitioned.emit(self,"Dashing")

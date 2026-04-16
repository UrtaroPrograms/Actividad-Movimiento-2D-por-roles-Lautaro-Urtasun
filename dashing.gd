extends State
class_name Dashing

@export var character: CharacterBody2D
var isDashing
	
func _enter():
	character._call_animation("Dash")
	isDashing = true
	
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):
	
	if (!isDashing):
		if(character.is_on_floor):
			Transitioned.emit(self,"Recovering")
		else:
			Transitioned.emit(self,"Airborne")


func _on_dash_duration_timeout():
	isDashing = false

extends State
class_name Dashing

@export var character: CharacterBody2D
var isDashing
	
func Enter():
	character.Call_animation("Dash")
	isDashing = true
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	
	if (!isDashing):
		if(character.is_on_floor):
			Transitioned.emit(self,"Recovering")
		else:
			Transitioned.emit(self,"Airborne")


func _on_dash_duration_timeout():
	isDashing = false

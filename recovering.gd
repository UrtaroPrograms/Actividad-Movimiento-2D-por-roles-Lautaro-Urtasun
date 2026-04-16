extends State
class_name Recovering

@export var character: CharacterBody2D
var isRecovering
	
func Enter():
	character.Call_animation("DashRecovery")
	isRecovering = true;
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	if (isRecovering):
		character.velocity.x = 0
	else:
		Transitioned.emit(self, "Idle")


func _on_dash_recovery_timeout():
	isRecovering = false;

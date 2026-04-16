extends State
class_name Recovering

@export var character: CharacterBody2D
var isRecovering
	
func _enter():
	character._call_animation("DashRecovery")
	isRecovering = true;
	
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):
	if (isRecovering):
		character.velocity.x = move_toward(character.velocity.x, 0, 150) #Al terminar el dash, el personaje se detiene gradualmente.
	else:
		Transitioned.emit(self, "Idle")


func _on_dash_recovery_timeout():
	isRecovering = false;

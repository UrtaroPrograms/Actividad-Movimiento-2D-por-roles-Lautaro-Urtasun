extends State
class_name Recovering

@export var character: CharacterBody2D
var isRecovering
	
func _enter():	#Cuando ingresamos al estado de recuperación, le pedimos al AnimatedSprite2D que reproduzca la animación correspondiente (es muy corta, y ni se nota, de todos modos)
	character._call_animation("DashRecovery")
	isRecovering = true; #Como el personaje se está "recuperando" del dash, marcamos la variable como verdadera.
	
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):
	if (isRecovering):	#Comprobamos si sigue en estado de "recuperación" el personaje, de ser así, reducimos su velocidad.
		character.velocity.x = move_toward(character.velocity.x, 0, 150) #Al terminar el dash, el personaje se detiene gradualmente.
	else:
		Transitioned.emit(self, "Idle") #Cuando haya terminado el tiempo de recuperación, pasamos al estado idle


func _on_dash_recovery_timeout(): #Cuando el timer de recuperación termina, cambiamos la variable isRecovering a falsa.
	isRecovering = false;

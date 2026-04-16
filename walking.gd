extends State
class_name Walking

@export var character: CharacterBody2D
	
func _enter():	#Al ingresar al estado llamamos a la animación correspondiente.
	character._call_animation("Walk")
	
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):
	if (character.velocity.x == 0 && character.is_on_floor()): #Si estamos quietos y en el suelo, cambiamos a estar en modo idle
		Transitioned.emit(self, "Idle")
		
	if (!character.is_on_floor()): #Si no estamos en el piso, pasamos al estado aereo
		Transitioned.emit(self, "Airborne")  
	
	if (abs(character.velocity.x) > 400): #Si la velocidad sube mucho, pasamos al estado de dash.
		Transitioned.emit(self,"Dashing")

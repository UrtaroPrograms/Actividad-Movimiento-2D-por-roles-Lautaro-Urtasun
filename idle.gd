extends State
class_name Idle

@export var character: CharacterBody2D
	
func _enter(): #Iniciamos el state y llamamos a la animación correspondiente
	character._call_animation("Idle")
	
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):	#Chequeamos si hay que cambiar a otro state.
	if (abs(character.velocity.x) > 0):	 #Si nos estamos moviendo, cambiamos al state de caminar.
		Transitioned.emit(self, "Walking")
		
	if (!character.is_on_floor()): #Si dejamos de estar en el suelo, pasamos al state aéreo
		Transitioned.emit(self, "Airborne")
	
	if (abs(character.velocity.x) > 400): #Si nos estamos moviendo muy rápido, pasamos al state de dash. Al estar más abajo, toma prioridad por sobre la comparativa que nos hace caminar.
		Transitioned.emit(self,"Dashing")

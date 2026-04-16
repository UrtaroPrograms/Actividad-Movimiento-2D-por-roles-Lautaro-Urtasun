extends State
class_name Airborne

@export var character: CharacterBody2D
	
func _enter():
	pass
	
func _exit():
	pass
	
func _update(_delta: float):
	if(character.velocity.y > 50):	#Si la velocidad en Y es alta y estamos cayendo, pasamos al sprite de caída.
		character._call_animation("Fall")
	else: if(character.velocity.y < -50): #Si la velocidad en Y es alta y estamos subiendo, pasamos al sprite de salto.
		character._call_animation("Jump")
	else:
		character._call_animation("MaxHeight") #Si no cumple ninguna de las dos, entonces la velocidad en Y es relativamente baja, pasamos al sprite de punto máximo del salto
	
func _physics_update(_delta: float):
	
	if (abs(character.velocity.x) > 400): #Si pasamos a movernos muy rápido, pasamos al state de dash.
		Transitioned.emit(self,"Dashing")
	
	if character.is_on_floor():   #Si estamos en el piso, chequeamos si estamos en movimiento o no. Si no no lo estamos, pasamos a idle, si nos estamos moviendo, al state de caminar.
		if(character.velocity.x == 0):
			Transitioned.emit(self,"Idle")
		else:
			Transitioned.emit(self,"Walking")

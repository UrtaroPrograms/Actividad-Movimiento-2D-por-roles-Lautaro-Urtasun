extends State
class_name Dashing

@export var character: CharacterBody2D
var isDashing
	
func _enter(): #Llamamos a la animación correspondiente y encendemos la variable de que estamos dasheando.
	character._call_animation("Dash")
	isDashing = true
	
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float):
	
	if (!isDashing):  #Solo si no estamos dasheando, chequeamos nuestra posición para cambiar de estado.
		if(character.is_on_floor): #si estamos en el piso, pasamos al estado de recuperación
			Transitioned.emit(self,"Recovering")
		else: #Si no estamos en el piso, pasamos al estado aéreo.
			Transitioned.emit(self,"Airborne")


func _on_dash_duration_timeout(): #Cuando el timer de duración de dash indique que acabó, tornamos falsa la variante de dasheo.
	isDashing = false

extends State
class_name EnemyChase

@export var character: CharacterBody2D	#Tomamos una variable para determinar que enemigo estamos usado.
@export var target: CharacterBody2D	 #Inicializamos una variable para determinar a quien debemos perseguir.
@export var move_speed:= 50.0

func _enter():
	pass
func _exit():
	pass
	
func _update(_delta: float):
	pass
	
func _physics_update(_delta: float): 
	var distance = target.global_position - character.global_position #Determinamos la distancia entre el jugador y el enemigo.
	
	if distance.length() < 200: #Si la distancia es menor a 200, nos acercamos al jugador.
		character.velocity = distance.normalized() * move_speed
	else: #Si la distancia es mayor a 200, entonces dejamos de perseguir y pasamos al estado de movimiento aleatorio.
		Transitioned.emit(self, "EnemyWander")

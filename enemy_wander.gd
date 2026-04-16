extends State
class_name EnemyWander

var move_direction : Vector2
var wander_time : float

@export var character: CharacterBody2D	#Tomamos una variable para determinar que enemigo estamos usado.
@export var target: CharacterBody2D	 #Inicializamos una variable para determinar a quien debemos perseguir.
@export var move_speed:= 10.0
@export var max_wander_count = 5.0 #Creamos una variable que nos permite determinar la máxima cantidad de movimientos aleatorios del enemigo.
var wander_count = 0  #Variable que contiene la cantidad de movimientos aleatorios ya realizados.

func _enter(): #Inicializamos, con 0 movimientos hechos y llamando a la función para empezar a moverse.
	_randomize_wander() 
	wander_count = 0

	
func _exit():
	pass
	
func _randomize_wander(): #Si no llegamos al máximo de movimientos, entonces tomamos una dirección aleatoria y un tiempo aleatorio para movernos en ella.
	if wander_count < max_wander_count:
		move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
		wander_time = randf_range(1,3)
		
	else: #Si hemos alcanzando el número máximo de movimientos, volvemos a patrullar.
		Transitioned.emit(self, "EnemyPatrolling")
	
func _update(delta: float): #Calculamos si no se ha terminado el tiempo de movimiento, si no lo ha hecho, lo reducimos. Si se terminó, consideramos al movimiento terminado y llamamos la función para elegir otro.
	if wander_time > 0:
		wander_time -= delta
	
	else:
		wander_count += 1
		_randomize_wander()
		
func _physics_update(_delta: float):  #Tomamos la distancia entre el jugador y el enemigo. Si es de menos de 200, el enemigo empieza a perseguir.
	var distance = target.global_position - character.global_position
	
	
	if (distance.length() <= 200):
		Transitioned.emit(self, "EnemyChase")
	else:
		character.velocity = move_direction * move_speed
	

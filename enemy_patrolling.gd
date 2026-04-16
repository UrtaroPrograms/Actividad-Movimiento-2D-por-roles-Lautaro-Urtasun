extends State
class_name EnemyPatrolling

@export var waypoint_group_name : String #Tomamos un String. Este String es el nombre del grupo de los waypoints.

@export var character: CharacterBody2D	#Tomamos una variable para determinar que enemigo estamos usado.
@export var target: CharacterBody2D	 #Inicializamos una variable para determinar a quien debemos perseguir.
@export var move_speed:= 40.0

var waypoints: Array	#Armamos un array para sostener los puntos de ruta, este los contiene todos, incluso los que no hayamos pasado.
var waypoints_in_use: Array	#Armamos un array solo para los puntos de ruta que vamos a estar utilizando.
var current_waypoint: Marker2D	#Usamos un marker2D para indicar adonde estamos llendo ahora.

var direction: Vector2 = Vector2.ZERO
var previous_position_x : float	#Tomamos un float para guardar la posición

func _enter():
	waypoints = get_tree().get_nodes_in_group(waypoint_group_name)	#Agarramos todos los objetos de la escena que estén dentro del grupo que nombramos en el String
	_get_waypoints()
	_get_next_waypoint()
	previous_position_x = character.global_position.x	#Inicialiamos la posición actual como la posición previa, a ser comparada después.
	$PatrolThinkTimer.start() #Inicializamos  el temporizador de pensamiento al patrullar
	
func _exit():
	$PatrolThinkTimer.stop() #Detenemos el temporizador
	
func _update(delta: float): 
	var distance = target.global_position - character.global_position   #Calculamos la distancia entre el jugador y el enemigo.
	
	if (distance.length() <= 200):  #si la distancia es de menos de 200, iniciamos la persecución.
		Transitioned.emit(self, "EnemyChase")
		
func _physics_update(_delta: float):
	if (character.global_position).distance_to(current_waypoint.position) < 10: #Si estamos muy cerca del punto de patrulla, lo consideramos tocado y elegimos uno nuevo.
		_get_next_waypoint()
	
func _get_waypoints():	#Duplicamos el array y lo desordenamos para tener el conjunto de puntos para patrullar.
	waypoints_in_use = waypoints.duplicate()
	waypoints_in_use.shuffle()
	

func _get_next_waypoint(): 
	if waypoints_in_use.is_empty(): #Verificamos que no esté vacío el array de puntos de patrulla, si lo está, tomamos otro.
		_get_waypoints()
	
	current_waypoint = waypoints_in_use.pop_front() #Sacamos el primer punto del array y lo tomamos como nuevo objetivo.
	direction = current_waypoint.global_position - character.global_position	#Calculamos la dirección hacia el nuevo objetivo y empezamos a mover al enemigo.
	character.velocity = direction.normalized() * move_speed
	


func _on_patrol_think_timer_timeout():  #Cada 3 segundos, se activa un método de "pensamiento", el cual se encarga de recalcular la trayectoria del enemigo para asegurarse de que esté en camino a un punto de patrulla.
	direction = current_waypoint.global_position - character.global_position	#Recalculamos la dirección y aplicamos de nuevo el movimiento
	character.velocity = direction.normalized() * move_speed
		
	var actual_movement_speed  = character.global_position.x - previous_position_x #Calculamos la diferencia entre la posición actual del enemigo y la anterior que habíamos guardado.
	if (abs(actual_movement_speed) < 0.1):   #Si la velocidad horizontal del enemigo se detiene por completo, es porque se ha chocado con un muro. Como consecuencia, aumentamos su velocidad en y para que termine de subirlo y no se quede atascado.
		character.velocity.y = -300
	previous_position_x = character.global_position.x #Al final de todo, actualizamos la posición vieja con la de ahora.

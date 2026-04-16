extends State
class_name EnemyPatrolling

@export var waypoint_group_name : String

@export var character: CharacterBody2D
@export var target: CharacterBody2D
@export var move_speed:= 40.0

var waypoints: Array
var waypoints_in_use: Array
var current_waypoint: Marker2D

var direction: Vector2 = Vector2.ZERO
var previous_position : float

func _enter():
	waypoints = get_tree().get_nodes_in_group(waypoint_group_name)
	_get_waypoints()
	_get_next_waypoint()
	previous_position = character.global_position.x
	$PatrolThinkTimer.start() #Inicializamos  el temporizador de pensamiento al patrullar
	
func _exit():
	$PatrolThinkTimer.stop() #Detenemos el temporizador
	
func _update(delta: float):
	var distance = target.global_position - character.global_position
	
	if (distance.length() <= 200):
		Transitioned.emit(self, "EnemyChase")
		
func _physics_update(_delta: float):
	if (character.global_position).distance_to(current_waypoint.position) < 10:
		_get_next_waypoint()
	
func _get_waypoints():
	waypoints_in_use = waypoints.duplicate()
	waypoints_in_use.shuffle()
	

func _get_next_waypoint():
	if waypoints_in_use.is_empty():
		_get_waypoints()
	
	current_waypoint = waypoints_in_use.pop_front()
	direction = current_waypoint.global_position - character.global_position
	character.velocity = direction.normalized() * move_speed
	


func _on_patrol_think_timer_timeout():  #Cada 3 segundos, se activa un método de "pensamiento", el cual se encarga de recalcular la trayectoria del enemigo para asegurarse de que esté en camino a un punto de patrulla.
	direction = current_waypoint.global_position - character.global_position	#Recalculamos la dirección y aplicamos de nuevo el movimiento
	character.velocity = direction.normalized() * move_speed
		
	var actual_movement_speed  = character.global_position.x - previous_position
	if (abs(actual_movement_speed) < 0.1):   #Si la velocidad horizontal del enemigo se detiene por completo, es porque se ha chocado con un muro. Como consecuencia, aumentamos su velocidad en y para que termine de subirlo y no se quede atascado.
		character.velocity.y = -300
	previous_position = character.global_position.x

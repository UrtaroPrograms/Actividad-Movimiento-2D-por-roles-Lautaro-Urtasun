extends Node

@export var initial_state: State

var current_state : State
var states : Dictionary = {} #Armamos un listado de States, los cuales la state machine luego llamará.

func _ready():
	for child in get_children():  #Chequeamos los nodos hijos del State Machine. Si son States, los añadimos.
		if child is State:
			states[child.name.to_lower()] = child #Pasamos los nombres de los States a minúscula como seguridad para no tener que lidiar con la capitalización
			child.Transitioned.connect   
			
	if initial_state:	#Si Initial state está definido, entonces lo inicializamos.
		current_state = initial_state
		current_state._enter()
			
func _process(delta):
	if current_state:
		current_state._update(delta) #Cada frame, corremos el método update del State
	
func _physics_process(delta):
	if current_state:
		current_state._physics_update(delta) #Cada vez que se calculan las físicas, corremos el método physics_update del State

func _on_child_transition(state, new_state_name): #Al recibir la señal de transición de un State, realizamos checks antes de cambiar.
	if state != current_state: #Si el state que nos dijo que cambiemos no es el actual, lo ignoramos.
		return
	
	var new_state = states.get(new_state_name.to_lower()) #Inicializamos una nueva variable, con el nombre del state nuevo en minúscula. Si no hay state nuevo, termina el método.
	if !new_state:
		return
	
	if current_state: #Salimos del state actual. Como medida de precaución, primero verificamos que haya un state actual.
		current_state._exit()
	
	new_state._enter() #Inicializamos el nuevo State y lo tomamos como state actual.
	current_state = new_state

extends Node

@export var initial_state: State

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect
			
	if initial_state:			#Si Initial state está definido, entonces lo inicializamos.
		current_state = initial_state
		current_state._enter()
			
func _process(delta):
	if current_state:
		current_state._update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state._physics_update(delta)

func _on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state._exit()
	
	new_state._enter()
	current_state = new_state

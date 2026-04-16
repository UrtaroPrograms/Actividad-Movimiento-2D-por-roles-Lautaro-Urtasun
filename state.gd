extends Node
class_name State

signal Transitioned #Los estados tienen, por defecto, una señal que le permite al state machine saber si es momento de cambiar entre uno u otro.

func _enter(): #El método _enter es el equivalente a _ready, se ejecuta al iniciar el state
	pass
	
func _exit(): #El metodo _exit se ejecuta cuando vamos a cambiar del estado actual a otro.
	pass
	
func _update(_delta: float): #update es el equivalente a _process
	pass
	
func _physics_update(_delta: float): #physics_update es el equivalente a _physics_process
	pass

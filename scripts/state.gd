class_name State extends Node

#Stores a reference to the player that this State belongs to
static var player : Player

func _ready():
	pass # Replace with function body.

#What happens when the player enters this state
func Enter() -> void:
	pass

#What happens when the player enters this state	
func Exit() -> void:
	pass

#What happens during the _physics_process update in this state
func Process(_delta : float) -> State:
	return null

func Physics(_delta : float) -> State:
	return null

#What happens with the input events in this State
func HandleInput( _event : InputEvent) -> State:
	return null

class_name State_Idle extends State

@onready var walk = $"../Walk"

#What happens when the player enters this state
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

#What happens when the player enters this state	
func Exit() -> void:
	pass

#What happens during the _physics_process update in this state
func Process(_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

#What happens with the input events in this State
func HandleInput( _event : InputEvent) -> State:
	return null

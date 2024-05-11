class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $PlayerSprite
@onready var state_machine : PlayerStateMachine = $StateMachine
signal DirectionChanged(new_direction : Vector2)

func _ready():
	state_machine.Initialize(self)
	pass

func _process(_delta):
	
	direction = Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	).normalized()
	pass


func _physics_process(_delta):
	move_and_slide()

func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false

	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation(state : String) -> void:
	animation_player.play(state + "_" + AnimationDirection())	
	pass

func AnimationDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"	
	else:
		return "side"	
	

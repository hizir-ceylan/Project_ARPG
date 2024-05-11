class_name State_Attack extends State

var attacking : bool = false

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_attack : AnimationPlayer = $"../../PlayerSprite/AttackEffectsSprite/AnimationPlayer"
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var damage_box : DamageBox = %AttackDamageBox
@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed : float = 5

#What happens when the player enters this state
func Enter() -> void:
	player.UpdateAnimation("attack")
	animation_attack.play("attack_" + player.AnimationDirection())
	animation_player.animation_finished.connect(EndAttack)
	audio_stream_player_2d.stream = attack_sound
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player_2d.play()
	attacking = true
	await get_tree().create_timer(0.075).timeout
	damage_box.monitoring = true
	pass

#What happens when the player enters this state	
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	damage_box.monitoring = false
	pass

#What happens during the _physics_process update in this state
func Process(_delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta 
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk			
	return null

#What happens with the input events in this State
func HandleInput( _event : InputEvent) -> State:
	return null

func EndAttack(_newAnimationName : String) -> void:
	attacking = false


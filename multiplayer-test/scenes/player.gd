extends CharacterBody2D

const SPEED := 300.0
@onready var sprite = $AnimatedSprite2D
var input_direction: Vector2 = Vector2.ZERO


func set_animation(animation_name: String) -> void: 
	if sprite.animation != animation_name:
		sprite.play(animation_name)


func _ready() -> void:
	if multiplayer.is_server():
		set_physics_process(true)
	else:
		set_physics_process(false)


func _process(_delta: float) -> void:
	
	if multiplayer.is_server():
		return
	var dir = Input.get_vector("left", "right", "up", "down")
	rpc_id(1, "send_input", dir)


func _physics_process(_delta: float) -> void:
	if !multiplayer.is_server():
		return 
	if input_direction != Vector2.ZERO:
		velocity = SPEED * input_direction
		move_and_slide()
		rpc("sync_position", global_position)
		set_animation('walk')
	else:
		velocity = Vector2.ZERO
		set_animation("idle")


@rpc("any_peer")
func send_input(dir: Vector2):
	if !multiplayer.is_server():
		return
	input_direction = dir


@rpc("authority")
func sync_position(pos: Vector2):
	global_position = pos

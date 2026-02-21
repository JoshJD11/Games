extends CharacterBody2D

const SPEED := 300.0
@onready var sprite = $AnimatedSprite2D
var input_direction: Vector2 = Vector2.ZERO


func _set_animation(name: String) -> void: # I wont use this for now
	if sprite.animation != name:
		sprite.play(name)


func _ready() -> void:
	if multiplayer.is_server():
		set_physics_process(true)
	else:
		set_physics_process(false)


func _process(delta: float) -> void:
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
	else:
		velocity = Vector2.ZERO


@rpc("any_peer")
func send_input(dir: Vector2):
	if !multiplayer.is_server():
		return
	input_direction = dir


@rpc("authority")
func sync_position(pos: Vector2):
	global_position = pos

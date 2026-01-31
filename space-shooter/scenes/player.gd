extends CharacterBody2D

@export var speed := 500
var can_shoot: bool = true
signal laser(pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("player")
	var width = get_viewport().get_visible_rect().size[0]
	var height = get_viewport().get_visible_rect().size[1]
	position = Vector2(width/2, height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide() # Takes the variable velocity and adds delta automatically, also, respect collisions
	# get_node("PlayerImage").rotation += 0.1 * delta
	# $PlayerImage.rotation += 0.1 * delta
	
	# shoot input
	if Input.is_action_just_pressed("shoot") and can_shoot:
		laser.emit($LaserStartPosition.global_position)
		can_shoot = false
		$LaserCoolDown.start()

func _on_laser_cool_down_timeout() -> void:
	can_shoot = true
	

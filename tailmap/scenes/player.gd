extends CharacterBody2D

@export var speed := 300.0
@onready var sprite: AnimatedSprite2D = $PlayerSprite
var bullet_scene: PackedScene = load('res://scenes/paint_ball.tscn') 

func shoot():
	var dir = (get_global_mouse_position() - global_position).normalized()
	if dir == Vector2.ZERO:
		return
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = dir
	get_tree().current_scene.add_child(bullet)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size = get_viewport().get_visible_rect().size
	position = Vector2(size.x/2, size.y/2)
	add_to_group('player')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	if direction:
		sprite.play('front-walk')
	else:
		sprite.play("front-idle")
		
	if Input.is_action_just_pressed("shoot"):
		shoot()

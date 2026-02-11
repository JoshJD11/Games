extends CharacterBody2D

@export var speed := 300.0
@onready var sprite: AnimatedSprite2D = $PlayerSprite
var last_color := 'white' # Maybe should have an intuitive name
@export var actual_color := 'red'
var bullet_scene: PackedScene = load('res://scenes/paint_ball.tscn') 


func shoot():
	var dir = (get_global_mouse_position() - global_position).normalized()
	if dir == Vector2.ZERO:
		return
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = dir
	bullet.color = last_color # careful here
	ColorUtils.change_color(bullet.get_node('PaintBallImage'), last_color)
	get_tree().current_scene.get_node('Shoots').add_child(bullet)
	

func _ready() -> void:
	var size = get_viewport().get_visible_rect().size
	position = Vector2(size.x/2, size.y/2)
	add_to_group('player')


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
		
	if last_color != actual_color:
		print('diff colors')
		ColorUtils.change_color(sprite, actual_color)
		last_color = actual_color

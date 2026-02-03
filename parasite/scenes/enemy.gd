extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $EnemySprite
@export var speed := 120.0 
@onready var player

func play_anim(animation_name: String):
	if sprite.animation != animation_name:
		sprite.play(animation_name)

func _ready() -> void: # I have to check out if the enemy spawn well
	player = get_tree().get_first_node_in_group("player") 
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	
	var width = get_viewport().get_visible_rect().size[0]
	var height = get_viewport().get_visible_rect().size[1]
	
	if rng.randi_range(0, 1) == 1:
		position = Vector2(width + 50, rng.randf_range(height/2, height))
	else:
		position = Vector2(-50, rng.randf_range(height/2, height))


func _physics_process(delta: float) -> void:
	if player == null:
		return
		
	var direction = (player.global_position - global_position).normalized()
	position += direction * speed * delta
	
	if direction.x < 0:
		play_anim('walking-left')
	elif direction.x > 0:
		play_anim('walking-right')
	
	

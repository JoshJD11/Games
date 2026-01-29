extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	
	# randomize speed
	$StarAnimation.speed_scale = rng.randf_range(0, 2)
	
	# randomize size
	var size = rng.randf_range(0.5, 2)
	$StarAnimation.scale = Vector2(size, size)
	
	# randomize position
	var width = get_viewport().get_visible_rect().size[0]
	var height = get_viewport().get_visible_rect().size[1]
	global_position = Vector2(rng.randi_range(0, width), rng.randi_range(0, height))
	

extends Area2D

signal collision

var speed: int
var rotation_speed: int
var direction_x: float

func _ready():
	
	var rng := RandomNumberGenerator.new() 
	
	var random_image_number = rng.randi_range(1, 8)
	var path: String = "res://graphics/PNG/Meteors/" + str(random_image_number) + ".png"
	$MeteorImage.texture = load(path)
	
	speed = rng.randi_range(200, 500)
	rotation_speed = rng.randi_range(40, 100)
	direction_x = rng.randf_range(-1, 1)
	
	var width = get_viewport().get_visible_rect().size[0] 
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)

	
func _process(delta):
	position += Vector2(direction_x, 1.0) * speed * delta
	rotation_degrees += rotation_speed * delta
	

func _on_body_entered(_body: Node2D) -> void:
	collision.emit()
	
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("laser"):
		queue_free()
		area.queue_free()

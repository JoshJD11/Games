extends Node2D

signal health_update
var speed := 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('pill created')
	var rng := RandomNumberGenerator.new()
	var width = get_viewport().get_visible_rect().size[0]
	position = Vector2(rng.randi_range(20, width - 20), -50)
	scale = Vector2(2, 2)
	
	
func _process(delta: float) -> void:
	position.y += 1 * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		health_update.emit()
		queue_free()

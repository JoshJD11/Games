extends Area2D

@export var speed := 600.0

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(1, 1), 0.1).from(Vector2(0, 0))


func _process(delta: float) -> void:
	position.x += speed * delta


func _on_body_entered(body: Node2D) -> void: #Temporal
	if not body.is_in_group("player"):
		queue_free()
		body.queue_free()

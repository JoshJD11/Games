extends Area2D

@export var speed := 600.0
var direction := 1

func set_direction(dir: String) -> void:
	if dir == "left":
		direction = -1
		$Sprite2D.flip_h = true
	else:
		direction = 1
		$Sprite2D.flip_h = false
	

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(1, 1), 0.1).from(Vector2(0, 0))


func _process(delta: float) -> void:
	position.x += speed * direction * delta


func _on_body_entered(body: Node2D) -> void: #Temporal
	queue_free()
	body.queue_free()

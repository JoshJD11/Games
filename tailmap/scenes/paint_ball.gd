extends Area2D

@export var speed := 350.0
var color := 'red'
var direction = Vector2.ZERO

func _ready() -> void:
	pass

func _process(delta):
	position += direction * speed * delta
	

func _on_body_entered(body: Node2D) -> void: # I will have to check who shooted, careful with this
	print('collision')
	if not body.is_in_group('player'):
		if body.is_in_group('enemy'):
			body.actual_color = color
		queue_free()

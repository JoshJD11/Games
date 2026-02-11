extends Area2D

@export var speed := 350.0
var direction = Vector2.ZERO

func _ready() -> void:
	pass 

func _process(delta):
	position += direction * speed * delta
	

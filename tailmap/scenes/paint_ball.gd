extends Area2D

@export var speed := 350.0
var color := 'red'
var direction = Vector2.ZERO
var owner_player

func _ready() -> void:
	pass

func _process(delta):
	position += direction * speed * delta
	

func _on_body_entered(body: Node2D) -> void: # I will have to check who shooted, careful with this
	if body != owner_player:
		if body.is_in_group('players'):
			body.actual_color = color
			get_tree().call_group("level", "check_game_state") # This is to check if the game finished
		queue_free()

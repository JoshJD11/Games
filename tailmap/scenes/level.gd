extends Node2D

var game_over_scene: PackedScene = load('res://scenes/game_over.tscn')

func check_game_state() -> void: # This can be temporal
	var players = get_tree().get_nodes_in_group("players")
	var color = players[0].actual_color
	
	for i in range(1, players.size()):
		if players[i].actual_color != color:
			return 
	get_tree().call_deferred("change_scene_to_packed", game_over_scene)


func _ready() -> void:
	add_to_group('level')


func _process(_delta: float) -> void:
	pass

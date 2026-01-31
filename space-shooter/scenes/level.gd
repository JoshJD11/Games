extends Node2D

var health := 3

# 1. load the scene
var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var pill_scene: PackedScene = load('res://scenes/pill.tscn')


func _ready() -> void:
	get_tree().call_group('ui', 'set_health', health)


func _on_meteor_timer_timeout() -> void:
	# 2. create an instance
	var meteor = meteor_scene.instantiate()
	
	# 3. attach the node to the scene tree
	$Meteors.add_child(meteor)
	
	meteor.connect("collision", _on_meteor_collision)


func _on_meteor_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		call_deferred("_go_to_game_over")


func _go_to_game_over():
	get_tree().change_scene_to_file('res://scenes/game_over.tscn')

func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos


func _on_pill_timer_timeout() -> void:
	print("pill time out")
	var pill = pill_scene.instantiate()
	$Pills.add_child(pill)
	pill.connect("health_update", _on_pill_collision)
	
	
func _on_pill_collision():
	health += 1
	get_tree().call_group('ui', 'set_health', health)
	

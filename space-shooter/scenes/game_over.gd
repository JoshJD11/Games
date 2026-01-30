extends Control

var level_scene: PackedScene = load("res://scenes/level.tscn")


func _ready() -> void:
	$CenterContainer/VBoxContainer/Label2.text = $CenterContainer/VBoxContainer/Label2.text + ' ' + str(Global.score)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("playagain"):
		get_tree().change_scene_to_packed(level_scene)

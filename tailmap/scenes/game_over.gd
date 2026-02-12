extends Control

var level_scene: PackedScene = load('res://scenes/level.tscn')


func _ready() -> void:
	pass 


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_packed(level_scene)

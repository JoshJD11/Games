extends Node2D

var attack_scene: PackedScene = load('res://scenes/attack.tscn')
@onready var player = $Player

func _ready() -> void:
	player.connect("attack", _on_attack) 

func _on_attack(pos):
	var attack = attack_scene.instantiate()
	$Attacks.add_child(attack)
	attack.position = pos
	

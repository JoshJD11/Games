extends Node2D

var attack_scene: PackedScene = load('res://scenes/attack.tscn')
var enemy_scene: PackedScene = load('res://scenes/enemy.tscn')
@onready var player = $Player

func _ready() -> void:
	player.connect("attack", _on_attack) 

func _on_attack(pos, dir):
	var attack = attack_scene.instantiate()
	$Attacks.add_child(attack)
	attack.position = pos
	attack.set_direction(dir)


func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	$Enemies.add_child(enemy)

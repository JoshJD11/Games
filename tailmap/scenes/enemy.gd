extends CharacterBody2D

var last_color := 'white'
@export var actual_color := 'red'
@export var speed := 300.0
@onready var sprite: AnimatedSprite2D = $EnemySprite


func _ready() -> void:
	add_to_group('enemy')
	

func _process(_delta: float) -> void:
	if last_color != actual_color:
		print('diff colors')
		ColorUtils.change_color(sprite, actual_color)
		last_color = actual_color

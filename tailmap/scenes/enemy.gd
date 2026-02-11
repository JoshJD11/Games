extends CharacterBody2D


var last_color := 'white'
@export var actual_color := 'red'
@export var speed := 300.0
@onready var sprite: AnimatedSprite2D = $EnemySprite
@onready var agent: NavigationAgent2D = $NavigationAgent2D


func get_closest_target() -> Node2D:
	var closest = null
	var min_dist := INF

	for p in get_tree().get_nodes_in_group("players"):
		if p == self:
			continue
			
		var d = global_position.distance_to(p.global_position)
		if d < min_dist:
			min_dist = d
			closest = p

	return closest


func chase_target():
	#print('chase started') 
	var target = get_closest_target()
	if target:
		agent.target_position = target.global_position


func _physics_process(delta):
	if agent.is_navigation_finished():
		velocity = Vector2.ZERO
		return


	var next_pos = agent.get_next_path_position()
	var dir = (next_pos - global_position).normalized()
	velocity = dir * speed
	move_and_slide()


func _ready() -> void:
	add_to_group('players')


func _process(_delta: float) -> void:
	if last_color != actual_color:
		ColorUtils.change_color(sprite, actual_color)
		last_color = actual_color


func _on_repath_timer_timeout() -> void:
	chase_target()

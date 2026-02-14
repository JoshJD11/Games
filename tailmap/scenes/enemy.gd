extends CharacterBody2D


var last_color := 'white'
@export var actual_color := 'red'
@export var speed := 300.0
@onready var sprite: AnimatedSprite2D = $EnemySprite
@onready var agent: NavigationAgent2D = $NavigationAgent2D
var bullet_scene: PackedScene = load('res://scenes/paint_ball.tscn')
var cant_enemies_in_range := 0
var target = null


func shoot():
	get_closest_target()
	if not target: return
	
	var dir = (target.global_position - global_position).normalized()
	if dir == Vector2.ZERO: return
	
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = dir
	bullet.color = last_color
	bullet.owner_player = self
	
	ColorUtils.change_color(bullet.get_node("PaintBallImage"),last_color)
	get_tree().current_scene.get_node("Shoots").add_child(bullet)



func get_closest_target() -> void:
	var closest = null
	var min_dist := INF

	for p in get_tree().get_nodes_in_group("players"):
		if p == self or p.actual_color == actual_color:
			continue
			
		var d = global_position.distance_to(p.global_position)
		if d < min_dist:
			min_dist = d
			closest = p

	target = closest


func chase_target():
	#print('chase started') 
	get_closest_target()
	if target:
		agent.target_position = target.global_position


func _physics_process(_delta):
	if agent.is_navigation_finished():
		velocity = Vector2.ZERO
		GeneralUtils.set_animation(sprite, 'idle-front')
		return

	GeneralUtils.set_animation(sprite, 'walk-front')

	var next_pos = agent.get_next_path_position()
	var dir = (next_pos - global_position).normalized()
	velocity = dir * speed
	move_and_slide()


func _ready() -> void:
	$AttackTimer.start()
	add_to_group('players')


func _process(_delta: float) -> void:
	if last_color != actual_color:
		ColorUtils.change_color(sprite, actual_color)
		last_color = actual_color


func _on_repath_timer_timeout() -> void:
	chase_target()


func _on_attack_range_body_entered(_body: Node2D) -> void:
	cant_enemies_in_range += 1


func _on_attack_range_body_exited(_body: Node2D) -> void:
	cant_enemies_in_range -= 1


func _on_attack_timer_timeout() -> void:
	if cant_enemies_in_range > 0:
		shoot()
		$AttackTimer.start()

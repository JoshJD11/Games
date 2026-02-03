extends CharacterBody2D

@export var speed := 300.0
@onready var sprite: AnimatedSprite2D = $PlayerSprite
signal attack(pos, dir)

var attacking := false
var facing := 'right'

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	if direction.x > 0:
		facing = 'right'
	elif direction.x < 0:
		facing = 'left'

	if Input.is_action_just_pressed("Attack") and not attacking:
		attacking = true
		sprite.play("attack-" + facing)
		await sprite.animation_finished
		if facing == "right":
			attack.emit($AttackRightStartPosition.global_position, facing)
		else:
			attack.emit($AttackLeftStartPosition.global_position, facing)
		attacking = false
		return

	if not attacking:
		if direction != Vector2.ZERO:
			sprite.play("walking-" + facing)
		else:
			sprite.play("static-" + facing)

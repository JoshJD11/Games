extends CharacterBody2D

@export var speed := 300.0
@onready var sprite: AnimatedSprite2D = $PlayerSprite
signal attack(pos)

var attacking := false

func _ready() -> void:
	add_to_group("player")

func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()

	if Input.is_action_just_pressed("Attack") and not attacking:
		attacking = true
		sprite.play("attack")
		await sprite.animation_finished
		attack.emit($AttackStartPosition.global_position)
		attacking = false
		return

	if not attacking:
		if direction != Vector2.ZERO and sprite.animation != "walking":
			sprite.play("walking")
		elif direction == Vector2.ZERO and sprite.animation != "static":
			sprite.play("static")

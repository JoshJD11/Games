extends Object
class_name GeneralUtils

static func set_animation(sprite: AnimatedSprite2D, animation_name: String):
	if sprite.animation != animation_name:
		sprite.play(animation_name)

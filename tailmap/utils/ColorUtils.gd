extends Object
class_name ColorUtils

static func change_color(sprite: CanvasItem, color: String):
	match color:
		"red":
			sprite.modulate = Color.RED
		"blue":
			sprite.modulate = Color.BLUE
		"green":
			sprite.modulate = Color.GREEN
		"cyan":
			sprite.modulate = Color.CYAN
		"rose":
			sprite.modulate = Color(1.0, 0.4, 0.6) # rosa
		"purple":
			sprite.modulate = Color.PURPLE
		"yellow":
			sprite.modulate = Color.YELLOW
		"orange":
			sprite.modulate = Color.ORANGE
		_:
			pass

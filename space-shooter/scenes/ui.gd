extends CanvasLayer

static var health_image = load('res://graphics/PNG/UI/playerLife2_red.png')
var time_elapsed := 0

func set_health(health):
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	for i in health:
		var life = TextureRect.new()
		life.texture = health_image
		life.stretch_mode = TextureRect.STRETCH_KEEP
		$MarginContainer2/HBoxContainer.add_child(life)


func _on_timer_timeout() -> void:
	time_elapsed += 1
	$MarginContainer/Label.text = str(time_elapsed)
	Global.score = time_elapsed

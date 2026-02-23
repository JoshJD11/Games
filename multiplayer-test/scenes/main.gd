extends Node

@onready var address = $UI/BoxContainer/VBoxContainer/LineEdit.text

func _ready() -> void:
	
	print("Server feature: ", OS.has_feature("server"))
	
	if OS.has_feature("server"):
		$ServerManager.create_server()
	
	else:
		$UI.show()


func _on_join_pressed() -> void:
	$ServerManager.create_client(address)
	$UI.hide()
	$Room/Level.show()

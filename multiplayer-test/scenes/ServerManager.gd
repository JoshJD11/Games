class_name ServerManager
extends Node

@export var Player: PackedScene
@export var max_clients: int = 10
@export var port: int = 7778 # Be careful with the port
@export var main_scene: Node
var peer = ENetMultiplayerPeer.new()


func create_server(_port: int = port):
	print("Intento de crear servidor en el puerto: ", _port)
	var error = peer.create_server(_port, max_clients)
	print("Error: ", error)
	
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(on_peer_connected)
	multiplayer.peer_disconnected.connect(on_peer_disconnected)
	
	print("Soy servidor? ", multiplayer.is_server())
	print("ID servidor: ", multiplayer.get_unique_id())
	

func create_client(address: String):
	var error = peer.create_client(address, port)
	print("Resultado create_client:", error)
	print("Error string:", error_string(error))
	multiplayer.multiplayer_peer = peer
	
	multiplayer.connected_to_server.connect(_on_connected)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	

func _on_connected():
	print("✅ CLIENTE: Conectado correctamente al servidor")
	print("Mi ID es:", multiplayer.get_unique_id())

func _on_connection_failed():
	print("❌ CLIENTE: Falló la conexión: ")
	if multiplayer.multiplayer_peer:
		print("Estado final:", multiplayer.multiplayer_peer.get_connection_status())

func _on_server_disconnected():
	print("⚠️ CLIENTE: Servidor desconectado")
	

func on_peer_connected(id):
	print("debug")
	if !multiplayer.is_server():
		return
	print("Jugador conectado: ", str(id))
	var player = Player.instantiate()
	player.name = str(id)
	player.set_multiplayer_authority(id) # necessary?
	main_scene.add_child(player, true)


func on_peer_disconnected(id):
	if main_scene.has_node(str(id)):
		main_scene.get_node(str(id)).queue_free()
	

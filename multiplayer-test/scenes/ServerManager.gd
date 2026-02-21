class_name ServerManager
extends Node

@export var Player: PackedScene
@export var max_clients: int = 10
@export var port: int = 7777 # Be careful with the port
@export var main_scene: Node
var peer = ENetMultiplayerPeer.new()


func create_server(_port: int = port):
	peer.create_server(_port, max_clients)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(on_peer_connected)
	multiplayer.peer_disconnected.connect(on_peer_disconnected)
	print("Server created at port: ", _port)
	

func create_client(address: String):
	peer.create_client(address, port)
	multiplayer.multiplayer_peer = peer
	print("Connecting to server")


func on_peer_connected(id):
	if !multiplayer.is_server():
		return
	print("Player connected: ", id)
	var player = Player.instantiate()
	player.name = id
	main_scene.add_child(player, true)


func on_peer_disconnected(id):
	if main_scene.has_node(str(id)):
		main_scene.get_node(str(id)).queue_free()
	

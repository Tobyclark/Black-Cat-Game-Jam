class_name MapManager
extends Node2D

const SCROLL_SPEED: int = 15
const MAP_NODE = preload("res://scenes/map_node.tscn")
const MAP_CONNECTION = preload("res://scenes/node_connection.tscn")
const FLOORS = 15
const WIDTH = 4

@onready var visuals = $Visuals
@onready var connections = $Visuals/Connections
@onready var nodes = $Visuals/Nodes
@onready var camera_2d = $Camera2D
@onready var map_generator = $MapGenerator

var map_data: Array[MapNode] = []
var current_floor: int = 0
var last_node: MapNode = null
var camera_edge_y: float
var boss_node_position: Vector2 = Vector2.ZERO

func _ready():
	camera_edge_y = MapGenerator.Y_DIST * (FLOORS)
	camera_2d.enabled = true
	load_map()
	center_visuals_on_boss()
	unlock_floor(0)

func get_first_node_position() -> Vector2:
	# gets the position of the first node in the list of nodes
	
	# returns: the Vector2 position of the first node
	for node in map_data:
		return node.position
	return Vector2.ZERO

func center_visuals_on_boss() -> void:
	# centers the visuals for the map renderer on the center of the screen based on the position of the boss
	visuals.position = (camera_2d.get_screen_center_position() - get_first_node_position())
	
func _unhandled_input(event: InputEvent) -> void:
	# handles scrolling input for the map, clamping the positions available to scroll to
	
	# Args:
	# 		event: the input event
	if not visible:
		return
	
	if event.is_action_pressed("SCROLL_UP"):
		camera_2d.position.y -= SCROLL_SPEED
	elif event.is_action_pressed("SCROLL_DOWN"):
		camera_2d.position.y += SCROLL_SPEED

	camera_2d.position.y = clamp(camera_2d.position.y, 0, camera_edge_y)

func unlock_floor(floor: int) -> void:
	# unlock all floors given a floor index
	
	# Args:
	#		floor: the floor index to unlock
	for node in map_data:
		if node.floor_index == floor:
			node.available = true
	
func load_map() -> void:
	# loads and displays the map for a given act
	map_data = map_generator.generate_map(FLOORS, WIDTH)
	visuals.position.x = get_viewport_rect().position.x
	visuals.position.y = get_viewport_rect().position.y
	for node in map_data:
		var new_node = MAP_NODE.instantiate() as MapNodeRenderer
		nodes.add_child(new_node)
		new_node.assign_map_node(node)
		new_node.sig_selected.connect(_on_map_node_selected)
		new_node.sig_clicked.connect(_on_map_node_clicked)
	for node in map_data:
		_connect_lines(node)
		

func _connect_lines(node: MapNode) -> void:
	# connects floors to any floors you can progress to from there
	
	# args:
	#		node: the node to connect to its next nodes
	if node.next_nodes.is_empty():
		return
		
	for next: MapNode in node.next_nodes:
		var new_map_connection := MAP_CONNECTION.instantiate() as Line2D
		new_map_connection.clear_points()
		new_map_connection.add_point(node.position)
		new_map_connection.add_point(next.position)
		connections.add_child(new_map_connection)
		
func _on_map_node_clicked(node: MapNode) -> void:
	# callback for sig_clicked signal on MapNodes
	
	# args:
	#		node: the node sending the signal
	for current in map_data:
		if current.floor_index == node.floor_index:
			current.available = false
		
func _on_map_node_selected(node: MapNode) -> void:
	# callback for sig_selected signal on MapNodes
	
	# args:
	#		node: the node sending the signal
	for next in node.next_nodes:
		next.available = true

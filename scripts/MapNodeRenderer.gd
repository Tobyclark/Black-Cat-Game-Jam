class_name MapNodeRenderer
extends Area2D

enum NodeType {FIGHT, EVENT, BOSS, SHOP, FIRE, ELITE, TREASURE, ERROR_TYPE}

signal sig_selected(node: MapNode)
signal sig_clicked(node: MapNode)

@export var selected: bool = false
@export var node_data: MapNode = null

# TODO: Might need to scale these to be the correct size
const ICONS := {
	NodeType.FIGHT: preload("res://assets/sprites/tile_0104.png"),
	NodeType.EVENT: preload("res://assets/sprites/tile_0105.png"),
	NodeType.BOSS: preload("res://assets/sprites/tile_0106.png"),
	NodeType.SHOP: preload("res://assets/sprites/tile_0107.png"),
	NodeType.FIRE: preload("res://assets/sprites/tile_0108.png"),
	NodeType.ELITE: preload("res://assets/sprites/tile_0109.png"),
	NodeType.TREASURE: preload("res://assets/sprites/tile_0110.png"),
	NodeType.ERROR_TYPE: preload("res://assets/sprites/tile_0111.png")
}

@onready var sprite_2d: Sprite2D = $Icon/Sprite2D
@onready var line_2d: Line2D = $Icon/Line2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func assign_map_node(node: MapNode):
	# assigns a map node to be rendered
	
	# args:
	#		node: the node to be set
	node_data = node
	position = node.position
	sprite_2d.texture = ICONS[node.type]

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if selected == true or node_data.available == false:
		return
	if not event.is_action_pressed("LEFT_MOUSE"):
		return
	selected = true
	animation_player.play("OnSelect")
	sig_clicked.emit(node_data)

func on_map_node_selected() -> void:
	# emit a signal when a node is selected, called by the animator
	sig_selected.emit(node_data)

func _on_mouse_entered():
	if selected == false and node_data.available == true:
		animation_player.play("RESET")
		animation_player.play("OnHighlight")

func _on_mouse_exited():
	if selected == false and node_data.available == true:
		animation_player.play("RESET")
		


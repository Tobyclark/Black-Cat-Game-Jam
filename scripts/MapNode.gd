class_name MapNode
extends Resource

enum NodeType {FIGHT, EVENT, BOSS, SHOP, FIRE, ELITE, TREASURE, ERROR_TYPE}

@export var type: NodeType = NodeType.ERROR_TYPE
@export var next_nodes: Array[MapNode] = []
@export var floor_index: int = -1
@export var left_to_right_index: int = -1
@export var selected: bool = false
@export var available: bool = false
@export var position: Vector2 = Vector2.ZERO

class_name MapGenerator
extends Node

enum NodeType {FIGHT, EVENT, BOSS, SHOP, FIRE, ELITE, TREASURE, ERROR_TYPE}

const X_DIST: int = 100
const Y_DIST: int = 60
const ENTROPY: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	# debug_print_map(generate_map(10))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func generate_map(act_length: int, act_width: int) -> Array[MapNode]:
	# generates a map for the act with the given length

	# Args:
	#     act_length: the integer number of floors present in the act

	# Returns:
	#     the generated map
	var map: Array[MapNode] = []
	return fill_map(act_length, act_width, map)


func fill_map(act_length: int, floor_density: int, map: Array) -> Array[MapNode]:
	# fills the map with nodes, connecting them to the previous floor

	# Args:
	#     act_length: the integer number of floors present in the act
	#     floor_density: the integer number of nodes per floor
	#     map: the array of nodes to fill

	# Returns:
	#     the map array filled with nodes
	
	var prev_floor = []
	var current_floor = []
	for i in range(act_length):
		prev_floor = current_floor
		current_floor = []
		for j in range(floor_density):
			var node: MapNode = MapNode.new()
			node.floor_index = (act_length - i) - 1
			node.left_to_right_index = j
			

			# TODO: also generate events, fires, etc...
			if node.floor_index == act_length - 1:
				node.type = MapNode.NodeType.BOSS
			else:
				node.type = MapNode.NodeType.FIGHT

			if node.type != MapNode.NodeType.BOSS:
				node.position = Vector2(j * X_DIST, i * Y_DIST) + Vector2(randf() * ENTROPY, randf() * ENTROPY)
			else:
				node.position = Vector2(floor_density * float(X_DIST) / 2, i * Y_DIST)
			
			var num_next_nodes = randi() % 2 + 1
			for k in range(num_next_nodes):
				if prev_floor != []:
					node.next_nodes.append(prev_floor[(j + k) % len(prev_floor)])
			
			current_floor.append(node)
			map.append(node)

			if i == 0:
				break
	return map

func debug_print_map(map) -> void:
	# prints the map to the console

	# Args:
	#     map: the map to print
	for node in map:
		print("type:" + str(node.type), "floor:" + str(node.floor_index), "left_to_right:" + str(node.left_to_right_index))
		for next_node in node.next_nodes:
			print("->", next_node.type, next_node.floor_index, next_node.left_to_right_index)
		print("\n")

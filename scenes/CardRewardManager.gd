extends Control

const CARD_TEMPLATE = preload("res://scenes/card_template.tscn")

@onready var h_box_container = $HBoxContainer

func _ready():
	get_card_options()
	initialize_card_reward()
	

func initialize_card_reward(num_cards: int = 3) -> void:
	for i in range(num_cards):
		var new_card_reward: CardTemplate = CARD_TEMPLATE.instantiate() as CardTemplate
		h_box_container.add_child(new_card_reward)
		
func get_card_options(num_cards: int = 3) -> Array[Card]:
	return []
	
	# TODO: finish get_card_options using draftable_cards to get an array of num_cards cards to draft, feed them into initialize_card_reward() for random rewards

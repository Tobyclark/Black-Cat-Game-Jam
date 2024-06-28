extends Resource
class_name Card_Pile

@export var cards : Array[Card];

signal card_pile_size_changed

func empty() -> bool:
	return cards.is_empty()


func draw_card() -> Card:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	return card


func add_card(card: Card) -> void:
	cards.append(card)
	card_pile_size_changed.emit(cards.size())


func shuffle() -> void:
	cards.shuffle()


func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())

func _to_string():
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%s: %s" % [i, cards[i].id])
	return "\n".join(_card_strings)

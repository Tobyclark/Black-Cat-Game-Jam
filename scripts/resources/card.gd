extends Resource
class_name Card

enum Target {SELF, SINGLE_ENEMY, ALL_ENEMY, EVERYONE}

@export_group("Card Attributes")
@export var id : String
@export var target : Target
@export var cost : int
@export var chaos_val : int

@export_group("Card Visuals")
@export var graphic : Texture
@export_multiline var text: String

func isSingleTarget() -> bool:
	return target == Target.SINGLE_ENEMY

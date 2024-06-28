extends Resource
class_name Reward

enum RewardType {GOLD, CARD, RELIC, HEALTH}

@export_group("Reward Attributes")
@export var type : RewardType
@export var amount : int

func get_reward_string() -> String:
	if type == RewardType.GOLD:
		return str(amount) + "gold"
	if type == RewardType.CARD:
		return "Add a card"
	if type == RewardType.RELIC:
		return "Relic"
	if type == RewardType.HEALTH:
		return str(amount) + "health"
	return ""

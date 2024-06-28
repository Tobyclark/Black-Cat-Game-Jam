extends Node

func generate_rewards(encounter_difficulty: int) -> Array[Reward]:
	var rewards: Array[Reward] = []
	var gold_reward: Reward = Reward.new()
	var card_reward: Reward = Reward.new()
	var relic_reward: Reward = Reward.new()
	
	gold_reward.type = Reward.RewardType.GOLD
	card_reward.type = Reward.RewardType.CARD
	relic_reward.type = Reward.RewardType.RELIC
	
	if encounter_difficulty == 0:
		gold_reward.amount = 0
	elif encounter_difficulty == 1:
		gold_reward.amount = randi_range(55, 80)
	elif encounter_difficulty == 2:
		gold_reward.amount = randi_range(120, 149)
		rewards.append(relic_reward)
	elif encounter_difficulty == 3:
		gold_reward.amount = randi_range(150, 250)
		rewards.append(relic_reward)
		
	if gold_reward.amount > 0:
		rewards.append(gold_reward)
	rewards.append(card_reward)
	
	return rewards

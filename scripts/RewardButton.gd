class_name RewardButton
extends Button

signal sig_clicked(reward: Reward, reward_button: RewardButton)

@export var reward: Reward :
	set(value):
		reward = value
		text = reward.get_reward_string()

func _on_pressed() -> void:
	sig_clicked.emit(reward, self)

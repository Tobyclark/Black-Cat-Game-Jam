class_name RewardManager
extends Control

signal sig_collect_reward(reward: Reward)
signal sig_rewards_completed()

const REWARD_BUTTON = preload("res://scenes/reward_button.tscn")

@onready var v_box_container = $VBoxContainer
@onready var reward_button = $VBoxContainer/RewardButton
@onready var reward_generator = $RewardGenerator

func offer_rewards(rewards: Array[Reward]) -> void:
	for reward in rewards:
		var new_reward_button: RewardButton = REWARD_BUTTON.instantiate()
		new_reward_button.reward = reward
		new_reward_button.sig_clicked.connect(reward_clicked_callback)
		v_box_container.add_child(new_reward_button)
		

func debug_callback():
	print("hello")

# Called when the node enters the scene tree for the first time.
func _ready():
	sig_rewards_completed.connect(debug_callback)
	#var new_reward_button: Button = button.duplicate() as Button
	#v_box_container.add_child(new_reward_button)
	var reward_test = Reward.new()
	reward_test.type = Reward.RewardType.CARD
	var rewards_test: Array[Reward] = []
	rewards_test.append(reward_test)
	reward_test = Reward.new()
	reward_test.type = Reward.RewardType.GOLD
	reward_test.amount = 500
	rewards_test.append(reward_test)
	offer_rewards(rewards_test)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func reward_clicked_callback(reward: Reward, reward_button: RewardButton):
	reward_button.queue_free()
	sig_collect_reward.emit(reward)

func _on_skip_button_pressed():
	sig_rewards_completed.emit()


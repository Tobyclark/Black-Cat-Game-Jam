class_name CardTemplate
extends Control

@onready var card_name = $CardName
@onready var description = $Description

@export var title : String : 
	set(value):
		title = value
		self.card_name.text = value
@export var desc : String : 
	set(value):
		desc = value
		self.description.text = value
		

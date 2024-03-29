extends Node


# Declare member variables here. Examples:
onready var ShopTitle = $ShopTitle
onready var game_data = SaveFile.game_data
onready var shop_item


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_font_size(ShopTitle, 160)

func set_font_size(label, size):
	var font = label.get_font("font")
	font.size = size

func _on_BackButton_pressed():
	var PopUpSprite = self.get_node_or_null("PopUpSprite")
	if(!is_instance_valid(PopUpSprite)):
		MusicController.play_ui_clic()
		self.change_to_scene("res://scenes/Shop.tscn")
	
func change_to_scene(scene):
	if get_tree().change_scene(scene) != OK:
		print ("An unexpected error occured when trying to switch to" + scene + "scene")
	


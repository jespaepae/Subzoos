extends Node


# Declare member variables here. Examples:
onready var ShopTitle = $ShopTitle
onready var game_data = SaveFile.game_data
onready var EggsLabel = $EggsButton/EggsLabel
onready var FoodLabel = $FoodButton/FoodLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_font_size(ShopTitle, 160)
	self.set_font_size(EggsLabel, 60)
	self.set_font_size(FoodLabel, 60)

func set_font_size(label, size):
	var font = label.get_font("font")
	font.size = size

func _on_BackButton_pressed():
	MusicController.play_ui_clic()
	self.change_to_scene("res://scenes/Shop.tscn")
	
	
func change_to_scene(scene):
	if get_tree().change_scene(scene) != OK:
		print ("An unexpected error occured when trying to switch to" + scene + "scene")

func _on_EggsButton_pressed():
	MusicController.play_ui_clic()
	game_data.eggs += 1
	SaveFile.save_data()

func _on_FoodButton_pressed():
	MusicController.play_ui_clic()
	game_data.food += 1
	SaveFile.save_data()

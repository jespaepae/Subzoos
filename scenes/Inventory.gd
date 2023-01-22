extends Node2D


# Declare member variables here. Examples:
onready var InventoryTitle = $InventoryTitle
onready var EggsLabel = $EggsButton/EggsLabel
onready var FoodLabel = $FoodButton/FoodLabel
onready var game_data = SaveFile.game_data

# Called when the node enters the scene tree for the first time.
func _ready():
	$TankMusic.stop()
	self.set_font_size(InventoryTitle, 160)
	self.set_font_size(EggsLabel, 60)
	self.set_font_size(FoodLabel, 60)
	FoodLabel.text = "FOOD" + "  x" + String(game_data.food)
	EggsLabel.text = "EGGS" + "  x" + String(game_data.eggs)

func _on_BackButton_pressed():
	self.change_to_scene("res://scenes/Game.tscn")

func set_font_size(label, size):
	var font = label.get_font("font")
	font.size = size

func _on_FoodButton_pressed():
	if(game_data.food > 0):
		game_data.food -= 1
		game_data.set_in_tank.resource = "food"
		game_data.set_in_tank.status = 1
		SaveFile.save_data()
		self.change_to_scene("res://scenes/Game.tscn")
		
func _on_EggsButton_pressed():
	if(game_data.eggs > 0):
		game_data.eggs -= 1
		game_data.set_in_tank.resource = "baby"
		game_data.set_in_tank.status = 1
		SaveFile.save_data()
		self.change_to_scene("res://scenes/Game.tscn")
		
func update_food_label():
	FoodLabel.text = "FOOD" + "  x" + String(game_data.food)

func change_to_scene(scene):
	if get_tree().change_scene(scene) != OK:
		print ("An unexpected error occured when trying to switch to" + scene + "scene")


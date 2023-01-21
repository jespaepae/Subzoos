extends Node2D


# Declare member variables here. 
onready var Money = $Money

onready var game_data = SaveFile.game_data
onready var Sea = $Sea
onready var TankFloor = $Sea/TankFloor

func _ready():
	MusicController.play_tank_music()
	self.set_font_size(150)
	if game_data.size() != 0:
		Money.text = "%04d" % game_data.money
		self.change_background(game_data.background.name)
		self.change_floor(game_data.background.floor)
		

func _on_ShopButton_pressed():
	if get_tree().change_scene("res://scenes/Shop.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Shop scene")

func _on_InventoryButton_pressed():
	if get_tree().change_scene("res://scenes/Inventory.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Inventory scene")

func _on_MoneyButton_pressed():
	print(game_data)
	game_data.money += 1
	Money.text = "%04d" % game_data.money
	SaveFile.save_data()
	
func set_font_size(size):
	var font = Money.get_font("font")
	font.size = size
	
func change_background(new_background):
	game_data.background.name = new_background
	Sea.texture = load(new_background)
	SaveFile.save_data()
	
func change_floor(new_floor):
	game_data.background.floor = new_floor
	TankFloor.texture = load(new_floor)
	SaveFile.save_data()

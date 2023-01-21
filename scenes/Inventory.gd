extends Node2D


# Declare member variables here. Examples:
onready var InventoryTitle = $InventoryTitle
onready var EggsLabel = $EggsButton/EggsLabel
onready var FoodLabel = $FoodButton/FoodLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	$TankMusic.stop()
	self.set_font_size(InventoryTitle, 160)
	self.set_font_size(EggsLabel, 60)
	self.set_font_size(FoodLabel, 60)
	

func _on_BackButton_pressed():
	if get_tree().change_scene("res://scenes/Game.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Game scene")

func set_font_size(label, size):
	var font = label.get_font("font")
	font.size = size

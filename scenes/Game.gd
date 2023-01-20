extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	MusicController.play_tank_music()
	pass

func _on_ShopButton_pressed():
	if get_tree().change_scene("res://scenes/Shop.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Shop scene")


func _on_InventoryButton_pressed():
	if get_tree().change_scene("res://scenes/Inventory.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Inventory scene")


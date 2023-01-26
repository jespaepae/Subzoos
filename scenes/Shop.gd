extends Node2D

onready var ShopTitle = $ShopTitle
onready var SuppliesLabel = $SuppliesButton/SuppliesLabel
onready var DecorLabel = $DecorationButton/DecorLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.play_shop_music()
	self.set_font_size(ShopTitle, 160)
	self.set_font_size(SuppliesLabel, 60)
	self.set_font_size(DecorLabel, 60)
	
func _on_BackButton_pressed():
	MusicController.play_ui_clic()
	self.change_to_scene("res://scenes/Game.tscn")

func set_font_size(label, size):
	var font = label.get_font("font")
	font.size = size

func _on_SuppliesButton_pressed():
	MusicController.play_ui_clic()
	self.change_to_scene("res://scenes/Pets.tscn")
	
func change_to_scene(scene):
	if get_tree().change_scene(scene) != OK:
		print ("An unexpected error occured when trying to switch to" + scene + "scene")

func _on_DecorationButton_pressed():
	MusicController.play_ui_clic()
	self.change_to_scene("res://scenes/Decor.tscn")

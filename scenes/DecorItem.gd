extends TextureButton

onready var game_data = SaveFile.game_data
onready var y_pressed = 0
onready var y_released = 0
var item_type
onready var shop_item = self.get_parent().get_parent().shop_item

func _ready():
	var _button_pressed = self.connect("pressed", self, "_on_TextureButton_pressed")

func _input(event):
	if event.is_action_pressed("click"):
		y_pressed = event.position.y
	elif event.is_action_released("click"):
		y_released = event.position.y
		
# Check if the user has scrolled or has pressed the button
func has_pressed():
	return abs(y_pressed-y_released) < 20
	
func change_to_scene(scene):
	MusicController.play_pop_sf()
	if get_tree().change_scene(scene) != OK:
		print ("An unexpected error occured when trying to switch to" + scene + "scene")

func _on_TextureButton_pressed():
	if(self.has_pressed()):
		if(self.get_child(0).text == "Buy"):
			if(game_data.money >= shop_item.price):
				if(shop_item.name == "Egg"):
					MusicController.play_cling_sf()
					game_data.eggs += 1
					self.substract_money(shop_item.price)
					SaveFile.save_data()
				elif(shop_item.name == "Food"):
					MusicController.play_cling_sf()
					game_data.food += 1
					self.substract_money(shop_item.price)
					SaveFile.save_data()
				else:
					pass
		elif(self.get_child(0).text == "Cancel"):
			MusicController.play_ui_clic()
			self.get_parent().queue_free()
			
func substract_money(q):
	game_data.money -= q

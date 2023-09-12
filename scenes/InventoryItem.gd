extends TextureButton

onready var game_data = SaveFile.game_data
onready var y_pressed = 0
onready var y_released = 0
var item_type

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
		if(self.item_type == "background"):
			game_data.background.name = self.texture_normal.get_path()
			SaveFile.save_data()
			change_to_scene("res://scenes/Game.tscn")
		elif(self.item_type == "floor"):
			game_data.background.floor = self.texture_normal.get_path()
			SaveFile.save_data()
			change_to_scene("res://scenes/Game.tscn")
		elif(self.item_type == "decor"):
			var i = 0
			var this_item
			for item in game_data.inventory_items:
				if item.file == self.texture_normal.get_path():
					this_item = item
					this_item.number -= 1
					break;
				i += 1
			if i < game_data.inventory_items.size():
				game_data.inventory_items.remove(i)
			game_data.inventory_items.append(this_item)
			game_data.set_in_tank.status = 1
			game_data.set_in_tank.resource = this_item.file
			SaveFile.save_data()
			change_to_scene("res://scenes/Game.tscn")

extends TextureButton

onready var game_data = SaveFile.game_data
onready var x_pressed = 0
onready var x_released = 0
var subzoo_id
var status

func _ready():
	var _button_pressed = self.connect("pressed", self, "_on_TextureButton_pressed")

func _input(event):
	if event.is_action_pressed("click"):
		x_pressed = event.position.x
	elif event.is_action_released("click"):
		x_released = event.position.x
		
# Check if the user has scrolled or has pressed the button
func has_pressed():
	return abs(x_pressed-x_released) < 20
	
func change_to_scene(scene):
	MusicController.play_cling_sf()
	if get_tree().change_scene(scene) != OK:
		print ("An unexpected error occured when trying to switch to" + scene + "scene")

func _on_TextureButton_pressed():
	if(self.has_pressed()):
		if(self.status == "baby"):
			self.delete_sea_monkey(self.subzoo_id)
			game_data.money += 5
			SaveFile.save_data()
			change_to_scene("res://scenes/Pets.tscn")
		elif(self.status == "display"):
			self.delete_sea_monkey(self.subzoo_id)
			game_data.money += 7
			SaveFile.save_data()
			change_to_scene("res://scenes/Pets.tscn")
			
func delete_sea_monkey(id):
	var i = 0
	for sea_monkey in game_data.sea_monkeys:
		if sea_monkey.id == id:
			break
		i += 1
	if i <  game_data.sea_monkeys.size():
		game_data.sea_monkeys.remove(i)

extends Sprite

# Pickable needs to be selected from the inspector

onready var game_data = SaveFile.game_data
var can_grab = false
var grabbed_offset = Vector2()
var been_grabbed_this = false
var follow_speed = 6.0
onready var DecorTimer = self.get_parent().get_node("DecorTimer")
var mouse_x
var mouse_y
var id = 0

func _ready():
	var _button_pressed = DecorTimer.connect("timeout", self, "_on_DecorTimer_timeout")

func _process(delta):
	var been_grabbed_general = self.get_parent().get_parent().PlantBeenGrabbed
	var sprite_x = self.position.x
	var sprite_y = self.position.y
	var lowx = sprite_x - self.texture.get_width()/4.0
	var highx = sprite_x + self.texture.get_width()/4.0
	var lowy = sprite_y - self.texture.get_height()
	var highy = sprite_y
	can_grab = get_global_mouse_position().x >= lowx and get_global_mouse_position().x <= highx and get_global_mouse_position().y >= lowy and get_global_mouse_position().y <= highy
	
	if(been_grabbed_this) : can_grab = true
	else : can_grab = get_global_mouse_position().x >= lowx and get_global_mouse_position().x <= highx and get_global_mouse_position().y >= lowy and get_global_mouse_position().y <= highy
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab and !been_grabbed_general:
		self.get_parent().get_parent().PlantBeenGrabbed = true
		self.scale.x = 1.1
		self.scale.y = 1.1
		DecorTimer.start(0.75)
		mouse_x = get_global_mouse_position().x
		mouse_y = get_global_mouse_position().y
		
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab and been_grabbed_this:
		position = position.linear_interpolate(get_global_mouse_position() + grabbed_offset, delta * follow_speed)
		
		if(get_global_mouse_position().x > 766 and get_global_mouse_position().y < 305):
			self.get_parent().get_parent().get_node("InventoryButton").rect_scale.x = 1.3
			self.get_parent().get_parent().get_node("InventoryButton").rect_scale.y = 1.3
			self.get_parent().get_parent().get_node("InventoryButton").rect_position.x = 700
		else:
			self.get_parent().get_parent().get_node("InventoryButton").rect_scale.x = 1
			self.get_parent().get_parent().get_node("InventoryButton").rect_scale.y = 1
			self.get_parent().get_parent().get_node("InventoryButton").rect_position.x = 766
		
	if Input.is_action_just_released("click"):
		if been_grabbed_this: MusicController.play_scratch_sf() # To avoid to play the sound after changing the screen
		if(get_global_mouse_position().x > 700 and get_global_mouse_position().y < 320 and been_grabbed_this):
			save_in_inventory()
		been_grabbed_this = false
		self.get_parent().get_parent().PlantBeenGrabbed = false
		self.scale.x = 1
		self.scale.y = 1
		mouse_x = null
		mouse_y = null
		
func _on_DecorTimer_timeout():
	DecorTimer.stop()
	if(mouse_x != null and mouse_y != null):
		if(get_global_mouse_position().x >= mouse_x - 150 and get_global_mouse_position().y >= mouse_y - 150 and get_global_mouse_position().x <= mouse_x + 150 and get_global_mouse_position().y <= mouse_y + 150):
			MusicController.play_pop_sf()
			been_grabbed_this = true
			
func save_in_inventory():
	var i = 0
	for decor in game_data.decors:
		if(decor.id == self.id):
			break;
		i += 1
	if i < game_data.decors.size():
		game_data.decors.remove(i)
	
	i = 0
	var inventory_item
	for item in game_data.inventory_items:
		if(item.file == self.texture.get_path()):
			inventory_item = item
			break;
		i += 1
	if i < game_data.inventory_items.size():
		game_data.inventory_items.remove(i)
	inventory_item.number += 1
	game_data.inventory_items.append(inventory_item)
	SaveFile.save_data()
	self.queue_free()

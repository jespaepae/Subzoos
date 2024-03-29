extends Node2D


# Declare member variables here. Examples:
onready var InventoryTitle = $InventoryTitle
onready var EggsLabel = $EggsButton/EggsLabel
onready var FoodLabel = $FoodButton/FoodLabel
onready var game_data = SaveFile.game_data
onready var y_pressed = 0
onready var y_released = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$TankMusic.stop()
	self.load_inventory_items()
	self.set_font_size(InventoryTitle, 160)
	self.set_font_size(EggsLabel, 60)
	self.set_font_size(FoodLabel, 60)
	if game_data.eggs == 0 and game_data.money < 10 and game_data.sea_monkeys.size() == 0:
		game_data.eggs = 1
		SaveFile.save_data()
	FoodLabel.text = "FOOD" + "  x" + String(game_data.food)
	EggsLabel.text = "EGGS" + "  x" + String(game_data.eggs)

func _on_BackButton_pressed():
	MusicController.play_ui_clic()
	self.change_to_scene("res://scenes/Game.tscn")

func set_font_size(label, size):
	var font = label.get_font("font")
	font.size = size

func _on_FoodButton_pressed():
	if(game_data.food > 0 and game_data.foods.size() < 10):
		MusicController.play_ui_clic()
		game_data.food -= 1
		game_data.set_in_tank.resource = "food"
		game_data.set_in_tank.status = 1
		SaveFile.save_data()
		self.change_to_scene("res://scenes/Game.tscn")
		
func _on_EggsButton_pressed():
	if(game_data.eggs > 0 and game_data.sea_monkeys.size() < 10):
		MusicController.play_ui_clic()
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

func load_inventory_items():
	var GridContainerNode = self.get_node("ScrollContainer/GridContainer")
	for item in game_data.inventory_items:
		if item.number > 0:
			# Create Nodes
			var SlotNode = Panel.new()
			var TextureButtonNode = TextureButton.new()
			var LabelNode = Label.new()
			var dynamic_font = DynamicFont.new()
			
			# SlotNode Configuration
			SlotNode.rect_min_size.x = 450
			SlotNode.rect_min_size.y = 450
			SlotNode.margin_right = 450
			SlotNode.margin_bottom = 450
			SlotNode.get_stylebox("panel","").set_texture(load("res://assets/images/menus and ui/inventory slot.png"))
			
			# TextureButtonNode Configuration
			TextureButtonNode.expand = true
			TextureButtonNode.texture_normal = load(item.file)
			if(TextureButtonNode.texture_normal.get_height() > TextureButtonNode.texture_normal.get_width()):
				TextureButtonNode.rect_size.x = (TextureButtonNode.texture_normal.get_width()*248)/TextureButtonNode.texture_normal.get_height()
				TextureButtonNode.rect_size.y = 248
				TextureButtonNode.rect_position.x = 95 + 124 - TextureButtonNode.rect_size.x/2
				TextureButtonNode.rect_position.y = 95
			else:
				TextureButtonNode.rect_size.x = 248
				TextureButtonNode.rect_size.y = (TextureButtonNode.texture_normal.get_height()*248)/TextureButtonNode.texture_normal.get_width()
				TextureButtonNode.rect_position.x = 95
				TextureButtonNode.rect_position.y = 95 + 124 - TextureButtonNode.rect_size.y/2
			TextureButtonNode.emit_signal("pressed")
			TextureButtonNode.set_script(load("res://scenes/InventoryItem.gd"))
			TextureButtonNode.item_type = item.type
			
			# LabelNode Configuration
			LabelNode.align = HALIGN_RIGHT
			LabelNode.text = "x"+" "+ String(item.number)
			LabelNode.rect_position.x = 123
			LabelNode.rect_position.y = 305
			LabelNode.rect_size.x = 225
			LabelNode.rect_size.y = 55
			dynamic_font.font_data = load("res://fonts/Sugar Snow.ttf")
			dynamic_font.size = 60
			LabelNode.add_font_override("font", dynamic_font)
			
			# Join all Nodes
			SlotNode.add_child(TextureButtonNode)
			GridContainerNode.add_child(SlotNode)
			SlotNode.add_child(LabelNode)
			
func list_of_scale_values(values):
	for i in range(100, 0, -1):
		values.append((i*0.01))

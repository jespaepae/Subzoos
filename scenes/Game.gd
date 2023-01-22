extends Node2D


# Declare member variables here. 
onready var Money = $Money

onready var game_data = SaveFile.game_data
onready var Sea = $Sea
onready var TankFloor = $Sea/TankFloor
onready var ShopButton = $ShopButton
onready var InventoryButton = $InventoryButton

func _ready():
	MusicController.play_tank_music()
	self.set_font_size(150)
	if game_data.size() != 0:
		Money.text = "%04d" % game_data.money
		self.change_background(game_data.background.name)
		self.change_floor(game_data.background.floor)
		self.load_sea_monkeys()
		if game_data.set_in_tank.status == 1:
			self.hide_buttons()
		else:
			self.show_buttons()
		

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
	
func hide_buttons():
	ShopButton.hide()
	InventoryButton.hide()
	
func show_buttons():
	ShopButton.show()
	InventoryButton.show()
	
func _input(event):
	if game_data.set_in_tank.status == 1 and event is InputEventMouseButton: 
		print(event.position)
		self.show_buttons()
		self.add_food(event)
		game_data.set_in_tank.status = 0
		SaveFile.save_data()
		
func load_sea_monkeys():
	for sea_monkey in game_data.sea_monkeys:
		pass
		
func add_food(event):
	# Create Food nodes
	var FoodNode = RigidBody2D.new()
	var SpriteNode = Sprite.new()
	var CollisionShape2DNode = CollisionShape2D.new()
	var CircleShape2DNode = CircleShape2D.new()
	
	# Set sprite texture and position
	SpriteNode.texture = load("res://assets/images/subzoo food.png")
	SpriteNode.position = event.position
	SpriteNode.scale.x = 0.238
	SpriteNode.scale.y = 0.238
	
	# Set Collision shape and position
	CollisionShape2DNode.position = event.position
	CollisionShape2DNode.shape = CircleShape2DNode
	CircleShape2DNode.radius = 31.34
	
	
	# Join all nodes
	FoodNode.set_script(load("res://scenes/Food.gd"))
	FoodNode.add_child(SpriteNode)
	FoodNode.add_child(CollisionShape2DNode)
	
	self.add_child(FoodNode)

func _on_Area2D_body_entered(body):
	if(body.name == "Food"):
		body.queue_free()

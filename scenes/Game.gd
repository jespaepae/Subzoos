extends Node2D


# Declare member variables here. 
var rng = RandomNumberGenerator.new()
onready var Money = $Money

onready var game_data = SaveFile.game_data
onready var Sea = $Sea
onready var TankFloor = $Sea/TankFloor
onready var ShopButton = $ShopButton
onready var InventoryButton = $InventoryButton
onready var SwimTimer = $SwimTimer
onready var SeaMonkeyScript = load("res://scenes/SeaMonkey.gd")
onready var PlantBeenGrabbed = false

func _ready():
	randomize()
	MusicController.play_tank_music()
	self.set_font_size(150)
	if game_data.size() != 0:
		Money.text = "%04d" % game_data.money
		self.change_background(game_data.background.name)
		self.change_floor(game_data.background.floor)
		self.load_sea_monkeys()
		self.load_food()
		self.load_decors()
		if game_data.set_in_tank.status == 1:
			self.hide_buttons()
		else:
			self.show_buttons()

func _process(_delta):
	self.update_sea_monkeys()
	self.update_decors()
	SaveFile.save_data()

func _on_ShopButton_pressed():
	self.update_sea_monkeys()
	SaveFile.save_data()
	MusicController.play_ui_clic()
	if get_tree().change_scene("res://scenes/Shop.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Shop scene")

func _on_InventoryButton_pressed():
	self.update_sea_monkeys()
	SaveFile.save_data()
	MusicController.play_ui_clic()
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
		if(game_data.set_in_tank.resource == "food"):
			self.show_buttons()
			self.add_food(event.position.x, event.position.y)
			self.save_food(event.position.x, event.position.y)
			game_data.set_in_tank.status = 0
			SaveFile.save_data()
		elif(game_data.set_in_tank.resource == "baby"):
			self.show_buttons()
			var id = randi()
			self.add_sea_monkey(event.position.x, event.position.y, "baby", 360, id, 60)
			self.save_sea_monkey(event.position.x, event.position.y, "baby", 360, id, 60)
			game_data.set_in_tank.status = 0
			SaveFile.save_data()
		else:
			self.show_buttons()
			var id = randi()
			self.add_decor(event.position.x, event.position.y, game_data.set_in_tank.resource, id)
			self.save_decor(event.position.x, event.position.y, game_data.set_in_tank.resource, id)
			game_data.set_in_tank.status = 0
			SaveFile.save_data()
		MusicController.play_pop_sf()
		
func add_sea_monkey(x, y, status, life, id, time_to_grow_up):
	# Create Sea monkey nodes
	var SeaMonkeyNode = RigidBody2D.new()
	var AnimatedSpriteNode = AnimatedSprite.new()
	var CollisionShape2DNode = CollisionShape2D.new()
	var Area2DNode = Area2D.new()
	var CollisionShape2DNode2 = CollisionShape2D.new()
	var RectangleShape2DNode = RectangleShape2D.new()
	var RectangleShape2DNode2 = RectangleShape2D.new()
	var TimerNode = Timer.new()
	var OwnSwimTimer = Timer.new()
	
	# Sea Monkey Node Configuration
	SeaMonkeyNode.mode = RigidBody2D.MODE_CHARACTER
	SeaMonkeyNode.contact_monitor = true
	SeaMonkeyNode.set_script(load("res://scenes/SeaMonkey.gd"))
	SeaMonkeyNode.life = life
	SeaMonkeyNode.id = id
	SeaMonkeyNode.position.x = x
	SeaMonkeyNode.position.y = y
	SeaMonkeyNode.add_to_group("Sea_monkeys")
	
	# Animated Sprite Configuration
	AnimatedSpriteNode.frames = load("res://scenes/SpriteFrames.tres")
	AnimatedSpriteNode.animation = status
	AnimatedSpriteNode.playing = true
	AnimatedSpriteNode.position.x = 0
	AnimatedSpriteNode.position.y = 0
	AnimatedSpriteNode.scale.x = 0.201
	AnimatedSpriteNode.scale.y = 0.201
	
	# CollisionShape2D Configuration
	CollisionShape2DNode.shape = RectangleShape2DNode
	RectangleShape2DNode.extents.x = 37
	RectangleShape2DNode.extents.y = 66.125
	CollisionShape2DNode.position.x = 0
	CollisionShape2DNode.position.y = 0
	
	# Area2D Configuration
	Area2DNode.emit_signal("body_entered")
	
	# CollisionShape2D Configuration
	CollisionShape2DNode2.shape = RectangleShape2DNode2
	RectangleShape2DNode2.extents.x = 56
	RectangleShape2DNode2.extents.y = 92.5
	CollisionShape2DNode2.position.x = 0
	CollisionShape2DNode2.position.y = 0
	
	# Timer Configuration
	if(time_to_grow_up > 0):
		TimerNode.wait_time = time_to_grow_up
	else:
		TimerNode.wait_time = 0.1
	TimerNode.autostart = true
	
	# SwimTimerConfiguration
	OwnSwimTimer.name = "OwnSwimTimer"
	OwnSwimTimer.autostart = true
	
	#Join all nodes
	SeaMonkeyNode.add_child(AnimatedSpriteNode)
	SeaMonkeyNode.add_child(CollisionShape2DNode)
	SeaMonkeyNode.add_child(Area2DNode)
	Area2DNode.add_child(CollisionShape2DNode2)
	SeaMonkeyNode.add_child(TimerNode)
	SeaMonkeyNode.add_child(OwnSwimTimer)
	
	self.add_child(SeaMonkeyNode)
	
func save_sea_monkey(x, y, status, life, id, time_to_grow_up):
	var dir = {
		"life": life,
		"status": status,
		"x": x,
		"y": y,
		"id": id,
		"time_to_grow_up": time_to_grow_up
	}
	var i = 0
	for sea_monkey in game_data.sea_monkeys:
		if(sea_monkey.id == id):
			break;
		i += 1
	if i < game_data.sea_monkeys.size():
		game_data.sea_monkeys.remove(i)
	game_data.sea_monkeys.append(dir)
	
func load_sea_monkeys():
	for sea_monkey in game_data.sea_monkeys:
		self.add_sea_monkey(sea_monkey.x, sea_monkey.y, sea_monkey.status, sea_monkey.life, sea_monkey.id, sea_monkey.time_to_grow_up)

func update_sea_monkeys():
	var sea_monkeys_in_screen = self.get_sea_monkeys_in_screen()
	for sea_monkey in sea_monkeys_in_screen:
		var new_x = sea_monkey.position.x
		var new_y = sea_monkey.position.y
		var new_status = sea_monkey.get_child(0).animation
		var time_to_grow_up = sea_monkey.get_child(3).time_left
		self.save_sea_monkey(new_x, new_y, new_status, sea_monkey.life, sea_monkey.id, time_to_grow_up)
		
func add_food(x, y):
	# Create Food nodes
	var FoodNode = RigidBody2D.new()
	var SpriteNode = Sprite.new()
	var CollisionShape2DNode = CollisionShape2D.new()
	var CircleShape2DNode = CircleShape2D.new()
	
	# Detect collisions
	FoodNode.contact_monitor = true
	FoodNode.contacts_reported = 1
	FoodNode.sleeping = false
	
	# Set sprite texture and position
	SpriteNode.texture = load("res://assets/images/subzoo food.png")
	SpriteNode.position.x = x
	SpriteNode.position.y = y
	SpriteNode.scale.x = 0.238
	SpriteNode.scale.y = 0.238
	
	# Set Collision shape and position
	CollisionShape2DNode.position.x = x
	CollisionShape2DNode.position.y = y
	CollisionShape2DNode.shape = CircleShape2DNode
	CircleShape2DNode.radius = 31.34
	
	# Join all nodes
	FoodNode.set_script(load("res://scenes/Food.gd"))
	FoodNode.add_child(SpriteNode)
	FoodNode.add_child(CollisionShape2DNode)
	FoodNode.add_to_group("Food")
	
	self.add_child(FoodNode)
	
func add_bubbles():
	rng.randomize()
	# Create Food nodes
	var BubblesNode = RigidBody2D.new()
	var AnimatedSpriteNode = AnimatedSprite.new()
	var CollisionShape2DNode = CollisionShape2D.new()
	
	# Bubbles node configuration
	BubblesNode.linear_velocity.y = rng.randf_range(-400.0, -500.0)
	BubblesNode.position.x = rng.randf_range(30, 1050)
	BubblesNode.position.y = 2000
	BubblesNode.set_script(load("res://scenes/Bubbles.gd"))
	
	# Animated Sprite Node Configuration
	var BubblesScale = rng.randf_range(0.15, 0.25)
	AnimatedSpriteNode.frames = load("res://scenes/Bubbles.tres")
	AnimatedSpriteNode.animation = "bubbles"
	AnimatedSpriteNode.playing = true
	AnimatedSpriteNode.scale.x = BubblesScale
	AnimatedSpriteNode.scale.y = BubblesScale
	
	# Join all nodes
	BubblesNode.add_child(AnimatedSpriteNode)
	BubblesNode.add_child(CollisionShape2DNode)
	
	self.add_child(BubblesNode)

func _on_Area2D_body_entered(body):
	if(body.get_child(0) is Sprite):
		delete_food(body.get_child(0).position.x, body.get_child(0).position.y)
		SaveFile.save_data()
		body.queue_free()
		
func save_food(x, y):
	var dict = {
		"x": x,
		"y": y
	}
	game_data.foods.append(dict)
	
func delete_food(x, y):
	var i = 0
	for food in game_data.foods:
		if food.x == x and food.y == y:
			break
		i += 1
	if i <  game_data.foods.size():
		game_data.foods.remove(i)
		
func delete_sea_monkey(x, y):
	var i = 0
	for sea_monkey in game_data.sea_monkeys:
		if sea_monkey.x == x and sea_monkey.y == y:
			break
		i += 1
	if i <  game_data.sea_monkeys.size():
		game_data.sea_monkeys.remove(i)

func load_food():
	for food in game_data.foods:
		add_food(food.x, food.y)
		
func get_sea_monkeys_in_screen():
	var res = []
	for child in self.get_children():
		if child.is_in_group("Sea_monkeys"):
			res.append(child)
	return res


func _on_BubbleTimer_timeout():
	rng.randomize()
	var new_timer = rng.randf_range(1.0, 15.0)
	self.get_node("BubbleTimer").wait_time = new_timer
	add_bubbles()
	
func add_decor(x, y, decor, id):
	# Create Decor nodes
	var SpriteNode = Sprite.new()
	
	# Set sprite texture and position
	SpriteNode.texture = load(decor)
	SpriteNode.position.x = x
	SpriteNode.position.y = y
	SpriteNode.offset.y = - SpriteNode.texture.get_height()/2.0 + 0.1 * SpriteNode.texture.get_height()
	SpriteNode.add_to_group("Decor")
	SpriteNode.set_script(load("res://scenes/KinematicBody2D.gd"))
	SpriteNode.id = id
	
	#Find if it needs to move
	for item in game_data.inventory_items:
		if(item.file == decor and item.can_move):
			rng.randomize()
			var speed = rng.randf_range(1.0, 3.0)
			SpriteNode.material = ShaderMaterial.new()
			SpriteNode.material.shader = load("res://scenes/Game.tscn::3")
			SpriteNode.material.set_shader_param("speed", speed)
	
	self.get_node("Decorations").add_child(SpriteNode)
	
func save_decor(x, y, decor, id):
	var dir = {
		"x": x,
		"y": y,
		"id": id,
		"file": decor
	}
	var i = 0
	for decor in game_data.decors:
		if(decor.id == id):
			break;
		i += 1
	if i < game_data.decors.size():
		game_data.decors.remove(i)
	game_data.decors.append(dir)
	
	
func load_decors():
	for decor in game_data.decors:
		self.add_decor(decor.x, decor.y, decor.file, decor.id)
		
func update_decors():
	for decor in self.get_node("Decorations").get_children():
		if decor is Sprite:
			save_decor(decor.position.x, decor.position.y, decor.texture.get_path(), decor.id)


func _on_InventoryButton_mouse_entered():
	self.get_node("InventoryButton").rect_scale.x = 1.3
	self.get_node("InventoryButton").rect_scale.y = 1.3
	self.get_node("InventoryButton").rect_position.x = 700


func _on_InventoryButton_mouse_exited():
	self.get_node("InventoryButton").rect_scale.x = 1
	self.get_node("InventoryButton").rect_scale.y = 1
	self.get_node("InventoryButton").rect_position.x = 766


func _on_ShopButton_mouse_entered():
	self.get_node("ShopButton").rect_scale.x = 1.2
	self.get_node("ShopButton").rect_scale.y = 1.2


func _on_ShopButton_mouse_exited():
	self.get_node("ShopButton").rect_scale.x = 1
	self.get_node("ShopButton").rect_scale.y = 1

extends RigidBody2D

var velocity = Vector2()
var rng = RandomNumberGenerator.new()
onready var sprite = self.get_child(0)
var life = -1
var id = 0
var money_label = Node
var collision_shape = Node
var Game = load("res://scenes/Game.gd")
onready var game_data = SaveFile.game_data

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	#var timer = get_node("../SwimTimer")
	var timer = self.get_node("OwnSwimTimer")
	timer.start(rng.randf_range(0.5, 3.0))
	var area2 = get_child(2)
	var grow_up_timer = self.get_child(3)
	money_label = get_node("../Money")
	collision_shape = get_child(1)
	
	timer.connect("timeout", self, "_on_SwimTimer_timeout")
	area2.connect("body_entered", self, "_on_Area2D_body_entered")
	grow_up_timer.connect("timeout", self, "_on_GrowUpTimer_timeout")
	
	swim()
	# Set random start frame so that every sea monkey swims different
	self.get_child(0).frame = rng.randi_range(0, 8)
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rng.randomize()
	var x = rng.randf_range(1, 200.0)
	var y = rng.randf_range(-200.0, 200.0)
	if(sprite.animation != "ded"): 
		# Maked sure that the sea monkey doesn't move off the screen
		if(self.position.x < 0):
			x = rng.randf_range(1, 200.0)
			set_linear_velocity(Vector2(x,y))
		elif(self.position.x > 1080):
			x = rng.randf_range(-200, -1)
			set_linear_velocity(Vector2(x,y))
		elif(self.position.y < 0):
			y = rng.randf_range(1, 200.0)
			set_linear_velocity(Vector2(x,y))
		elif(self.position.y > 1920):
			y = rng.randf_range(-200, -1)
			set_linear_velocity(Vector2(x,y))
	elif self.position.y < 0:
		self.delete_sea_monkey()
		self.queue_free()
		
	
# Every time there is a timeout the sea monkey moves to a different direction
func _on_SwimTimer_timeout():
	if(life > 0):
		swim()
		life -= 2
	else:
		var x = 0
		var y = -300
		sprite.animation = "ded"
		collision_shape.disabled = true
		set_linear_velocity(Vector2(x,y))
		self.get_child(0).rotation = atan2(y,x) + PI/2

func swim():
	if sprite.animation != "ded":
		rng.randomize()
		var foods = self.get_tree().get_nodes_in_group("Food")
		var x
		var y
		if(foods.size() > 0): # Calculate direction to go to the food
			x = foods[0].get_child(0).position.x - self.position.x
			if x > 200 or x < -200: x = (foods[0].get_child(0).position.x - self.position.x)*500 / get_viewport_rect().size.x
			y = foods[0].get_child(0).position.y - self.position.y
			if y > 200 or y < -200: y = (foods[0].get_child(0).position.y - self.position.y)*500 / get_viewport_rect().size.y
		else:
			x = rng.randf_range(-200.0, 200.0)
			y = rng.randf_range(-200.0, 200.0)
		set_linear_velocity(Vector2(x,y))
		self.get_child(0).rotation = atan2(y,x) + PI/2
	else:
		var x = 0
		var y = -300
		self.get_child(0).rotation = 0
		sprite.animation = "ded"
		collision_shape.disabled = true
		set_linear_velocity(Vector2(x,y))
		self.get_child(0).rotation = atan2(y,x) + PI/2

func _on_Area2D_body_entered(body):
	if(body.get_child(0) is Sprite):
		if sprite.animation != "ded":
			self.life += 10
			game_data.money += 7
			money_label.text = "%04d" % game_data.money
			delete_food(body.get_child(0).position.x, body.get_child(0).position.y)
			SaveFile.save_data()
			body.queue_free()

func delete_food(x, y):
	var i = 0
	for food in game_data.foods:
		if food.x == x and food.y == y:
			break
		i += 1
	if i <  game_data.foods.size():
		game_data.foods.remove(i)
		
func delete_sea_monkey():
	var i = 0
	for sea_monkey in game_data.sea_monkeys:
		if sea_monkey.id == self.id:
			break
		i += 1
	if game_data.sea_monkeys.size():
		game_data.sea_monkeys.remove(i)
		
func grow_up():
	if (sprite.animation != "ded" and sprite.animation != "display"):
		MusicController.play_pop_sf()
		game_data.money += 15
		money_label.text = "%04d" % game_data.money
		sprite.animation = "display"
	
func _on_GrowUpTimer_timeout():
	grow_up()

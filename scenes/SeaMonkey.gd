extends RigidBody2D

var velocity = Vector2()
var rng = RandomNumberGenerator.new()
onready var sprite = self.get_child(0)
var life = -1
var id = 0
var money_label = Node
var Game = load("res://scenes/Game.gd")
onready var game_data = SaveFile.game_data

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var timer = get_node("../SwimTimer")
	var area2 = get_child(2)
	var grow_up_timer = self.get_child(3)
	money_label = get_node("../Money")
	
	timer.connect("timeout", self, "_on_SwimTimer_timeout")
	area2.connect("body_entered", self, "_on_Area2D_body_entered")
	grow_up_timer.connect("timeout", self, "_on_GrowUpTimer_timeout")
	
	swim()
	
		
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
		set_linear_velocity(Vector2(x,y))

func swim():
	if sprite.animation != "ded":
		rng.randomize()
		var x = rng.randf_range(-200.0, 200.0)
		var y = rng.randf_range(-200.0, 200.0)
		set_linear_velocity(Vector2(x,y))
	else:
		var x = 0
		var y = -300
		sprite.animation = "ded"
		set_linear_velocity(Vector2(x,y))


func _on_Area2D_body_entered(body):
	if(body.get_child(0) is Sprite):
		self.life += 5
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
		game_data.money += 5
		money_label.text = "%04d" % game_data.money
		sprite.animation = "display"
	
func _on_GrowUpTimer_timeout():
	grow_up()

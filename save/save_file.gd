extends Node

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func _ready():
	load_data()
	
func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()
	
func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data = {
			"money": 0,
			"background": {
				"name":"res://assets/images/tank bgs/aquarium background.png",
				"floor":"res://assets/images/tank floor/tank floor 1.png"
			},
			"food": 20,
			"eggs": 15,
			"set_in_tank": {
				"status": 0, 	#0 if the player doesn't hsve to place anything, 1 in other casea
				"resource":""
			},
			"sea_monkeys": [],
			"foods": [],
			"inventory_items": [ {
				"type": "background",
				"file": "res://assets/images/tank bgs/aquarium background.png",
				"number": 1
			},
			{
				"type": "background",
				"file": "res://assets/images/tank bgs/aquarium background 2.png",
				"number": 1
			},
			{
				"type": "background",
				"file": "res://assets/images/tank bgs/aquarium background 3.png",
				"number": 1
			},
			{
				"type": "background",
				"file": "res://assets/images/tank bgs/aquarium background 4.png",
				"number": 1
			},
			{
				"type": "background",
				"file": "res://assets/images/tank bgs/aquarium background 5.png",
				"number": 1
			},
			{
				"type": "floor",
				"file": "res://assets/images/tank floor/tank floor 1.png",
				"number": 1
			},
			{
				"type": "floor",
				"file": "res://assets/images/tank floor/tank floor 2.png",
				"number": 1
			},
			{
				"type": "floor",
				"file": "res://assets/images/tank floor/tank floor 3.png",
				"number": 1
			},
			{
				"type": "floor",
				"file": "res://assets/images/tank floor/tank floor 4.png",
				"number": 1
			},
			{
				"type": "floor",
				"file": "res://assets/images/tank floor/tank floor 5.png",
				"number": 1
			},
			{
				"type": "floor",
				"file": "res://assets/images/tank floor/tank floor 6.png",
				"number": 1
			},
			{
				"type": "floor",
				"file": "res://assets/images/tank floor/tank floor 7.png",
				"number": 1
			},
			{
				"name": "Artificial 1",
				"description": "This is the description for 'Artificial 1'",
				"price": 10,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 1.png",
				"number": 0
			},
			{
				"name": "Artificial 2",
				"description": "This is the description for 'Artificial 2'",
				"price": 15,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 2.png",
				"number": 0
			},
			{
				"name": "Artificial 3",
				"description": "This is the description for 'Artificial 3'",
				"price": 17,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 3.png",
				"number": 0
			},
			{
				"name": "Artificial 4",
				"description": "This is the description for 'Artificial 4'",
				"price": 20,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 4.png",
				"number": 0
			},
			{
				"name": "Artificial 5",
				"description": "This is the description for 'Artificial 5'",
				"price": 25,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 5.png",
				"number": 0
			},
			{
				"name": "Coral 1",
				"description": "This is the description for 'Coral 1'",
				"price": 10,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 1.png",
				"number": 0
			},
			{
				"name": "Coral 2",
				"description": "This is the description for 'Coral 2'",
				"price": 15,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 2.png",
				"number": 0
			},
			{
				"name": "Coral 3",
				"description": "This is the description for 'Coral 3'",
				"price": 20,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 3.png",
				"number": 0
			},
			{
				"name": "Coral 4",
				"description": "This is the description for 'Coral 4'",
				"price": 25,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 4.png",
				"number": 0
			},
			{
				"name": "Coral 5",
				"description": "This is the description for 'Coral 5'",
				"price": 30,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 5.png",
				"number": 0
			},
			{
				"name": "Hawaiian 1",
				"description": "This is the description for 'Hawaiian 1'",
				"price": 20,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 1.png",
				"number": 0
			},
			{
				"name": "Hawaiian 2",
				"description": "This is the description for 'Hawaiian 2'",
				"price": 30,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 2.png",
				"number": 0
			},
			{
				"name": "Hawaiian 3",
				"description": "This is the description for 'Hawaiian 3'",
				"price": 40,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 3.png",
				"number": 0
			},
			{
				"name": "Hawaiian 4",
				"description": "This is the description for 'Hawaiian 4'",
				"price": 50,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 4.png",
				"number": 0
			},
			{
				"name": "Hawaiian 5",
				"description": "This is the description for 'Hawaiian 5'",
				"price": 75,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 5.png",
				"number": 0
			},
			{
				"name": "Plant 2",
				"description": "This is the description for 'Plant 2'",
				"price": 5,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 2.png",
				"number": 0
			},
			{
				"name": "Plant 3",
				"description": "This is the description for 'Plant 3'",
				"price": 7,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 3.png",
				"number": 0
			},
			{
				"name": "Plant 4",
				"description": "This is the description for 'Plant 4'",
				"price": 8,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 4.png",
				"number": 0
			},
			{
				"name": "Plant 5",
				"description": "This is the description for 'Plant 5'",
				"price": 10,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 5.png",
				"number": 0
			},
			{
				"name": "Rock 1",
				"description": "This is the description for 'Rock 1'",
				"price": 10,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 1.png",
				"number": 0
			},
			{
				"name": "Rock 2",
				"description": "This is the description for 'Rock 2'",
				"price": 8,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 2.png",
				"number": 0
			},
			{
				"name": "Rock 3",
				"description": "This is the description for 'Rock 3'",
				"price": 6,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 3.png",
				"number": 0
			},
			{
				"name": "Rock 4",
				"description": "This is the description for 'Rock 4'",
				"price": 14,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 4.png",
				"number": 0
			},
			{
				"name": "Rock 5",
				"description": "This is the description for 'Rock 5'",
				"price": 16,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 5.png",
				"number": 0
			},
			{
				"name": "Space 1",
				"description": "This is the description for 'Space 1'",
				"price": 100,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 1.png",
				"number": 0
			},
			{
				"name": "Space 2",
				"description": "This is the description for 'Space 2'",
				"price": 125,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 2.png",
				"number": 0
			},
			{
				"name": "Space 3",
				"description": "This is the description for 'Space 3'",
				"price": 175,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 3.png",
				"number": 0
			},
			{
				"name": "Space 4",
				"description": "This is the description for 'Space 4'",
				"price": 250,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 4.png",
				"number": 0
			},
			{
				"name": "Space 5",
				"description": "This is the description for 'Space 5'",
				"price": 300,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 5.png",
				"number": 0
			},
			{
				"name": "Z Golden Statue",
				"description": "This is the description for 'Z Golden Statue'",
				"price": 1000,
				"type": "decor",
				"file": "res://assets/images/tank decor/z golden statue.png",
				"number": 0
			},
			],
			"shop_items": [ {
				"name": "Egg",
				"description": "This is the description for the 'Egg' Item",
				"price": 10,
				"file": "res://assets/images/menus and ui/eggs icon.png"
			},
			{
				"name": "Food",
				"description": "This is the description for the 'Food' Item (I'm so creative xd)",
				"price": 5,
				"file": "res://assets/images/menus and ui/food icon.png"
			},
			],
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()


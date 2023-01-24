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
			]
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()


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
			"food": 5,
			"eggs": 3,
			"set_in_tank": {
				"status": 0, 	#0 if the player doesn't hsve to place anything, 1 in other casea
				"resource":""
			},
			"sea_monkeys": [],
			"foods": [],
			"decors": [],
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
				"name": "No fishing sign",
				"description": "No means no!",
				"price": 10,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 1.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Rocky homes",
				"description": "some hollow ceramic stones with openings on them, for Subzoos are these like appartments?",
				"price": 25,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 2.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Treasure chest",
				"description": "classic plastic treasure chest decoration, I wonder what could be inside?",
				"price": 17,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 3.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Diver helmet",
				"description": "A bit spooky, but classic, who could have this belonged to?",
				"price": 20,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 4.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Ruined pillars",
				"description": "Im sure Subzoos also have some deep rich history and ancestors...",
				"price": 30,
				"type": "decor",
				"file": "res://assets/images/tank decor/artificial 5.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Small red anemone",
				"description": "sways on the current without a care in the world.",
				"price": 20,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 1.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "yellow branch coral",
				"description": "A small coral that gives an energizing pop of tropical color.",
				"price": 25,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 2.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Small blue anemone",
				"description": "Do anemones sting Subzoos?",
				"price": 20,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 3.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "yellow sea sponge",
				"description": "Nature's greatest filters!",
				"price": 27,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 4.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Pink branch coral",
				"description": "A medium sized coral, add a cute pink touch to your tank.",
				"price": 30,
				"type": "decor",
				"file": "res://assets/images/tank decor/coral 5.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "palm trees",
				"description": "Not sure what these are doing underwater but they bring a nice tropical feel!",
				"price": 30,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 1.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "volcano",
				"description": "It's like an erruption of bubbles!",
				"price": 80,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 2.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "carved statues",
				"description": "beautiful ancient depictions of a Subzoo's life cycle.",
				"price": 35,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 3.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "small hut",
				"description": "what a cozy place to live in, it would be like a vacation every day!",
				"price": 40,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 4.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Subzoo dancer",
				"description": "Fresh and talented! those dance moves sway like ocean waves.",
				"price": 50,
				"type": "decor",
				"file": "res://assets/images/tank decor/hawaiian 5.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Red sword leaf",
				"description": "A red plant that will add a striking pop of color to your tank.",
				"price": 10,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 2.png",
				"number": 0,
				"can_move": true
			},
			{
				"name": "Green finger alga",
				"description": "Swirly and green, what more do you need!",
				"price": 8,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 3.png",
				"number": 0,
				"can_move": true
			},
			{
				"name": "Carpet seaweed",
				"description": "A cute small green plant that always stays close to the ground.",
				"price": 5,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 4.png",
				"number": 0,
				"can_move": true
			},
			{
				"name": "Pink tallgrass",
				"description": "An imposing plant with rosy leaves that reach for the skies!",
				"price": 15,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 5.png",
				"number": 0,
				"can_move": true
			},
			{
				"name": "seaweed",
				"description": "Provides perfect coverage and enrichment for your pets.",
				"price": 15,
				"type": "decor",
				"file": "res://assets/images/tank decor/plant 1.png",
				"number": 0,
				"can_move": true
			},
			{
				"name": "mossy rock",
				"description": "add a lush overgrown feel to your tank with this rock.",
				"price": 8,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 1.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Big mossy rock",
				"description": "Bring your scaping skills to the next level with bigger hardscape!",
				"price": 20,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 2.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "smooth rock",
				"description": "a big rock that gives your scape some directionality.",
				"price": 15,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 3.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "smooth pebble",
				"description": "A small rock, nothing more, nothing less.",
				"price": 5,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 4.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "big stone",
				"description": "mighty and rough, rocky and tough!",
				"price": 20,
				"type": "decor",
				"file": "res://assets/images/tank decor/rock 5.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Familiar Alien",
				"description": "These extraterrestials look familiar... something about them smell like deceipt.",
				"price": 100,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 1.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Subzoo flag",
				"description": "This world has officially been visited by Subzoos!",
				"price": 50,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 2.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "space suit",
				"description": "did you know Subzoos have actually been to space before? how cool is that!",
				"price": 150,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 3.png",
				"number": 0,
				"can_move": true
			},
			{
				"name": "shooting star",
				"description": "Make a wish!",
				"price": 150,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 4.png",
				"number": 0,
				"can_move": true
			},
			{
				"name": "U.F.O.",
				"description": "What is it doing in there? and where is it taking that other Subzoo?",
				"price": 200,
				"type": "decor",
				"file": "res://assets/images/tank decor/space 5.png",
				"number": 0,
				"can_move": false
			},
			{
				"name": "Z Golden Statue",
				"description": "This is the description for 'Z Golden Statue'",
				"price": 1000,
				"type": "decor",
				"file": "res://assets/images/tank decor/z golden statue.png",
				"number": 0,
				"can_move": false
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


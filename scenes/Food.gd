extends RigidBody2D


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()
var rot = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	rot = rng.randf_range(-.004, .004)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_child(0).rotate(rot)

extends RigidBody2D

var velocity = Vector2()
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rng.randomize()
	var x = rng.randf_range(1, 200.0)
	var y = rng.randf_range(-200.0, 200.0)
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
	
# Every time there is a timeout the sea monkey moves to a different direction
func _on_SwimTimer_timeout():
	rng.randomize()
	var x = rng.randf_range(-200.0, 200.0)
	var y = rng.randf_range(-200.0, 200.0)
	set_linear_velocity(Vector2(x,y))


func _on_SwimTimer2_timeout():
	pass # Replace with function body.

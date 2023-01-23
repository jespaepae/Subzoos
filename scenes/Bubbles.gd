extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	if self.position.y < 0:
		self.queue_free()

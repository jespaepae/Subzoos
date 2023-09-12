extends Sprite

# Pickable needs to be selected from the inspector

var can_grab = false
var grabbed_offset = Vector2()
var been_grabbed_this = false
var follow_speed = 12.0
onready var DecorTimer = self.get_parent().get_node("DecorTimer")
var mouse_x
var mouse_y
var id = 0

func _ready():
	var _button_pressed = DecorTimer.connect("timeout", self, "_on_DecorTimer_timeout")

func _process(delta):
	var been_grabbed_general = self.get_parent().get_parent().PlantBeenGrabbed
	var sprite_x = self.position.x
	var sprite_y = self.position.y
	var lowx = sprite_x - self.texture.get_width()/2.0
	var highx = sprite_x + self.texture.get_width()/2.0
	var lowy = sprite_y - self.texture.get_height()
	var highy = sprite_y + self.texture.get_height()/2.0
	can_grab = get_global_mouse_position().x >= lowx and get_global_mouse_position().x <= highx and get_global_mouse_position().y >= lowy and get_global_mouse_position().y <= highy
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab and !been_grabbed_general:
		self.get_parent().get_parent().PlantBeenGrabbed = true
		self.scale.x = 1.1
		self.scale.y = 1.1
		DecorTimer.start(0.75)
		mouse_x = get_global_mouse_position().x
		mouse_y = get_global_mouse_position().y
		
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab and been_grabbed_this:
		position = position.linear_interpolate(get_global_mouse_position() + grabbed_offset, delta * follow_speed)
		
	if Input.is_action_just_released("click"):
		if been_grabbed_this: MusicController.play_scratch_sf() # To avoid to play the sound after changing the screen
		been_grabbed_this = false
		self.get_parent().get_parent().PlantBeenGrabbed = false
		self.scale.x = 1
		self.scale.y = 1
		mouse_x = null
		mouse_y = null
		
func _on_DecorTimer_timeout():
	DecorTimer.stop()
	if(mouse_x != null and mouse_y != null):
		if(get_global_mouse_position().x >= mouse_x - 150 and get_global_mouse_position().y >= mouse_y - 150 and get_global_mouse_position().x <= mouse_x + 150 and get_global_mouse_position().y <= mouse_y + 150):
			MusicController.play_pop_sf()
			been_grabbed_this = true

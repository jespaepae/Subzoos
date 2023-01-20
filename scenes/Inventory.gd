extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TankMusic.stop()

func _on_BackButton_pressed():
	if get_tree().change_scene("res://scenes/Game.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Game scene")

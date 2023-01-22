extends AudioStreamPlayer


# Declare member variables here. Examples:
var tank_music = load("res://assets/audio/bg_music.mp3")
var shop_music = load("res://assets/audio/Shop_V1.wav")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_music():
	$Music.stream = tank_music
	$Music.play()

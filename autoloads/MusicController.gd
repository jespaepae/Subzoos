extends Node

# Declare member variables here.
var tank_music = load("res://assets/audio/bg_music.mp3")
var shop_music = load("res://assets/audio/Shop_V1.wav")
var position = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_tank_music():
	if $Music.stream == tank_music:
		position = $Music.get_playback_position()
	else:
		position = 0.0
	$Music.stop()
	$Music.stream = tank_music
	$Music.set_volume_db(-10)
	$Music.play(position)

func play_shop_music():
	$Music.stop()
	$Music.stream = shop_music
	$Music.set_volume_db(-10)
	$Music.play()

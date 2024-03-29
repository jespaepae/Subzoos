extends Node

# Declare member variables here.
var tank_music = load("res://assets/audio/subzoos_dance.mp3")
var shop_music = load("res://assets/audio/Shop_V1.wav")
var ui_clic = load("res://assets/audio/sound_effects/UI_Click.wav")
var pop = load("res://assets/audio/sound_effects/Pop.wav")
var bongo = load("res://assets/audio/sound_effects/Bongo.wav")
var chip = load("res://assets/audio/sound_effects/Chip.wav")
var cling = load("res://assets/audio/sound_effects/Cling.wav")
var scratch = load ("res://assets/audio/sound_effects/Scratch.wav")
var position = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(_delta):
	pass

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
	if $Music.stream == shop_music:
		position = $Music.get_playback_position()
	else:
		position = 0.0
	$Music.stop()
	$Music.stream = shop_music
	$Music.set_volume_db(-10)
	$Music.play(position)
	
func play_ui_clic():
	$SoundEffect.stream = ui_clic
	$SoundEffect.set_volume_db(0)
	$SoundEffect.play()
	
func play_pop_sf():
	$SoundEffect.stream = pop
	$SoundEffect.set_volume_db(-15)
	$SoundEffect.play()
	
func play_bongo_sf():
	$SoundEffect.stream = bongo
	$SoundEffect.set_volume_db(-15)
	$SoundEffect.play()
	
func play_chip_sf():
	$SoundEffect.stream = chip
	$SoundEffect.set_volume_db(-15)
	$SoundEffect.play()
	
func play_cling_sf():
	$SoundEffect.stream = cling
	$SoundEffect.set_volume_db(0)
	$SoundEffect.play(0.18)
	
func play_scratch_sf():
	$SoundEffect.stream = scratch
	$SoundEffect.set_volume_db(-15)
	$SoundEffect.play()

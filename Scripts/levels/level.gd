extends Node2D

@export var track = load("") 
func _ready():
	MusicPlayer.play_music(track)

extends Node2D

func _ready():
	# Load the specific song for this level
	var track = load("") 
	
	# Tell your Autoload to play it
	MusicPlayer.play_music(track)

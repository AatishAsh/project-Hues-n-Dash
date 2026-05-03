extends CanvasLayer
@onready var resume: Button = $Panel/VBoxContainer/Resume
@export var track = load("") 
@export var pause_track = load("") 
func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("pause_game"):
		toggle_pause()


func toggle_pause():
	# Toggle the actual pause state of the engine
	get_tree().paused = not get_tree().paused
	
	# Make the Pause Menu UI visible or invisible
	visible = get_tree().paused
	
	if visible:
		
		MusicPlayer.play_music(pause_track) 
		resume.grab_focus()
	else:
		# If unpaused: Resume the main level music
		MusicPlayer.play_music(track)

func _on_resume_pressed():
	toggle_pause()

func _on_restart_pressed():
	# !ALWAYS unpause before changing scenes
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	# !ALWAYS unpause before changing scenes
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")

func _on_x_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")

extends Control

@export var track = load("") 
func _ready():
	MusicPlayer.play_music(track)

	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")

func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/level_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

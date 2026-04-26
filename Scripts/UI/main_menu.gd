extends Control

func _ready():
	
	var menu_track = load("res://Audio/viacheslavstarostin-game-gaming-video-game-music-471936.mp3")
	MusicPlayer.play_music(menu_track)
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/level_menu.tscn")

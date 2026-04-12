extends CanvasLayer

# 1. Create an empty variable waiting to receive the path from the player
var next_level_path : String = "" 

func _ready():
	hide()

func _on_next_level_pressed() -> void:
	# ALWAYS unpause before changing scenes!
	get_tree().paused = false 
	
	# 2. Check if a path was successfully provided by the Finish Line
	if next_level_path != "":
		# 3. This is Godot's built-in command to load a new level
		get_tree().change_scene_to_file(next_level_path)
	else:
		# A safety fallback just in case you forgot to set the path in the editor
		print("WARNING: No next level path set! Restarting instead.")
		get_tree().reload_current_scene()

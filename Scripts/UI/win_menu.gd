extends CanvasLayer
@onready var next_level: Button = $Panel/VBoxContainer/NextLevel

#an empty variable waiting to receive the path from the player
var next_level_path : String = "" 
func _ready():
	hide()
	visibility_changed.connect(_on_visibility_changed)
	
func _on_visibility_changed():
	if visible:
		next_level.grab_focus()
	
func _on_next_level_pressed() -> void:
	# ALWAYS unpause before changing scenes!
	get_tree().paused = false 
	
	# Check if a path was successfully provided by the Finish Line
	if next_level_path != "":
		get_tree().change_scene_to_file(next_level_path)
	else:
		# A safety fallback just in case you forgot to set the path in the editor
		print("WARNING: No next level path set! Restarting instead.")
		get_tree().reload_current_scene()
		
func _on_main_menu_pressed():
	# ALWAYS unpause before changing scenes!
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")


func _on_x_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")

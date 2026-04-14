extends CanvasLayer
@onready var resume: Button = $Panel/VBoxContainer/Resume

func _ready():
	hide()

# This function listens for keyboard presses anywhere in the game
func _input(event):
	if event.is_action_pressed("pause_game"):
		toggle_pause()

# We make this a custom function so both the Escape key AND the Resume button can use it
func toggle_pause():
	# If it's currently paused, unpause it. If it's unpaused, pause it.
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused
	if visible:
		resume.grab_focus()

func _on_resume_pressed():
	toggle_pause()

func _on_restart_pressed():
	# ALWAYS unpause before changing scenes
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	# ALWAYS unpause before changing scenes!
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")

func _on_x_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")

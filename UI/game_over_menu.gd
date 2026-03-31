extends CanvasLayer

func _ready():
	# Hide the menu by default when the level starts
	hide()

func _on_retry_pressed() -> void:
	get_tree().paused = false # Unpause the engine
	get_tree().reload_current_scene() # Restart the level

# Connect your Quit button's 'pressed' signal here
func _on_quit_button_pressed():
	get_tree().quit() # Closes the game entirelyx

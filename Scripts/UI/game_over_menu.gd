extends CanvasLayer

@onready var title_label = $ColorRect/Panel/VBoxContainer/TitleLabel
func _ready():
	# Hide the menu by default when the level starts
	hide()

# This is the new function to change the text dynamically
func set_title(message: String):
	title_label.text = message


func _on_retry_pressed() -> void:
	get_tree().paused = false 
	get_tree().reload_current_scene()

# Your existing quit button logic
func _on_quit_button_pressed():
	get_tree().quit()

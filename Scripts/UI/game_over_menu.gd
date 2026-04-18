extends CanvasLayer
@onready var retry: Button = $ColorRect/Panel/VBoxContainer/Retry
@onready var title_label = $ColorRect/Panel/VBoxContainer/TitleLabel
func _ready():
	# Hide the menu by default when the level starts
	hide()
	visibility_changed.connect(_on_visibility_changed)
	
func _on_visibility_changed():
	if visible:
		retry.grab_focus()

#function to change the text dynamically
func set_title(message: String):
	title_label.text = message


func _on_retry_pressed() -> void:
	get_tree().paused = false 
	get_tree().reload_current_scene()

# Your existing quit button logic
func _on_quit_button_pressed():
	get_tree().quit()

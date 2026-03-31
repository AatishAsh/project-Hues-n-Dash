extends CanvasLayer

func _ready():
	hide()


func _on_next_level_pressed() -> void:
	get_tree().paused = false
	# For now, we'll just reload. We can add actual level progression next.
	get_tree().reload_current_scene()

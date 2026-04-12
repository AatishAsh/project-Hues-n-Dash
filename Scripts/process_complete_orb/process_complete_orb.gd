extends Area2D

@export var next_level_path : String = ""

func _on_body_entered(body):
	if body.has_method("win"):
		body.win(next_level_path)

extends Area2D

@export var required_color : String = "red"

func _on_body_entered(body):
	if "color" in body:
		
		# Condition 1: The player has the correct color
		if body.color == required_color:
			print("Access granted")
			
		# Condition 2: The player has the wrong color (or default)
		else:
			print("Access denied! Wrong color.")
			if body.has_method("die"):
				body.die()

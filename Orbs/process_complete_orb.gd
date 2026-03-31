extends Area2D

func _on_body_entered(body):
	# Safely check if the object that touched the finish line is the player
	if body.has_method("win"):
		body.win()
		# We don't need queue_free() because the game pauses immediately

extends Area2D

func _on_body_entered(body):
	# Check if the object that touched us has the specific shoot power function
	if body.has_method("grant_shoot_power"):
		
		# Give them the power!
		body.grant_shoot_power()
		
		# Destroy the orb so they can't pick it up twice
		queue_free()

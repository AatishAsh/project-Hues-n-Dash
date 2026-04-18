extends Area2D

@export var color : String = "red"

func _on_body_entered(body):
	# Check if the thing that touched the orb is the player
	if body.has_method("pickup_orb"):
		var was_picked_up = body.pickup_orb(color)
		
		# Only destroy the orb if the player actually accepted it
		if was_picked_up:
			queue_free()

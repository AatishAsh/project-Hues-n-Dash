extends Area2D

@export var color : String = "red"

var player_in_range = null


func _on_body_entered(body):
	if body.has_method("pickup_orb"):
		player_in_range = body
		print("player in")

func _on_body_exited(body):
	if body == player_in_range:
		player_in_range = null


func _unhandled_input(event):
	if player_in_range == null:
		return

	if event.is_action_pressed("pick_item"):
		# Try to give the orb to the player and check if they accepted it
		var was_picked_up = player_in_range.pickup_orb(color)
		
		# Only destroy the orb if the player actually picked it up
		if was_picked_up:
			queue_free()
			# This stops multiple overlapping orbs from being picked up at the exact same time
			get_viewport().set_input_as_handled()

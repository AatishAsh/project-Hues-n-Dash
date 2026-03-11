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


func _process(_delta):

	if player_in_range == null:
		return

	if Input.is_action_just_pressed("pick_item"):
		player_in_range.pickup_orb(color)
		queue_free()

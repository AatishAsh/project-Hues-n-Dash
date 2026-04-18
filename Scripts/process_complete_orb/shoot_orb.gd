extends Area2D

func _ready():
	var tween = create_tween().set_loops()
	tween.tween_property($Sprite2D, "position:y", -5.0, 1.0).as_relative().set_trans(Tween.TRANS_SINE)
	tween.tween_property($Sprite2D, "position:y", 5.0, 1.0).as_relative().set_trans(Tween.TRANS_SINE)

func _on_body_entered(body):
	
	# Check if the object that touched us has the specific shoot power function
	if body.has_method("grant_shoot_power"):
		
		# Give them the power!
		body.grant_shoot_power()
		
		# Destroy the orb so they can't pick it up twice
		queue_free()

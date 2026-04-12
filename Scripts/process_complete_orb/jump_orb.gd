extends Area2D

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var respawn_timer: Timer = $RespawnTimer
# This lets you change how high the orb launches you from the Inspector!
@export var bounce_power : float = -1000.0 

func _on_body_entered(body: Node2D) -> void:
	# Check if the player has our new double jump function
	if body.has_method("grant_double_jump"):
		body.grant_double_jump() 
		# Hide the orb and start the respawn timer (Keep your existing deactivate code!)
		deactivate()


func deactivate():
	# 1. Hide the orb visually
	sprite.visible = false
	
	# 2. Turn off the collision so the player can't touch it while invisible.
	# We MUST use set_deferred when disabling collisions inside a physics callback!
	collision.set_deferred("disabled", true)
	
	# 3. Start the countdown to bring it back
	respawn_timer.start()

func _on_respawn_timer_timeout():
	# Bring the orb back!
	sprite.visible = true
	collision.set_deferred("disabled", false)

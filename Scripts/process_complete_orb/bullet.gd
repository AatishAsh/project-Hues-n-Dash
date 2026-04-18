extends Area2D

@export var speed: float = 800.0
var direction: int = 1 # 1 means right, -1 means left

func _physics_process(delta):
	# Move the bullet continuously every frame
	position.x += direction * speed * delta

func _on_body_entered(body):
	# The bullet now ONLY kills things that have the "destroy_enemy" function!
	if body.has_method("destroy_enemy"):
		body.destroy_enemy()
		queue_free() 
		
	# Destroy bullet on walls (optional)
	elif body is TileMapLayer:
		queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	# Delete the bullet when it leaves the camera view to save memory
	queue_free()

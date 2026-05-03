extends Area2D

@export var speed: float = 800.0
var direction: int = 1 

func _physics_process(delta):
	# Move the bullet continuously every frame
	position.x += direction * speed * delta

func _on_body_entered(body):
	#only hit enemy wiht destrou_enemy()
	if body.has_method("destroy_enemy"):
		body.destroy_enemy()
		queue_free() 
		
	# Destroy bullet on walls 
	elif body is TileMapLayer:
		queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	# Delete the bullet when it leaves the camera view
	queue_free()

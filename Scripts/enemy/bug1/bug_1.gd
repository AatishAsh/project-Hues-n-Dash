extends CharacterBody2D

@export var speed := 100
@export var gravity := 900

# 1 is moving right, -1 is moving left
var direction := 1 

@onready var raycasts = $Raycastes
@onready var ledge_check = $Raycastes/LedgeCheck
@onready var wall_check = $Raycastes/WallCheck
@onready var sprite = $Sprite2D

func _physics_process(delta):
	# 1. Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. Check for ledges or walls
	# If the ledge check finds NO floor, OR the wall check hits a wall...
	if not ledge_check.is_colliding() or wall_check.is_colliding():
		flip_direction()

	# 3. Apply Movement
	velocity.x = direction * speed
	
	move_and_slide()

# Custom function to turn the enemy around
func flip_direction():
	direction *= -1 # Changes 1 to -1, or -1 to 1
	
	# Flip the visual sprite
	sprite.flip_h = (direction == -1)
	
	# Flip the raycasts so they look the other way!
	raycasts.scale.x *= -1

func _on_killzone_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		print("Enemy caught the player!")
		body.die()
		
func destroy_enemy():
	set_physics_process(false)
	$killzone/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.play("death")
	await $Sprite2D.animation_finished
	queue_free()

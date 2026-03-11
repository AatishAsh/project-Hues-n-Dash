extends CharacterBody2D

# movement settings
@export var speed := 200
@export var jump_force := -400
@export var gravity := 900
@onready var sprite: AnimatedSprite2D= $AnimatedSprite2D

# player status
var state : String = "idle"
var color : String = "default"

# single item rule
var carrying_item := false


func _physics_process(delta):

	apply_gravity(delta)
	handle_movement()
	handle_jump()
	update_state()
	update_animation()

	move_and_slide()


func apply_gravity(delta):

	if not is_on_floor():
		velocity.y += gravity * delta


func handle_movement():

	var direction = Input.get_axis("move_left", "move_right")

	velocity.x = direction * speed

	if direction != 0:
		sprite.flip_h = direction < 0


func handle_jump():

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force


func update_state():

	if not is_on_floor():
		state = "jump"

	elif velocity.x != 0:
		state = "run"

	else:
		state = "idle"


func update_animation():

	var anim = color + "_" + state

	if sprite.animation != anim:
		sprite.play(anim)


# called by orb when picked
func pickup_orb(new_color : String):

	if carrying_item:
		return

	carrying_item = true
	color = new_color
	update_animation()

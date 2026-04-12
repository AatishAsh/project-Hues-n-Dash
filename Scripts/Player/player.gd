extends CharacterBody2D

# movement settings
@export var speed := 200
@export var jump_force := -400
var can_double_jump : bool = false
@export var gravity := 900
@onready var sprite: AnimatedSprite2D= $AnimatedSprite2D
#menu
@onready var game_over_menu: CanvasLayer = $"../GameOverMenu"
@onready var win_menu: CanvasLayer = $"../WinMenu"
#timer
@export var level_time : float = 60.0
@onready var time_label = $HUD/TimeLabel
@onready var level_timer = $LevelTimer
# player status
var state : String = "idle"
var color : String = "default"

# single item rule
var carrying_item := false

func _ready():
	level_timer.wait_time = level_time
	level_timer.start()
	
func _physics_process(delta):

	time_label.text = "Time: " + str(int(level_timer.time_left))
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

	if Input.is_action_just_pressed("jump"): 
		if is_on_floor():
			# Normal jump from the ground
			velocity.y = -400 # (Use your jump variable here)
		elif can_double_jump:
			# Mid-air double jump!
			velocity.y = -400 
			can_double_jump = false # Consume the charge so they can't fly forever
			
# The orb will call this when touched
func grant_double_jump():
	can_double_jump = true
	print("Double jump charged!")
	
	# BONUS POLISH: Make the player turn blue so they know they are charged!
	#$Sprite2D.modulate = Color(0.5, 0.8, 1.0)

func update_state():

	if not is_on_floor():
		state = "jump"

	elif velocity.x != 0:
		state = "run"

	else:
		state = "idle"


func update_animation():
	var anim = color + "_" + state
	
	# Check if the specific animation (e.g., "red_run") exists
	if sprite.sprite_frames.has_animation(anim):
		if sprite.animation != anim:
			sprite.play(anim)
	else:
		# FALLBACK: If "red_run" is missing, try to at least play "red_idle"
		var fallback = color + "_idle"
		if sprite.sprite_frames.has_animation(fallback):
			if sprite.animation != fallback:
				sprite.play(fallback)
		else:
			# If even the color_idle is missing, stay on default
			push_warning("Animation missing: ", anim, " and ", fallback)


# called by orb when picked
func pickup_orb(new_color : String) -> bool:
	# Optional: Prevent picking up the exact same color you are already holding
	if carrying_item and color == new_color:
		return false

	carrying_item = true
	color = new_color
	update_animation()
	
	return true

func win(target_level: String):
	print("Level Complete! Pausing game.")
	get_tree().paused = true
	
	# Hand the path over to the menu BEFORE showing it
	win_menu.next_level_path = target_level
	win_menu.show()
	
func die(reason: String = "$FATAL_ERROR"):
	print("Player dead. Reason: ", reason)
	get_tree().paused = true
	
	# Send the custom message to the menu before showing it
	game_over_menu.set_title(reason) 
	game_over_menu.show()


func _on_level_timer_timeout() -> void:
	print("Time is up!")
	die("$TIMEOUT_ERROR.")

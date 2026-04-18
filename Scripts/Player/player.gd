extends CharacterBody2D

# movement settings
@export var speed := 200
@export var jump_force := -400
var can_double_jump : bool = false
@export var double_jump_duration: float = 5.0
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
#powerups/ui
@onready var powerup_ui: HBoxContainer = $HUD/MarginContainer/PowerupUI
@onready var powerup_icon: TextureRect = $HUD/MarginContainer/PowerupUI/PowerupIcon
@onready var powerup_bar: ProgressBar = $HUD/MarginContainer/PowerupUI/PowerupBar
@onready var powerup_timer: Timer = $PowerupTimer
@onready var double_jump_ui: HBoxContainer = $HUD/MarginContainer2/DoubleJumpUI
@onready var double_jump_icon: TextureRect = $HUD/MarginContainer2/DoubleJumpUI/DoubleJumpIcon
@onready var double_jump_bar: ProgressBar = $HUD/MarginContainer2/DoubleJumpUI/DoubleJumpBar
@onready var double_jump_timer: Timer = $DoubleJumpTimer

#-poweups---
@export var bullet_scene: PackedScene 
@export var powerup_duration: float = 10.0 
var can_shoot: bool = false
var facing_direction: int = 1 # Tracks which way the player is looking
# single item rule
var carrying_item := false

func _ready():
	level_timer.wait_time = level_time
	level_timer.start()
	powerup_ui.hide()
	double_jump_ui.hide()

func _physics_process(delta):

	time_label.text = "Time: " + str(int(level_timer.time_left))
	apply_gravity(delta)
	handle_movement()
	handle_jump()
	update_state()
	update_animation()
	shoot()
	move_and_slide()

func apply_gravity(delta):

	if not is_on_floor():
		velocity.y += gravity * delta


func handle_movement():

	var direction = Input.get_axis("move_left", "move_right")

	velocity.x = direction * speed

	if direction != 0:
		sprite.flip_h = direction < 0
	if Input.is_action_pressed("move_right"):
		facing_direction = 1
	elif Input.is_action_pressed("move_left"):
		facing_direction = -1

func shoot():
	# If the timer is actively running, shrink the UI bar to match it
	if not powerup_timer.is_stopped():
		powerup_bar.value = powerup_timer.time_left
	if Input.is_action_just_pressed("shoot") and can_shoot:
		# 1. Create a copy of the bullet
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position =$ShootPoint.global_position
		bullet.direction = facing_direction

func grant_shoot_power():
	can_shoot = true
	# Start the 10-second countdown
	$PowerupTimer.start(powerup_duration)
	print("Weapon acquired! 10 seconds on the clock!")
	powerup_bar.max_value = powerup_duration # Set the bar's max to 10 seconds
	powerup_bar.value = powerup_duration     # Fill the bar completely
	powerup_ui.show()                        # Make it visible on screen

func _on_powerup_timer_timeout():
	can_shoot = false
	powerup_ui.hide()
	print("Powerup ended!")


func handle_jump():

	if is_on_floor():
		if not double_jump_timer.is_stopped():
			can_double_jump = true  
		else:
			can_double_jump = false 

	# 2. THE JUMP LOGIC
	if Input.is_action_just_pressed("jump"): 
		if is_on_floor():
			# Normal jump from the ground
			velocity.y = -400 
			
		elif can_double_jump:
			# Mid-air double jump!
			velocity.y = -400 
			# We put this back so they only get ONE air jump before touching the floor again!
			can_double_jump = false
			
	# Add this right below it!
	if not double_jump_timer.is_stopped():
		double_jump_bar.value = double_jump_timer.time_left
		
# The orb will call this when touched
func grant_double_jump():
	can_double_jump = true
	print("Double jump charged!")
	double_jump_timer.start(double_jump_duration)
	
	# --- UI CODE ---
	double_jump_bar.max_value = double_jump_duration
	double_jump_bar.value = double_jump_duration
	double_jump_ui.show()

func _on_double_jump_timer_timeout() -> void:
	double_jump_ui.hide()

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
	
func die(reason: String = "$YOU_HAVE_DIED!_"):
	$DeathSound.play()
	print("Player dead. Reason: ", reason)
	get_tree().paused = true
	# Send the custom message to the menu before showing it
	game_over_menu.set_title(reason) 
	game_over_menu.show()


func _on_level_timer_timeout() -> void:
	print("Time is up!")
	die("$TIMEOUT!_")

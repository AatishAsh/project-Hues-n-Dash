extends Control

# We only need to grab the first button to snap the keyboard focus
@onready var level_1_button: Button = $Panel/VBoxContainer/GridContainer/Level1Button


func _ready():
	# Snap keyboard focus to Level 1 instantly when the menu opens
	level_1_button.grab_focus()

# --- LEVEL BUTTON SIGNALS ---

func _on_level_1_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")

func _on_level_2_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_2.tscn")

func _on_level_3_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_3.tscn")

func _on_level_4_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_4.tscn")

func _on_leve_5_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level_5.tscn")

func _on_level_6_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_6.tscn")

func _on_level_7_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_7.tscn")

func _on_level_8_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_8.tscn")

# --- UI NAVIGATION ---

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")

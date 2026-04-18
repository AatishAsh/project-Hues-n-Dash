extends Area2D

@export var next_level_path : String = ""

func _ready():
	var tween = create_tween().set_loops()
	tween.tween_property($Sprite2D, "position:y", -5.0, 1.0).as_relative().set_trans(Tween.TRANS_SINE)
	tween.tween_property($Sprite2D, "position:y", 5.0, 1.0).as_relative().set_trans(Tween.TRANS_SINE)
	
func _on_body_entered(body):
	if body.has_method("win"):
		body.win(next_level_path)

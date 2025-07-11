extends Node2D
func simple_tween():
	return create_tween().bind_node(self).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
func _ready():
	$Book.modulate = Color(1, 1, 1, 0)
	$Book.position = Vector2(0, 20)
	$Flip.play()
	
	var tween = simple_tween()
	tween.parallel().tween_property($Book, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.parallel().tween_property($Book, "position", Vector2(0, 0), 0.5)
	
	await get_tree().create_timer(2).timeout
	

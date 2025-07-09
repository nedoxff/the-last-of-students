extends Node2D

func _ready():
	$Overlay.visible = false
	$Book.visible = false
	
	$Overlay.self_modulate = Color(1, 1, 1, 0)
	$Book.modulate = Color(1, 1, 1, 0)
	$Book.position = Vector2(0, 20)

func tween():
	return create_tween().bind_node(self).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _on_overlay_mouse_entered() -> void:
	tween().tween_property($Trigger, "position", Vector2(0, 0), 0.5)

func _on_overlay_mouse_exited() -> void:
	tween().tween_property($Trigger, "position", Vector2(0, -40), 0.5)

func _on_overlay_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		open_notebook_ui()
		
func open_notebook_ui():
	$Overlay.visible = true
	$Book.visible = true
	var tween = tween()
	tween.tween_property($Overlay, "self_modulate", Color(1, 1, 1, 0.5), 0.5)
	tween.parallel().tween_property($Book, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.parallel().tween_property($Book, "position", Vector2(0, 0), 0.5)
	$OpenFlip.play()

var all_sections = ["People", "Items", "Thoughts"]
func set_section(section: String) -> void:
	$SectionFlip.play()
	for s in all_sections:
		get_node("Book/" + s).visible = s == section

func _on_people_button_pressed() -> void:
	set_section("People")
func _on_items_button_pressed() -> void:
	set_section("Items")
func _on_thoughts_button_pressed() -> void:
	set_section("Thoughts")
	
func _on_back_button_pressed() -> void:
	var tween = tween()
	tween.tween_property($Overlay, "self_modulate", Color(1, 1, 1, 0), 0.5)
	tween.parallel().tween_property($Book, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.parallel().tween_property($Book, "position", Vector2(0, 20), 0.5)
	tween.tween_callback(func(): 
		$Overlay.visible = false
		$Book.visible = false)
	$Close.play()

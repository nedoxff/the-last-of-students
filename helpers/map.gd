extends Node2D

func _ready():
	$Overlay.visible = false
	$Map.visible = false
	
	$Overlay.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
	$Map.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
	
	$Overlay.self_modulate = Color(1, 1, 1, 0)
	$Map.modulate = Color(1, 1, 1, 0)
	$Map.position = Vector2(0, 20)

func simple_tween():
	return create_tween().bind_node(self).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
func _on_trigger_mouse_entered() -> void:
	simple_tween().tween_property($Trigger, "position", Vector2(750, 0), 0.5)
func _on_trigger_mouse_exited() -> void:
	simple_tween().tween_property($Trigger, "position", Vector2(750, -40), 0.5)
func _on_trigger_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		open_map_ui()

func open_map_ui():
	for location in ["lecture", "hall", "library", "dean"]:
		get_node("Map/LocationsGrid/" + location).visible = Global.unlocked_locations.has(location)
	
	$Overlay.visible = true
	$Map.visible = true
	$Overlay.mouse_filter = Control.MouseFilter.MOUSE_FILTER_STOP
	$Map.mouse_filter = Control.MouseFilter.MOUSE_FILTER_STOP
	var tween = simple_tween()
	tween.tween_property($Overlay, "self_modulate", Color(1, 1, 1, 0.5), 0.5)
	tween.parallel().tween_property($Map, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.parallel().tween_property($Map, "position", Vector2(0, 0), 0.5)
	$Flip.play()

func _on_back_button_pressed() -> void:
	var tween = simple_tween()
	tween.tween_property($Overlay, "self_modulate", Color(1, 1, 1, 0), 0.5)
	tween.parallel().tween_property($Map, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.parallel().tween_property($Map, "position", Vector2(0, 20), 0.5)
	tween.tween_callback(func(): 
		$Overlay.visible = false
		$Map.visible = false
		$Overlay.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
		$Map.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE)
	$Flip.play()

func _transition_to(path: String):
	var transition = get_parent().get_node("Transition")
	if transition == null:
		get_tree().change_scene_to_file(path)
	else:
		transition.connect("animation_finished", func(which: String):
			get_tree().change_scene_to_file(path))
		transition.play("fade_out")

func _on_lecture_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_transition_to("res://scenes/lecture/lecture.tscn")
func _on_hall_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_transition_to("res://scenes/hall/hall.tscn")
func _on_library_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_transition_to("res://scenes/library/library.tscn")
func _on_dean_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_transition_to("res://scenes/dean/dean.tscn")

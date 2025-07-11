extends ColorRect

signal dropped(name: String)

var current: String = ""
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if current != "":
		get_node("../Options/%s" % current).modulate = Color(1, 1, 1, 1)
		remove_child(get_child(0))
	
	var duplicate: NinePatchRect = data.duplicate()
	current = data.name
	add_child(duplicate)
	var child = get_child(0)
	child.size = child.custom_minimum_size
	child.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
	child.scale = Vector2(1.5, 1.5)
	child.modulate = Color.WHITE
	child.set_anchors_preset(Control.PRESET_CENTER)
	child.position = Vector2.ZERO
	dropped.emit(data.name)

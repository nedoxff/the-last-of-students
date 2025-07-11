extends Control

func _get_drag_data(at_position: Vector2) -> Variant:
	var preview = Control.new()
	preview.add_child(self.duplicate())
	var child = preview.get_child(0)
	child.position = -(child.size / 2)
	set_drag_preview(preview)
	self.modulate = Color(1, 1, 1, 0)
	return self

var global_data
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_BEGIN:
		global_data = get_viewport().gui_get_drag_data()
	if what == NOTIFICATION_DRAG_END:
		if not is_drag_successful() and global_data.name == self.name:
			self.modulate = Color(1, 1, 1, 1)		

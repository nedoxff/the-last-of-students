extends Control

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(self.duplicate())
	self.modulate = Color(1, 1, 1, 0)
	return self

extends Area2D

signal clicked
@export var highlight_color: Color = Color.GOLDENROD
@export var border_radius: float = 5
@export var border_width: float = 0

@onready var sprite = $Sprite2D

var highlight = false

func _on_mouse_entered() -> void:
	highlight = true
	sprite.visible = true
	sprite.material.set_shader_parameter("highlight", highlight)

func _on_mouse_exited() -> void:
	highlight = false
	sprite.visible = false
	sprite.material.set_shader_parameter("highlight", highlight)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		clicked.emit()

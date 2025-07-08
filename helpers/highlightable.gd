extends Area2D

signal clicked
@export var highlight_color: Color = Color.GOLDENROD
@export var border_radius: float = 5
@export var border_width: float = 10

@onready var pos = $Shape.position
@onready var size = $Shape.get_shape().size

var highlight = false
var style_box: StyleBoxFlat
var tween: Tween

func _init() -> void:
	style_box = StyleBoxFlat.new()
	style_box.set_corner_radius_all(border_radius)
	style_box.border_width_left = border_width
	style_box.border_width_top = border_width
	style_box.border_width_right = border_width
	style_box.border_width_bottom = border_width

func _on_mouse_entered() -> void:
	highlight = true
	style_box.bg_color = highlight_color
	style_box.border_color = highlight_color.darkened(0.1)
	style_box.bg_color.a = 0
	style_box.border_color.a = 0
	
	tween = create_tween().set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(style_box, "bg_color:a", 0.5, 1)
	tween.parallel().tween_property(style_box, "border_color:a", 0.5, 1)
	tween.tween_property(style_box, "bg_color:a", 0, 1)
	tween.parallel().tween_property(style_box, "border_color:a", 0, 1)

func _on_mouse_exited() -> void:
	highlight = false
	tween.kill()
	
func _process(delta: float) -> void:
	queue_redraw()
	
func _draw() -> void:
	if highlight:
		var rect = Rect2(pos - Vector2(size.x / 2, size.y / 2), size)
		draw_style_box(style_box, rect)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		clicked.emit()

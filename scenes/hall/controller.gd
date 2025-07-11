extends Node2D
@export var mysterious_woman_entry: NotebookEntry
@export var guard_entry: NotebookEntry

@export var hall_poster_entry: NotebookEntry
@export var hall_paint_entry: NotebookEntry
@export var hall_sanitizer_entry: NotebookEntry

var library_scene = preload("res://scenes/library/library.tscn")

func _ready() -> void:
	if not Global.unlocked_locations.has("hall"):
		Global.unlocked_locations.push_back("hall")
		
	$Transition.play("fade_in")
	$Notebook.unlock_entry(mysterious_woman_entry)
	Dialogic.signal_event.connect(func(arg: String):
		if arg == "unlock_poster":
			$Notebook.unlock_entry(hall_poster_entry)
		elif arg == "unlock_paint":
			$Notebook.unlock_entry(hall_paint_entry)
		elif arg == "unlock_sanitizer":
			$Notebook.unlock_entry(hall_sanitizer_entry)
		elif arg == "unlock_guard":
			$Notebook.unlock_entry(guard_entry))

func _on_guard_clicked() -> void:
	Dialogic.start("hall")
func _on_paint_clicked() -> void:
	Dialogic.start("hall_paint")
func _on_sanitizer_clicked() -> void:
	Dialogic.start("hall_sanitizer")
func _on_poster_clicked() -> void:
	Dialogic.start("hall_poster")

func _on_stairs_clicked() -> void:
	create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD).tween_property($Ambience, "volume_db", -80, 1)
	$Transition.connect("animation_finished", func(which: String):
		get_tree().change_scene_to_packed(library_scene))
	$Transition.play("fade_out")

extends Node2D
@export var mysterious_woman_entry: NotebookEntry
@export var guard_entry: NotebookEntry

@export var hall_poster_entry: NotebookEntry
@export var hall_paint_entry: NotebookEntry
@export var hall_sanitizer_entry: NotebookEntry

var library_scene = preload("res://scenes/library/library.tscn")

func _ready() -> void:
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
	$Transition.connect("animation_finished", func(which: String):
		get_tree().change_scene_to_packed(library_scene))
	$Transition.play("fade_out")

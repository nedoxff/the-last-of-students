extends Node2D

@export var book_entry: NotebookEntry
@export var mirror_entry: NotebookEntry
var lecture_scene = preload("res://scenes/lecture/lecture.tscn")

func _ready() -> void:
	if not Global.unlocked_locations.has("dean"):
		Global.unlocked_locations.push_back("dean")
	
	$Transition.play("fade_in")
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_book_clicked() -> void:
	Dialogic.start("dean_book")
func _on_mirror_clicked() -> void:
	Dialogic.start("dean_mirror")
func _on_cactus_clicked() -> void:
	Dialogic.start("dean_cactus")
	
func _on_dialogic_signal(argument:String):
	if argument == "unlock_book":
		$Notebook.unlock_entry(book_entry)
	if argument == "unlock_mirror":
		$Notebook.unlock_entry(mirror_entry)

func _on_next_clicked() -> void:
	create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD).tween_property($Ambience, "volume_db", -80, 1)
	$Transition.connect("animation_finished", func(which: String):
		get_tree().change_scene_to_packed(lecture_scene))
	$Transition.play("fade_out")

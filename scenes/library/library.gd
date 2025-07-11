extends Node2D

@export var helmet_entry: NotebookEntry
@export var weird_poster_entry: NotebookEntry
@export var helping_student_entry: NotebookEntry
@export var janitor_entry: NotebookEntry
var dean_scene = preload("res://scenes/dean/dean.tscn")

func _ready() -> void:
	if not Global.unlocked_locations.has("library"):
		Global.unlocked_locations.push_back("library")
	
	$Transition.play("fade_in")
	Dialogic.signal_event.connect(func(arg: String):
		if arg == "unlock_poster":
			$Notebook.unlock_entry(weird_poster_entry)
		elif arg == "unlock_helmet":
			$Notebook.unlock_entry(helmet_entry)
		elif arg == "unlock_helping_student":
			$Notebook.unlock_entry(helping_student_entry)
		elif arg == "unlock_janitor":
			$Notebook.unlock_entry(janitor_entry))

func _on_elevator_clicked() -> void:
	create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD).tween_property($Ambience, "volume_db", -80, 1)
	$Transition.connect("animation_finished", func(which: String):
		get_tree().change_scene_to_packed(dean_scene))
	$Transition.play("fade_out")

func _on_hat_clicked() -> void:
	Dialogic.start("library_helmet")
func _on_ma_clicked() -> void:
	Dialogic.start("library_notebook")
func _on_weird_poster_clicked() -> void:
	Dialogic.start("library_weird_poster")
func _on_student_clicked() -> void:
	Dialogic.start("library_student")
func _on_janitor_clicked() -> void:
	Dialogic.start("library_janitor")

extends Node2D

@export var glove_entry: NotebookEntry
@export var mask_entry: NotebookEntry
@export var teacher_entry: NotebookEntry

func _ready():
	if not Global.unlocked_locations.has("lecture"):
		Global.unlocked_locations.push_back("lecture")
	
	Dialogic.signal_event.connect(func(arg: String):
		if arg == "unlock_glove":
			$Notebook.unlock_entry(glove_entry)
		if arg == "unlock_mask":
			$Notebook.unlock_entry(mask_entry)
		if arg == "unlock_teacher":
			$Notebook.unlock_entry(teacher_entry))
	$Transition.play("fade_in")
	
func _on_glove_clicked() -> void:
	Dialogic.start("lecture_glove")
func _on_la_clicked() -> void:
	Dialogic.start("lecture_la")
func _on_teacher_clicked() -> void:
	Dialogic.start("lecture_teacher")
func _on_stickers_clicked() -> void:
	Dialogic.start("lecture_stickers")
func _on_philosophy_clicked() -> void:
	Dialogic.start("lecture_philosophy")
func _on_mask_clicked() -> void:
	Dialogic.start("lecture_mask")

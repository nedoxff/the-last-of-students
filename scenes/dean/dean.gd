extends Node2D

@export var book_entry: NotebookEntry
@export var mirror_entry: NotebookEntry

func _ready() -> void:
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

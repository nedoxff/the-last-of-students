extends Control

var choice1 = ""
var choice2 = ""
var choice3 = ""

func _on_slot_1_dropped(name: String) -> void:
	choice1 = name
	$"../../Scribble".play()
	_check()
func _on_slot_2_dropped(name: String) -> void:
	choice2 = name
	$"../../Scribble".play()
	_check()
func _on_slot_3_dropped(name: String) -> void:
	choice3 = name
	$"../../Scribble".play()
	_check()

func _check():
	if choice1 != "" and choice2 != "" and choice3 != "":
		$NextButton.visible = true

func _add_point(what: String):
	var choice = what.split("_")[0]
	if choice == "Quarantine":
		Global.quarantine_score += 1
	elif choice == "Mystery":
		Global.mystery_score += 1
	elif choice == "Construction":
		Global.construction_score += 1

func _on_next_button_pressed() -> void:
	_add_point(choice1)
	_add_point(choice2)
	_add_point(choice3)
	self.visible = false
	$"../3".visible = true
	$"../../SectionFlip".play()

func _on_finale_reset() -> void:
	choice1 = ""
	choice2 = ""
	choice3 = ""
	$Slot1.remove_child($Slot1.get_child(0))
	$Slot2.remove_child($Slot2.get_child(0))
	$Slot3.remove_child($Slot3.get_child(0))
	for child in $Options.get_children():
		child.modulate = Color.WHITE

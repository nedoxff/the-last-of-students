extends Control

var choice = ""
func _on_slot_dropped(name: String) -> void:
	$NextButton.visible = true
	$"../../Scribble".play()
	choice = name

func _on_next_button_pressed() -> void:
	if choice == "Quarantine":
		Global.quarantine_score += 1
	elif choice == "Mystery":
		Global.mystery_score += 1
	elif choice == "Construction":
		Global.construction_score += 1
	self.visible = false
	$"../2".visible = true
	$"../../SectionFlip".play()


func _on_finale_reset() -> void:
	choice = ""
	$Slot.remove_child($Slot.get_child(0))
	for child in $Options.get_children():
		child.modulate = Color.WHITE

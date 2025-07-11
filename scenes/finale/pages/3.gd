extends Control

var choice = ""
var menu_scene = preload("res://scenes/menu/menu.tscn")

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
	
	var ending = Global.get_ending()
	if ending == "uncertain":
		$"../1".choice = ""
		$"../3".choice = ""
		$"../2".choice1 = ""
		$"../2".choice2 = ""
		$"../2".choice3 = ""
		
		Global.quarantine_score = 0
		Global.mystery_score = 0
		Global.construction_score = 0
		self.visible = false
		$"../1".visible = true
		
		push_warning("uncertain")
	else:
		Global.ending = ending
		self.visible = false
		$"..".visible = false
		$"../../Close".play()
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_packed(menu_scene)

func _on_finale_reset() -> void:
	choice = ""
	$Slot.remove_child($Slot.get_child(0))
	for child in $Options.get_children():
		child.modulate = Color.WHITE

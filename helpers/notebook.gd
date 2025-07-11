extends Node2D

signal entry_unlocked(id: String)

func _ready():
	$Overlay.visible = false
	$Book.visible = false
	
	$Overlay.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
	$Book.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
	
	$Overlay.self_modulate = Color(1, 1, 1, 0)
	$Book.modulate = Color(1, 1, 1, 0)
	$Book.position = Vector2(0, 20)

func simple_tween():
	return create_tween().bind_node(self).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _on_overlay_mouse_entered() -> void:
	simple_tween().tween_property($Trigger, "position", Vector2(1000, 0), 0.5)
func _on_overlay_mouse_exited() -> void:
	simple_tween().tween_property($Trigger, "position", Vector2(1000, -40), 0.5)
func _on_overlay_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		open_notebook_ui()
		
func open_notebook_ui():
	$Overlay.visible = true
	$Book.visible = true
	$Overlay.mouse_filter = Control.MouseFilter.MOUSE_FILTER_STOP
	$Book.mouse_filter = Control.MouseFilter.MOUSE_FILTER_STOP
	var tween = simple_tween()
	tween.tween_property($Overlay, "self_modulate", Color(1, 1, 1, 0.5), 0.5)
	tween.parallel().tween_property($Book, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.parallel().tween_property($Book, "position", Vector2(0, 0), 0.5)
	$OpenFlip.play()

var all_sections = ["People", "Items", "Thoughts"]
func set_section(section: String) -> void:
	if section == "Thoughts":
		get_node("Book/Thoughts/LeftSide").visible = Global.unlocked_entries.size() != 14
		get_node("Book/Thoughts/RightSide").visible = Global.unlocked_entries.size() == 14
	
	$SectionFlip.play()
	for s in all_sections:
		get_node("Book/" + s).visible = s == section

func _on_people_button_pressed() -> void:
	set_section("People")
func _on_items_button_pressed() -> void:
	set_section("Items")
func _on_thoughts_button_pressed() -> void:
	set_section("Thoughts")
	
func _on_back_button_pressed() -> void:
	var tween = simple_tween()
	tween.tween_property($Overlay, "self_modulate", Color(1, 1, 1, 0), 0.5)
	tween.parallel().tween_property($Book, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.parallel().tween_property($Book, "position", Vector2(0, 20), 0.5)
	tween.tween_callback(func(): 
		$Overlay.visible = false
		$Book.visible = false
		$Overlay.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
		$Book.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE)
	$Close.play()

func unlock_entry(entry: NotebookEntry) -> void:
	if Global.unlocked_entries.has(entry.id):
		return
	
	Global.unlocked_entries.push_back(entry.id)
	entry_unlocked.emit(entry.id)
	
	var in_tween = simple_tween()
	$EntryAnnouncer.modulate = Color(1, 1, 1, 0)
	$EntryAnnouncer.position = Vector2(40, 20)
	$EntryAnnouncer.visible = true
	$EntryAnnouncer/PanelContainer/RichTextLabel.text = "Добавлена новая запись:
[b]%s[/b]" % entry.name

	in_tween.tween_property($EntryAnnouncer, "modulate", Color(1, 1, 1, 1), 0.5)
	in_tween.parallel().tween_property($EntryAnnouncer, "position", Vector2(40, 40), 0.5)
	in_tween.tween_callback(func():
		await get_tree().create_timer(2).timeout
		var out_tween = simple_tween()
		out_tween.tween_property($EntryAnnouncer, "modulate", Color(1, 1, 1, 0), 0.5)
		out_tween.parallel().tween_property($EntryAnnouncer, "position", Vector2(40, 60), 0.5)
		out_tween.tween_callback(func(): $EntryAnnouncer.visible = false))
	$Scribble.play()


func _on_confirm_finale_pressed() -> void:
	pass # Replace with function body.

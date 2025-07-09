extends HBoxContainer
@export var entry: NotebookEntry = null
@export var default_texture: Texture2D = preload("res://textures/notebook_ui/unknown_entry.png")

func _ready() -> void:
	_subscribe_to_parent()
	_hydrate()
	
func _subscribe_to_parent():
	var parent = get_parent()
	while parent != null:
		if parent.name == "Notebook":
			parent.connect("entry_unlocked", func(id: String):
				if entry != null and id == entry.id:
					_hydrate())
			return
		else:
			parent = parent.get_parent()
	push_warning("failed to find Notebook parent")
	
func _hydrate():
	if entry == null:
		return
	
	var name = entry.name
	var description = entry.description
	var texture = entry.texture
	
	if not Global.unlocked_entries.has(entry.id):
		texture = default_texture
		for i in range(name.length()):
			if name[i] != ' ':
				name[i] = '?'
		for i in range(description.length()):
			if description[i] != ' ':
				description[i] = '?'
	
	$TextContainer/Title.text = name
	$TextContainer/Description.text = description
	if texture != null:
		$TextureRect.texture = texture

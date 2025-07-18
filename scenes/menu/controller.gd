extends Node2D
@export var textures: Array[Texture2D] = []
@onready var transition = $Transition

var index = 0
var outside_scene = preload("res://scenes/outside/outside.tscn")

func _ready() -> void:
	if Global.ending != "":
		$Character.texture = load("res://textures/menu/character_%s.png" % Global.ending)
	
	$Transition/ColorRect.visible = false
	$Character.visible = false
	$Title.visible = false
	$Control/ButtonsContainer.modulate = Color(1, 1, 1, 0)
	
	$Thud.connect("finished", func():
		index += 1
		if index == textures.size():
			var tween = create_tween().bind_node(self).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property($Title, "scale", Vector2(0.5, 0.5), 1)
			tween.parallel().tween_property($Title, "position", Vector2(360, 160), 1)
			tween.tween_callback(func():
				$Character.position = Vector2(970, 1025)
				$Character.visible = true
				$BG.play()
				tween = create_tween().bind_node(self).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
				tween.tween_property($Character, "position", Vector2(970, 370), 1.5)
				tween.parallel().tween_property($BG, "volume_db", 0, 1)
				tween.parallel().tween_property($Control/ButtonsContainer, "modulate", Color(1, 1, 1, 1), 1))
		else:
			$Title.texture = textures[index]
			$Thud.play())
	
	$Title.scale = Vector2(1, 1)
	$Title.position = Vector2(640, 360)
	$Title.texture = textures[0]
	
	await get_tree().create_timer(1).timeout
	$Thud.play()
	$Title.visible = true


func _on_exit_game_button_pressed() -> void:
	get_tree().quit()

func _on_start_game_button_pressed() -> void:
	Global.ending = ""
	Global.unlocked_entries = []
	Global.unlocked_locations = []
	Global.quarantine_score = 0
	Global.construction_score = 0
	Global.mystery_score = 0
	
	create_tween().tween_property($BG, "volume_db", -80, 1)
	transition.play("fade_out")

func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(outside_scene)

extends Node2D
var hall_scene = preload("res://scenes/hall/hall.tscn")

func _ready() -> void:
	$Transition.play("fade_in")
	Dialogic.start("pre_start")
	Dialogic.signal_event.connect(func(arg: String):
		if arg == "transition_hall":
			get_tree().change_scene_to_packed(hall_scene)
		elif arg == "scare":
			$CityBG.stop())

func _on_door_clicked() -> void:
	Dialogic.start("start")

extends Node2D

func _ready() -> void:
	$Transition.play("fade_in")
	Dialogic.start("pre_start")

func _on_door_clicked() -> void:
	Dialogic.start("start")

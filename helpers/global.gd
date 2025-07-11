extends Node

var unlocked_entries: Array[String] = []
var unlocked_locations: Array[String] = []

var construction_score: int = 0
var mystery_score: int = 0
var quarantine_score: int = 0

var ending: String = ""

func get_ending():
	var scores = [construction_score, mystery_score, quarantine_score]
	if scores.count(2) == 2 and scores.count(1) == 1:
		return "uncertain"
	elif scores.max() == construction_score:
		return "happy"
	elif scores.max() == mystery_score:
		return "crazy"
	elif scores.max() == quarantine_score:
		return "mask"
	push_error("impossible ending reached")

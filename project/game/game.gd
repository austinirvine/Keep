extends Node

var buttons_assigned = []
var max_button = 0

func get_button():
	buttons_assigned.append((max_button+1))
	max_button += 1
	return max_button

extends HBoxContainer

var buttons_assigned = []
var max_button = -1

signal signal1(value)
signal signal2(value)
signal signal3(value)
signal signal4(value)
signal signal5(value)

func _ready():
	emit_signal("signal1", get_button())
	emit_signal("signal2", get_button())
	emit_signal("signal3", get_button())
	emit_signal("signal4", get_button())
	emit_signal("signal5", get_button())

func get_button():
	max_button += 1
	buttons_assigned.append((max_button))
	return max_button

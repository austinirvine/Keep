extends HBoxContainer

var buttons_assigned = []
var max_button = -1

signal signal1(value)
signal signal2(value)
signal signal3(value)
signal signal4(value)
signal signal5(value)

onready var notifier_label = get_node("/root/game/interface/notifier_label")

onready var family_members = 5

func _ready():
	notifier_label.set_text("")
	emit_signal("signal1", get_button())
	emit_signal("signal2", get_button())
	emit_signal("signal3", get_button())
	emit_signal("signal4", get_button())
	emit_signal("signal5", get_button())

func _process(delta):
	if family_members <= 0:
		family_members = 5
		notifier_label.set_text("Your family is dead. You lose.")
		Global.lose("Your family perished while in your paws.")

func get_button():
	max_button += 1
	buttons_assigned.append((max_button))
	return max_button

func lost_family_member(name):
	family_members -= 1
	notifier_label.set_text(name + " just died. You have " + str(family_members) + " left.")
	# send signal to label saying "so and so died"

func _on_family_member_member_died(value):
	lost_family_member(value)
	pass # Replace with function body.


func _on_family_member2_member_died(value):
	lost_family_member(value)
	pass # Replace with function body.


func _on_family_member3_member_died(value):
	lost_family_member(value)
	pass # Replace with function body.


func _on_family_member4_member_died(value):
	lost_family_member(value)
	pass # Replace with function body.


func _on_family_member5_member_died(value):
	lost_family_member(value)
	pass # Replace with function body.

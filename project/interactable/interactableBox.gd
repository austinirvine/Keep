extends interactable

export(NodePath) var light
export var picked_up = false

onready var grab = picked_up

var playerCamera

func get_interaction_text():
	return "Grab Object" if grab else "Drop Object"

func interact():
	grab = !grab
	if grab:
		set_to_hold()

func set_to_hold():
	# get node to follow for grab transform
	#playerCamera =
	pass

func _physics_process(delta):
	if grab:
		#set transform to that stored node
		pass
	pass

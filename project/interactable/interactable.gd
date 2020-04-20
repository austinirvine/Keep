extends Node

class_name interactable

var sled_collider
var draggable = true
var dragging = false
var on_sled = false
var colliding_with_sled = false
var parent

onready var root_at_start = self

func _physics_process(delta):
	if on_sled and colliding_with_sled:
		var trans = sled_collider.get_global_transform()
		trans.origin = trans.origin + sled_collider.get_global_transform().basis.z
		root_at_start.set_transform(trans)
		return

	if dragging:
		var trans = parent.get_global_transform()
		trans.origin = trans.origin - parent.get_child(0).get_global_transform().basis.z * 4
		root_at_start.set_transform(trans)
		return

func get_interaction_text():
	return "Interact"

func get_sled_text():
	return "Drop On"

func interact():
	print("Interacted with %s" % name)

func drop_interact():
	print("Drop on %s" % name)

func drag(parent_node):
	parent = parent_node
	dragging = true

func drop():
	parent = root_at_start
	dragging = false

func drop_on_sled():
	parent = root_at_start
	dragging = false
	on_sled = true

func get_draggable():
	return draggable

func _on_Area_area_entered(area):
	if on_sled:
		return

	if area.get_parent() is sled and !on_sled:
		sled_collider = area.get_parent()
		colliding_with_sled = true
	else:
		colliding_with_sled = false
		sled_collider = null

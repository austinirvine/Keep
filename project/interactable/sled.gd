extends Node

class_name sled

var obj_in_cargo
var has_cargo = false
var draggable = true
var dragging = false
var parent

onready var root_at_start = self

func _physics_process(delta):
	if dragging:
		var trans = parent.get_global_transform()
		trans.origin = trans.origin + parent.get_child(0).get_global_transform().basis.z * 2
		root_at_start.set_transform(trans)

func get_interaction_text():
	return "Interact"

func get_object_from_sled_text():
	return "Get Item"

func interact():
	print("Interact with %s" % name)

func interact_cargo():
	print("Interact with cargo on %s" % name)

func drag(parent_node):
	parent = parent_node
	dragging = true
	pass

func drop():
	parent = root_at_start
	dragging = false
	pass

func get_draggable():
	return draggable

func add_cargo(obj):
	obj_in_cargo = obj
	has_cargo = true

func get_cargo():
	var temp_obj = obj_in_cargo
	obj_in_cargo = null
	has_cargo = false
	return temp_obj

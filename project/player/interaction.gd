extends RayCast

export(NodePath) var effect_player

var current_collider
var sled_collider
var object_collider
var colliding_with_sled = false
var sled_has_cargo = false

onready var interaction_label = get_node("/root/game/interface/interaction_label")
onready var has_sled = false
onready var has_object = false

func _ready():
	effect_player = get_node(effect_player)
	set_interaction_text("")

func _process(delta):
	var collider = get_collider()
	var cont = true

	if is_colliding():
		if collider is interactable:
			if !interactable_collision(collider):
				return
		elif collider is sled:
			if !sled_collision(collider):
				return
	elif current_collider and colliding_with_sled:
		current_collider = null
		set_interaction_text("")
	elif current_collider:
		current_collider = null

	placing_objects(collider)

func set_interaction_text(text):
	if !text:
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else:
		var interact_key = OS.get_scancode_string(InputMap.get_action_list("Interact")[0].scancode)
		interaction_label.set_text("Press %s to %s" % [interact_key, text])
		interaction_label.set_visible(true)

func interactable_collision(collider):
	object_collider = collider
	if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider

	if object_collider and object_collider.colliding_with_sled:
		colliding_with_sled = true
		set_interaction_text(collider.get_sled_text())
	else:
		colliding_with_sled = false

	if Input.is_action_just_pressed("Interact"):
		pickup_toy_with_sound()
		if !colliding_with_sled:
			collider.interact()
			has_object = true
			object_collider = collider
			if collider.get_draggable() and !collider.dragging:
				collider.drag(self.get_parent().get_parent())
				set_interaction_text(collider.get_interaction_text())
			return false
	return true

func sled_collision(collider):
	sled_collider = collider
	if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider

	if sled_collider and sled_collider.has_cargo:
		sled_has_cargo = true
		current_collider = sled_collider
		set_interaction_text(collider.get_object_from_sled_text())
	else:
		sled_has_cargo = false

	if Input.is_action_just_pressed("Drop"):
		collider.interact()
		if collider.get_draggable() and !collider.dragging:
			has_sled = true
			sled_collider = collider
			collider.drag(self.get_parent().get_parent())
			set_interaction_text(collider.get_interaction_text())
			return false
	if Input.is_action_just_pressed("Interact") and sled_has_cargo:
		collider.interact_cargo()
		var obj = collider.get_cargo()
		object_collider.colliding_with_sled = false
		set_interaction_text(collider.get_object_from_sled_text())
		current_collider = obj
		obj.interact()
		if obj.get_draggable() and !obj.dragging:
			has_object = true
			obj.drag(self.get_parent().get_parent())
			set_interaction_text(obj.get_interaction_text())
		return false
	return true

func placing_objects(collider):
	if has_sled and Input.is_action_just_pressed("Drop"):
		if sled_collider.dragging:
			sled_collider.drop()
			has_sled = false
			set_interaction_text(sled_collider.get_interaction_text())

	if has_object and Input.is_action_just_pressed("Interact"):
		if object_collider.dragging:
			if object_collider.colliding_with_sled and !object_collider.on_sled:
				if sled_collider == null:
					sled_collider = object_collider.sled_collider
				object_collider.drop_on_sled()
				sled_collider.add_cargo(object_collider);
				has_object = false
				pass
			else:
				object_collider.drop()
				set_interaction_text(object_collider.get_interaction_text())
				has_object = false
				set_interaction_text("")

func pickup_toy_with_sound():
	effect_player.play()
	pass

extends interactable

func get_interaction_text():
	return "Grab Object" if !dragging else "Drop Object"

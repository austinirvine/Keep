extends Control

export(NodePath) var lose_label
export(NodePath) var lose_text
export(NodePath) var win_label

# Called when the node enters the scene tree for the first time.
func _ready():
	lose_label = get_node(lose_label)
	lose_text = get_node(lose_text)
	win_label = get_node(win_label)
	hide()
	Global.connect("lose", self, "lose")
	Global.connect("victory", self, "victory")

func lose(value):
	lose_label.set_visible(true)
	lose_text.set_text(value)
	win_label.set_visible(false)
	show()
	pass

func win(value):
	lose_label.set_visible(true)
	win_label.set_visible(false)
	show()
	pass

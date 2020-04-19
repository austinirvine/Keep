extends Control

export(NodePath) var player

var transitioning = false

func _ready():
	Global.connect("start", self, "_on_start")
	player = get_node(player)
	player.connect("_on_death", self, "_on_restart")
	$AnimationPlayer.play("fade")

func _on_animation_finished(anim):
	pass

func _input(event):
	if transitioning:
		return

	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_SPACE and visible:
			yield(get_tree(), "idle_frame")
			Global.emit_signal("start")

		if event.scancode == KEY_ESCAPE:
			if visible:
				get_tree().quit()
			else:
				yield(get_tree(), "idle_frame")
				get_tree().change_scene("res://game/game.tscn")

func _on_start():
	hide()

func _on_restart():
	show()

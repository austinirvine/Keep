extends Node

signal start
signal victory
signal lose

func _ready():

	yield(get_tree(), "idle_frame")
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.connect("finished", $AudioStreamPlayer, "play")
	$AudioStreamPlayerMusic.play()
	$AudioStreamPlayerMusic.connect("finished", $AudioStreamPlayerMusic, "play")

func victory():
	print("you win")
	$AudioStreamPlayer.stop()
	$AudioStreamPlayerMusic.stop()
	$VictoryPlayer.play()
	emit_signal("win")

func lose():
	print("you lose...")
	emit_signal("lose")

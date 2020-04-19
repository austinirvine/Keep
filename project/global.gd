extends Node

signal start
signal victory
signal lose

func _ready():
	$AudioStreamPlayer.play()
	#$AudioStreamPlayer.connect("finished", $AudioStreamPlayer, "play")

func victory():
	$AudioStreamPlayer.stop()
	#$VictoryPlayer.play()
	#$VictoryPlayer.connect("finished", $VictoryPlayer, "play")
	emit_signal("win")

func lose():
	emit_signal("lose")

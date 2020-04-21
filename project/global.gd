extends Node

var dialogs = [load("res://audio/dialog/Rabbit-Dialog-1.wav"),load("res://audio/dialog/Rabbit-Dialog-2.wav"),load("res://audio/dialog/Rabbit-Dialog-3.wav"),load("res://audio/dialog/Rabbit-Dialog-4.wav")]

signal start
signal victory
signal lose(value)

onready var dialog_clip = 0

func _ready():

	yield(get_tree(), "idle_frame")
	$VictoryPlayer.stop()
	$LosePlayer.stop()
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.connect("finished", $AudioStreamPlayer, "play")
	play_next_dialog()

func victory():
	print("you win")
	$AudioStreamPlayer.stop()
	$AudioStreamPlayerMusic.stop()
	$VictoryPlayer.play()
	emit_signal("win")

func lose(value):
	print("you lose...")
	$AudioStreamPlayer.stop()
	$AudioStreamPlayerMusic.stop()
	$LosePlayer.play()
	emit_signal("lose", value)

func _on_Dialog_finished():
	dialog_clip += 1
	play_next_dialog()

func play_next_dialog():
	print("next clips")
	if dialog_clip < 4:
		$Dialog.set_stream(dialogs[dialog_clip])
		$Dialog.play()
	else:
		$AudioStreamPlayerMusic.play()
		$AudioStreamPlayerMusic.connect("finished", $AudioStreamPlayerMusic, "play")

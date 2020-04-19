extends Node

func _ready():
	Global.connect("start", self, "_on_start")

func _on_start():
	pass

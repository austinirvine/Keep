extends Control

signal death()
signal reduceHealth(value)
signal addToHealth(value)

func _on_healthbar_death():
	emit_signal("death")

func _on_player_healthAdd(value):
	emit_signal("addToHealth", value)

func _on_player_healthHit(value):
	emit_signal("reduceHealth", value)

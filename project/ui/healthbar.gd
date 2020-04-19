extends HBoxContainer

export(NodePath) var health_bar
export(NodePath) var health_label

var health = 100

signal death()

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar = get_node(health_bar)
	health_label = get_node(health_label)
	health = 100
	set_health()

func reduce_health(value):
	health -= value
	set_health()

func add_health(value):
	health += value
	set_health()

func reset_health():
	health = 100
	set_health()

func set_health():
	health_label.set_text(str(health))
	health_bar.value = health

func _process(delta):
	if health <= 0:
		#resusitate rabbit lol
		emit_signal("death")

func _on_interface_addToHealth(value):
	add_health(value)

func _on_interface_reduceHealth(value):
	reduce_health(value)

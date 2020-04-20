extends Spatial

onready var number_of_objects = 0
onready var alphie = get_node("/root/game/interface/itemsCollected/collectable/inactive")
onready var circuit = get_node("/root/game/interface/itemsCollected/collectable2/inactive")
onready var battery = get_node("/root/game/interface/itemsCollected/collectable3/inactive")

func _process(delta):
	if number_of_objects >= 3:
		number_of_objects = 0
		Global.victory()

func _on_Area_area_entered(area):
	var name = area.get_parent().obj_name
	cross_check_object(name)
	pass # Replace with function body.

func cross_check_object(name):
	if name == "alphie":
		alphie.set_visible(false)
	elif name == "battery":
		battery.set_visible(false)
	elif name == "circuit":
		circuit.set_visible(false)
	number_of_objects+=1
	print(str(number_of_objects))

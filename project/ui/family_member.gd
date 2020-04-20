extends Control

export(NodePath) var timer
export(NodePath) var timer_progress
export(NodePath) var life_button
export(NodePath) var bunny_dead
export(NodePath) var bunny_label

signal timeout #game is paused

enum {TIME_START, TIME_RUNNING, TIMEOUT, DEAD, TIME_RESET, TIME_WIN}
var time_state = TIMEOUT

var button_to_use = 0
var buttons = ["family_member1", "family_member2", "family_member3", "family_member4", "family_member5"]

var name_prefix = ["Grandpa", "Grandma", "Pa", "Ma", "Brother", "Sister", "Baby", "Ernest", "Honored", "Mr.", "Dr.", "Mrs.", "Big", "Fat"]
var name_first_male = ["Ed", "George", "Bob", "Mike", "Bill", "Mike", "Greg", "Brad", "Chad", "Nester", "Booba", "Lee", "Austin", "Edward", "Brian", "Nico", "Abe", "Mac", "Cotton"]
var name_first_female = ["Brenda", "Becky", "Natalie", "Sandra", "Cindy", "Sarah", "Billie", "Genevieve", "Bonnie", "Alice", "Emily", "Jasmine", "Candy", "Rhonda", "Ellen", "Jennifer"]
var name_last = ["Patch", "Furcoat", "Cottontale", "Dirt", "Graseed", "Carote", "Fatfoot", "Baggins", "Gamgee", "Killer", "Picard", "Kirk", "Janeway", "Skywalker", "Kirasawa", "Ballchinian", "Lightfoot"]

func _ready():
	randomize()
	timer = get_node(timer)
	timer_progress = get_node(timer_progress)
	life_button = get_node(life_button)
	bunny_label = get_node(bunny_label)
	bunny_dead = get_node(bunny_dead)
	timer.connect("timeout", self, "_on_timeout")
	start_with_name()
	Global.connect("start", self, "_on_start")

func _on_start():
	bunny_dead.visible = false
	run_timer()

func _process(delta):
	if time_state == DEAD or time_state == TIMEOUT:
		return

	if timer_progress.value >= 100:
		time_state = DEAD
		died()

	if time_state == TIME_WIN:
		timer_progress.value = 0
	elif time_state == TIME_RUNNING:
		timer_progress.value = ((timer.wait_time - timer.time_left) / timer.wait_time) * 100.0
	elif time_state == DEAD:
		timer_progress = 100
	else:
		timer_progress.value = 0

	#emit_signal("timeout_strength", float(timer_progress.value) / 100.0)

func _input(event):
	if time_state == DEAD:
		return

	if event.is_action_released(buttons[button_to_use]):
		run_timer()
		pass

func start_with_name():
	var name_of_bunny = ""
	var first_name = ""
	var number_of_names = randi() % 3
	var prefix_value = randi() % name_prefix.size()
	var last_value = randi() % name_last.size()
	var prefix = name_prefix[prefix_value]
	var last_name = name_last[last_value]

	if (randi() % 2) == 0:
		var first_value = randi() % name_first_male.size()
		first_name = name_first_male[first_value]
	else:
		var first_value = randi() % name_first_female.size()
		first_name = name_first_female[first_value]

	if number_of_names == 2:
		name_of_bunny = first_name + " " + last_name
	elif number_of_names == 1:
		name_of_bunny = prefix + " " + first_name
	else:
		name_of_bunny = first_name
	bunny_label.set_text(name_of_bunny)

func run_timer():
	time_state = TIME_RUNNING
	timer_progress.value = 0
	timer.start()

func pause_timer():
	timer.stop()

func died():
	bunny_dead.visible = true

func _on_LifeButton_pressed():
	if time_state != DEAD:
		run_timer()

func _on_family_bar_signal1(value):
	button_to_use = value

func _on_family_bar_signal2(value):
	button_to_use = value

func _on_family_bar_signal3(value):
	button_to_use = value

func _on_family_bar_signal4(value):
	button_to_use = value

func _on_family_bar_signal5(value):
	button_to_use = value

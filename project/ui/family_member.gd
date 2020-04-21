extends Control

export(NodePath) var timer
export(NodePath) var timer_progress
export(NodePath) var life_button
export(NodePath) var bunny_dead
export(NodePath) var bunny_label
export(NodePath) var bunny_image

var images_male = [load("res://ui/sprites/rabbits/male1.png"), load("res://ui/sprites/rabbits/male2.png"), load("res://ui/sprites/rabbits/male3.png"), load("res://ui/sprites/rabbits/male4.png"), load("res://ui/sprites/rabbits/male5.png"), load("res://ui/sprites/rabbits/male6.png")]
var image_female = load("res://ui/sprites/rabbits/female1.png")
signal timeout #game is paused
signal member_died(value)

enum {TIME_START, TIME_RUNNING, TIMEOUT, DEAD, TIME_RESET, TIME_WIN}
var time_state = TIMEOUT

var button_to_use = 0
var buttons = ["family_member1", "family_member2", "family_member3", "family_member4", "family_member5"]

var name_prefix_male = ["Grandpa", "Fater", "Papa", "Brother", "Baby", "Ernest", "Dumb", "Mr.", "Dr.", "Mrs.", "Big", "Fat"]
var name_prefix_female = ["Grandma", "Momma", "Sister", "Aunt", "Fat", "Sassy", "Baby"]
var name_first_male = ["Ed", "George", "Bob", "Greg", "Brad", "Chad", "Nester", "Lee", "Austin", "Edward", "Brian", "Dick", "Abe", "Mac", "Cotton"]
var name_first_female = ["Brenda", "Becky", "Natalie", "Sandra", "Cindy", "Sarah", "Billie", "Genevieve", "Bonnie", "Alice", "Emily", "Jasmine", "Candy", "Rhonda", "Ellen", "Jennifer"]
#var name_last = ["Patch", "Furcoat", "Cottontale", "Dirt", "Graseed", "Carote", "Fatfoot", "Baggins", "Gamgee", "Killer", "Picard", "Kirk", "Janeway", "Skywalker", "Kirasawa", "Ballchinian", "Lightfoot"]

onready var name_of_bunny = ""

func _ready():
	randomize()
	timer = get_node(timer)
	timer_progress = get_node(timer_progress)
	life_button = get_node(life_button)
	bunny_label = get_node(bunny_label)
	bunny_dead = get_node(bunny_dead)
	bunny_image = get_node(bunny_image)
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
	var first_name = ""
	var number_of_names = randi() % 3
	var prefix_value_male = randi() % name_prefix_male.size()
	var prefix_value_female = randi() % name_prefix_female.size()
	#var last_value = randi() % name_last.size()
	var prefix_male = name_prefix_male[prefix_value_male]
	var prefix_female = name_prefix_female[prefix_value_female]
	var image_index = randi() % 6

	if (randi() % 2) == 0:
		var first_value = randi() % name_first_male.size()
		first_name = name_first_male[first_value]
		name_of_bunny = prefix_male + " " + first_name
		bunny_image.set_texture(images_male[image_index])
	else:
		var first_value = randi() % name_first_female.size()
		first_name = name_first_female[first_value]
		name_of_bunny = prefix_female + " " + first_name
		bunny_image.set_texture(image_female)

	bunny_label.set_text(name_of_bunny)

func run_timer():
	var rand_wait_time = randi() % 20 + 10
	timer.set_wait_time(rand_wait_time)
	time_state = TIME_RUNNING
	timer_progress.value = 0
	timer.start()

func pause_timer():
	timer.stop()

func died():
	bunny_dead.visible = true
	emit_signal("member_died", name_of_bunny)

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

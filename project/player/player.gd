extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 40
export var mouse_sensitivity = 0.3

onready var body = $CollisionShape
onready var body_mesh = $CollisionShape/MeshInstance
onready var camera = $CollisionShape/Camera

var velocity = Vector3()
var lock = true

signal healthHit(value)
signal healthAdd(value)
signal _on_death()

var camera_x_rotation = 0
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.connect("start", self, "_on_start")

func _on_start():
	lock = !lock

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if lock:
		return
	if event is InputEventMouseMotion:
		body.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -50 and camera_x_rotation + x_delta < 50:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _physics_process(delta):
	if lock:
		return

	var body_basis = body.get_global_transform().basis

	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= body_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += body_basis.z

	if Input.is_action_pressed("move_left"):
		direction -= body_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += body_basis.x

	direction = direction.normalized()

	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power

	velocity = move_and_slide(velocity, Vector3.UP)

func attacked(value):
	emit_signal("healthHit", value)

func addHealth(value):
	emit_signal("healthAdd", value)

func _on_interface_death():
	emit_signal("_on_death")
	Global.lose()
	pass # Replace with function body.

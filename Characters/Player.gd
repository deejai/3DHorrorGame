extends CharacterBody3D

class_name Player

@onready var camera: Camera3D = $CameraNode/Camera3D
@onready var grab_ray: RayCast3D = $CameraNode/Camera3D/GrabRay
var camera_dist_first: float = 0.0
var camera_dist_third: float = 1.0
var camera_dist: float = camera_dist_first
var camera_y_diff: float

@onready var pause_menu: PauseMenu = $PauseMenu

const SPEED = 2.5
const JUMP_VELOCITY = 4.5
const mouse_sens: float = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var direction: Vector3 = Vector3.ZERO

func _ready():
#	get_viewport().warp_mouse(Vector2(ProjectSettings.get("display/window/size/viewport_width")/2, ProjectSettings.get("display/window/size/viewport_height")))
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera_y_diff = camera.position.y - position.y

func _process(delta):
	if Input.is_action_just_pressed("DEBUG_toggle_perspective"):
		camera_dist = camera_dist_third if camera_dist == camera_dist_first else camera_dist_first

	if Input.is_action_just_pressed("use") and grab_ray.is_colliding():
		var obj = grab_ray.get_collider()
		if obj is InteractiveArea:
			print("interact!")
			obj.interact()
		else:
			print(obj)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	camera.position = position + Vector3.UP * camera_y_diff + Vector3.FORWARD.rotated(Vector3.UP, camera.rotation.y) * -camera_dist

func _input(event):
	if event is InputEventMouseMotion:
		# up and down camera rotation
		camera.rotation.x = clampf(camera.rotation.x - (event.relative.y * mouse_sens * PI/1000), -PI/2, PI/2)

		# left right body rotation
		rotation.y = rotation.y - (event.relative.x * mouse_sens * PI/1000)
		camera.rotation.y = rotation.y

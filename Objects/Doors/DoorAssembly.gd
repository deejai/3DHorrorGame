extends Node3D

class_name DoorAssembly

@export var closed_angle: float = fmod(-32.6 * PI / 180.0, 2.0 * PI)
@export var open_angle_diff: float = fmod(PI / 2.0, 2.0 * PI)
var open_angle: float = fmod(closed_angle + open_angle_diff, 2.0 * PI)

@export var door_node: Node3D

enum State {OPENED, CLOSED}
@export var state: State = State.CLOSED
var in_motion: bool = false

@export var open_progress: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_door_angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_motion:
		match state:
			State.OPENED:
				var updated_progress: float = lerp(open_progress, 1.0, 1-pow(0.05, delta))
				if open_progress > .995:
					open_progress = 1.0
					in_motion = false
				else:
					open_progress = updated_progress

			State.CLOSED:
				var updated_progress: float = lerp(open_progress, 0.0, 1-pow(0.05, delta))
				if open_progress < 0.005:
					open_progress = 0.0
					in_motion = false
				else:
					open_progress = updated_progress

		update_door_angle()

func openclose():
	in_motion = true
	state = State.OPENED if state == State.CLOSED else State.CLOSED

func update_door_angle():
	door_node.rotation.y = closed_angle + open_angle_diff * open_progress

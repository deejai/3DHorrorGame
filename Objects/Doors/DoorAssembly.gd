extends Node3D

class_name DoorAssembly

@export var closed_angle: float = fmod(-32.6 * PI / 180.0, 2.0 * PI)
@export var open_angle_diff: float = fmod(PI / 2.0, 2.0 * PI)
var open_angle: float = fmod(closed_angle + open_angle_diff, 2.0 * PI)

@export var door_node: Node3D
@export var closed_static_body: StaticBody3D
var closed_static_collision_mask: int = 0b0
var closed_static_collision_layer: int = 0b0

enum State {OPENED, CLOSED}
@export var state: State = State.CLOSED
var in_motion: bool = false

@export var open_progress: float = 0.0

var being_traversed_by_npc: bool = false

func _ready():
    closed_static_collision_mask = closed_static_body.collision_mask
    closed_static_collision_layer = closed_static_body.collision_layer
    update_door_angle()

func _process(delta):
    if being_traversed_by_npc:
        state = State.OPENED
        if open_progress < 1.0:
            in_motion = true

    if in_motion:
        match state:
            State.OPENED:
                var updated_progress: float = lerp(open_progress, 1.0, 1-pow(0.05, delta))
                if open_progress > .995:
                    open_progress = 1.0
                    in_motion = false
                else:
                    open_progress = updated_progress

                if open_progress > 0.3:
                    closed_static_body.collision_layer = 0

            State.CLOSED:
                var updated_progress: float = lerp(open_progress, 0.0, 1-pow(0.05, delta))
                if open_progress < 0.005:
                    open_progress = 0.0
                    in_motion = false
                else:
                    open_progress = updated_progress

                if open_progress < 0.3:
                    closed_static_body.collision_layer = closed_static_collision_layer

        update_door_angle()

func openclose():
    in_motion = true
    state = State.OPENED if state == State.CLOSED else State.CLOSED

func update_door_angle():
    door_node.rotation.y = closed_angle + open_angle_diff * open_progress

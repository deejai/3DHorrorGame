extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

var is_traversing_door: bool = false
var door_assembly_being_traversed: DoorAssembly = null
var door_traversal_points: Array[Vector3]
var active = false

@onready var animation_player: AnimationPlayer = $ladymonstermodel/AnimationPlayer

func _ready():
    animation_player.current_animation = "Action"
    animation_player.autoplay

func _process(delta):
    pass

func _physics_process(delta):
    if not active:
        return

    # stop traversing door and resume normal pathfinding if we made it through the door
    if is_traversing_door:
        var mypos_2d: Vector2 = Vector2(global_position.x, global_position.z)
        var targetpos_2d: Vector2 = Vector2(door_traversal_points[0].x, door_traversal_points[0].z)
        if mypos_2d.distance_squared_to(targetpos_2d) < 0.03 + (1.0 if len(door_traversal_points) == 1 else 0.0):
            print("Traversed the door")
            door_assembly_being_traversed.being_traversed_by_npc = false
            door_traversal_points.pop_front()
            if door_traversal_points.is_empty():
                is_traversing_door = false

    if is_traversing_door:
        if door_assembly_being_traversed.open_progress > 0.98:
            var dir_3d: Vector3 = global_position.direction_to(door_traversal_points[0])
            velocity = Vector3(dir_3d.x, 0.0, dir_3d.z).normalized() * 1.0
        else:
            velocity = Vector3.ZERO
    else:
        velocity = global_position.direction_to(nav_agent.get_next_path_position()) * 1.0

    if velocity.length() > 0:
        var target_rotation = atan2(velocity.x, velocity.z)
        $ladymonstermodel.rotation.y = lerp_angle($ladymonstermodel.rotation.y, target_rotation, 1.0 * delta)

    move_and_slide()


func _on_nav_timer_timeout():
    nav_agent.target_position = Main.game.player.global_position


func _on_navigation_agent_3d_link_reached(details):
    var link = details.owner
    if link is DoorNavLink and is_traversing_door == false:
        is_traversing_door = true
        door_assembly_being_traversed = link.door_assembly
        door_assembly_being_traversed.being_traversed_by_npc = true
        door_traversal_points = [details.link_entry_position, details.link_exit_position]

func despawn():
    position.y = -10.0
    set("axis_lock_linear_y", true)
    active = false

func spawn():
    position.y = 0.3
    set("axis_lock_linear_y", false)
    active = true

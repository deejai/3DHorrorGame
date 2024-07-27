extends CharacterBody3D

class_name Player

@onready var camera_node: Node3D = $CameraNode/Camera3D
@onready var grab_ray: RayCast3D = $CameraNode/Camera3D/GrabRay
var camera_dist_first: float = 0.0
var camera_dist_third: float = 1.0
var camera_dist: float = camera_dist_first

@onready var pause_menu: PauseMenu = $PauseMenu
@onready var gui: CanvasLayer = $GUI
@onready var inventory_canvas_node: CanvasLayer = $GUI/Inventory
@onready var inventory_control_node: SubViewportContainer = $GUI/Inventory/SubViewportContainer
@onready var inventory_display_node: Node3D = $GUI/Inventory/SubViewportContainer/SubViewport/InventoryDisplay

const DEFAULT_SPEED: float = 2.5
var speed = 2.5
const JUMP_VELOCITY = 4.5
const mouse_sens: float = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var direction: Vector3 = Vector3.ZERO

var prev_position: Vector3

@onready var delay_input_timer: Timer = $DelayInputTimer

var inventory_items: Dictionary = {}

func _ready():
#	get_viewport().warp_mouse(Vector2(ProjectSettings.get("display/window/size/viewport_width")/2, ProjectSettings.get("display/window/size/viewport_height")))
    prev_position = position
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
    if !delay_input_timer.is_stopped():
        return

    if Input.is_action_just_pressed("DEBUG_toggle_perspective"):
        camera_dist = camera_dist_third if camera_dist == camera_dist_first else camera_dist_first

    if not inventory_canvas_node.visible:
        if Input.is_action_just_pressed("use") and grab_ray.is_colliding():
            var obj = grab_ray.get_collider()
            if obj is InteractiveArea:
                print("interact!")
                if obj.get_parent() is InventoryItem:
                    print("Its an inventory item!!")
                    pickup_item(obj.get_parent())
                else:
                    obj.interact()
            else:
                print(obj)

        if Input.is_action_just_pressed("ui_accept"):
            if Main.game.ghost.active:
                Main.game.ghost.despawn()
            else:
                Main.game.ghost.spawn()

    if Input.is_action_just_pressed("open_inventory"):
        inventory_canvas_node.visible = !inventory_canvas_node.visible
        Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if inventory_canvas_node.visible else Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y -= gravity * delta

    if not inventory_canvas_node.visible:
        # Handle Jump.
        if Input.is_action_just_pressed("ui_accept") and is_on_floor():
            velocity.y = JUMP_VELOCITY

        # Get the input direction and handle the movement/deceleration.
        # As good practice, you should replace UI actions with custom gameplay actions.
        var input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
        direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
        if direction:
            velocity.x = direction.x * speed
            velocity.z = direction.z * speed
        else:
            velocity.x = move_toward(velocity.x, 0, speed)
            velocity.z = move_toward(velocity.z, 0, speed)

    move_and_slide()

func _input(event):
    if !delay_input_timer.is_stopped():
        return

    if not inventory_canvas_node.visible:
        if event is InputEventMouseMotion:
            # up and down camera rotation
            camera_node.rotation.x = clampf(camera_node.rotation.x - (event.relative.y * mouse_sens * PI/1000), -PI/2, PI/2)

            # left right body rotation
            rotation.y = rotation.y - (event.relative.x * mouse_sens * PI/1000)

func use_key(name: String):
    var key_to_use = inventory_items.get(name)
    if key_to_use:
        gui.generate_feedback("Used " + key_to_use.display_name + " to unlock")
        inventory_items.erase(name)
        position_items_in_inventory()
        return true
    else:
        return false

func pickup_item(item: InventoryItem):
    var slot: int = len(inventory_items)
    inventory_items[item.lookup_name] = item
    item.reparent(inventory_display_node, false)
    position_items_in_inventory()
    inventory_control_node.go_to_first_item()

func position_items_in_inventory():
    var keys = inventory_items.keys()
    print(keys)
    for i in range(len(keys)):
        var item: InventoryItem = inventory_items[keys[i]]
        item.position = Vector3(1.0 * i, 0.0, 0.0)
        item.rotation = item.rotation_offset

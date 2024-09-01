extends SubViewportContainer

@export var sensitivity = 0.01
@export var max_tilt = 80.0

var dragging = false
@onready var object: Node3D

var transitioning: bool = false

@onready var inventory_display: Node3D = $SubViewport/InventoryDisplay
var inventory: Dictionary = {}

@onready var camera: Camera3D = $SubViewport/Camera3D

@onready var button_prev: Button = $SubViewport/CanvasLayer/Panel/ButtonPrev
@onready var button_next: Button = $SubViewport/CanvasLayer/Panel/ButtonNext
@onready var item_label: Label = $SubViewport/CanvasLayer/Panel/ItemLabel

var item_index = 0

func _ready():
    update_item_label()
    button_prev.disabled = true
    button_next.disabled = true

func _process(delta):
    if not visible:
        return
    
    if not is_instance_valid(object):
        return        

    camera.position = lerp(camera.position, object.position + object.camera_offset, 1 - exp(-5 * delta))

func _gui_input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        dragging = event.pressed
    
    if event is InputEventMouseMotion and dragging:
        rotate_object(event.relative)

func rotate_object(relative_movement: Vector2):
    if is_instance_valid(object) and not transitioning:
        if absf(relative_movement.x) > absf(relative_movement.y):
            object.rotate_y(-relative_movement.x * sensitivity)
        else:
            object.rotate_x(relative_movement.y * sensitivity)

func go_to_first_item():
    item_index = 0

    if is_instance_valid(object):
        object.rotation = object.rotation_offset

    if Main.game.player.inventory_items.is_empty():
        object = null;
    else:
        object = Main.game.player.inventory_items.values()[0]

    update_item_label()
    set_nextprev_buttons()

func go_to_item_relative(offset: int):
    if is_instance_valid(object):
        object.rotation = object.rotation_offset
    var current_slot = Main.game.player.inventory_items.values().find(object)
    item_index = (current_slot+offset) % len(Main.game.player.inventory_items.values())
    object = Main.game.player.inventory_items.values()[item_index]
    update_item_label()
    set_nextprev_buttons()

func update_item_label():
    if is_instance_valid(object):
        item_label.text = object.display_name
    else:
        item_label.text = ""

func set_nextprev_buttons():
    if Main.game.player.inventory_items.is_empty() or not is_instance_valid(object):
        button_prev.disabled = true
        button_next.disabled = true
    else:
        button_prev.disabled = item_index == 0
        button_next.disabled = item_index == len(Main.game.player.inventory_items) - 1

func _on_button_prev_pressed():
    go_to_item_relative(-1)

func _on_button_next_pressed():
    go_to_item_relative(1)

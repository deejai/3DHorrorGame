extends CanvasLayer

class_name PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
    process_mode = Node.PROCESS_MODE_ALWAYS
    visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_just_pressed("pause_or_cancel"):
        toggle_pause()

func _on_quit_button_pressed():
    get_tree().quit()

func _on_cancel_button_pressed():
    toggle_pause()

func toggle_pause():
    visible = !visible
    get_tree().paused = visible
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED


extends Node2D

class_name TransitionNode

var transition_scene: PackedScene
const DEFAULT_TRANSITION_TIME: float = 4.0
var transition_time: float = DEFAULT_TRANSITION_TIME

enum Fade {NONE, OUT, IN}
var fade: Fade = Fade.NONE

@onready var transition_timer_pre: Timer = $TransitionTimerPre
@onready var transition_timer_wait: Timer = $TransitionTimerWait
@onready var transition_timer_post: Timer = $TransitionTimerPost
@onready var fade_cover: CanvasItem = $FadeCover
@onready var mouse_screen: Panel = $MouseScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match fade:
		Fade.OUT:
			fade_cover.modulate.a += delta * (1.0 / transition_time) * 3.0

		Fade.IN:
			fade_cover.modulate.a -= delta * (1.0 / transition_time) * 3.0

func transition_to(scene: PackedScene, time: float = DEFAULT_TRANSITION_TIME):
	if mouse_screen.visible:
		return

	process_mode = Node.PROCESS_MODE_PAUSABLE
	transition_scene = scene
	transition_time = time
	fade_cover.modulate.a = 0.0
	fade_cover.visible = true
	fade = Fade.OUT
	transition_timer_pre.wait_time = transition_time / 3.0
	mouse_screen.visible = true
	transition_timer_wait.stop()
	transition_timer_post.stop()
	transition_timer_pre.start()


func _on_transition_timer_pre_timeout():
	fade = Fade.NONE
	transition_timer_wait.wait_time = transition_time / 3.0
	transition_timer_wait.start()


func _on_transition_timer_wait_timeout():
	fade = Fade.IN

	var root = get_tree().root
	var current_scene = get_tree().current_scene
	var new_scene = transition_scene.instantiate()
	if new_scene is Game:
		Main.game = new_scene
		print("WAAOW")

	current_scene.queue_free()
	root.add_child(new_scene)
	get_tree().current_scene = new_scene

	transition_timer_post.wait_time = transition_time / 3.0
	transition_timer_post.start()


func _on_transition_timer_post_timeout():
	mouse_screen.visible = false
	fade = Fade.NONE
	fade_cover.visible = false
	set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)


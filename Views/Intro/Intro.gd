extends Node2D

var car_transition_scene: PackedScene = preload("res://Views/Intro/CarTransition.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _on_timer_timeout():
    Main.transition_node.transition_to(car_transition_scene)

func _input(event: InputEvent):
    if event is InputEventMouseButton:
        Main.transition_node.transition_to(car_transition_scene)

extends Node2D

var car_transition_scene: PackedScene = preload("res://Views/Intro/CarTransition.tscn")

func _ready():
    pass

func _process(delta):
    pass

func _on_timer_timeout():
    Main.transition_node.transition_to(car_transition_scene)

func _input(event: InputEvent):
    if event is InputEventMouseButton:
        Main.transition_node.transition_to(car_transition_scene)

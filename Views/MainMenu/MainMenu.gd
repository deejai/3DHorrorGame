extends Node2D

var intro_scene: PackedScene = preload("res://Views/Intro/Intro.tscn")
var game_scene: PackedScene = preload("res://Game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_button_pressed():
    if Main.debug:
        Main.transition_node.transition_to(game_scene)
    else:
        Main.transition_node.transition_to(intro_scene)

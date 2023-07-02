extends Node2D

var intro_scene: PackedScene = preload("res://Views/Intro/Intro.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Main.transition_node.transition_to(intro_scene)

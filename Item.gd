extends Node3D

class_name Item

@onready var sprite: Sprite3D = $Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    sprite.rotation.y += delta * 5.0

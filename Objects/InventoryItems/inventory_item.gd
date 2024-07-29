extends Node3D

class_name InventoryItem

@export var lookup_name: String
@export var display_name: String

@export var camera_offset: Vector3 = Vector3(0.0, 0.0, 0.15)
@export var rotation_offset: Vector3 = Vector3(PI/4.0, 0.0, 0.0)

func _ready():
    pass

func _process(delta):
    pass

extends Area3D

class_name InteractiveArea

func _ready():
    monitoring = false
    collision_layer |= Globals.COLLISION_MASK_INTERACTIVE

func interact():
    printerr("Tried to interact, but no interaction set")

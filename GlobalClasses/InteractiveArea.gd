extends Area3D

class_name InteractiveArea

func _ready():
    monitoring = false
    collision_layer |= Globals.COLLISION_MASK_INTERACTIVE

func interact():
    if get_parent().has_method("interact"):
        get_parent().interact()
    else:
        printerr("Tried to interact, but no interaction set")

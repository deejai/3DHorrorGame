extends NavigationLink3D

class_name DoorNavLink

@export var description: String = "__DESCRIPTION_NOT_SET__"
@export var door_assembly: DoorAssembly = null

func _ready():
    if door_assembly == null:
        printerr("Door assembly for door nav link with description '%s' not set" % description)

extends InteractiveArea

@export var door_assembly: DoorAssembly

func interact():
    door_assembly.openclose()

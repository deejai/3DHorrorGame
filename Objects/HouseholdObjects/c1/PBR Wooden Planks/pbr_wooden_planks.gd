extends Node3D

@export var blocked_door: DoorAssembly = null

func _ready():
    pass

func _process(delta):
    pass

func interact():
    if Main.game.player.use_item("hatchet"):
        if blocked_door:
            # TODO: Play breaking noise
            # TODO: Unlock door
            blocked_door.locked = false
        queue_free()
    else:
        #TODO: Play other noise
        pass

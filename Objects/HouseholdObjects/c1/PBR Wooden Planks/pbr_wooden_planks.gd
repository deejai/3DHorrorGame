extends Node3D

func _ready():
    pass

func _process(delta):
    pass

func interact():
    if Main.game.player.use_item("hatchet"):
        # TODO: Play breaking noise
        # TODO: Unlock door
        queue_free()
    else:
        #TODO: Play other noise
        pass

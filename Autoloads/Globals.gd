extends Node

func get_mask_bitshift(layer: int):
    return 0b1<<(  layer  -1)

var COLLISION_MASK_INTERACTIVE: int = get_mask_bitshift(3)

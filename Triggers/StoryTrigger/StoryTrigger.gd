extends Node3D

@export var cutscene: PackedScene

func interact():
    Main.game.process_mode = PROCESS_MODE_DISABLED
    Main.transition_node.transition_to_without_freeing_current(cutscene)

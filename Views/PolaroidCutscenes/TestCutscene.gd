extends Node2D


func _ready():
    pass

func _process(delta):
    $TextureRect.position.x += 20.0 * delta
    if $TextureRect.position.x > 100.0:
        Main.game.process_mode = PROCESS_MODE_INHERIT
        Main.transition_node.transition_to(Main.game)

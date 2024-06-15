extends Node

enum TriggeredEvent {
    INTRO_CALL_MADDY_1,
    INTRO_CALL_MADDY_2,
    INTRO_CALL_MADDY_3,
    INTRO_CALL_MADDY_4,
    GHOST_ENTERS_HOME_FIRST_TIME,
}

enum InventoryItem {
    AXE,
    CAMERA,
    FLASHLIGHT
}

var stateDict := {"player_offset": Vector3.ZERO, "player_rotation": 0, "current_inventory_slot": -1}
var eventDict := {}
var inventory: Array[InventoryItem] = []
var initialized: bool = false

func load_game_state(loadedStateDict: Dictionary, loadedEventDict: Dictionary, loadedInventory: Array[InventoryItem]):
    for event in loadedEventDict:
        if event:
            eventDict[event] = true
            trigger_event(event)

func save_game_state():
    pass

func reset_game_state():
    for key in TriggeredEvent.keys():
        eventDict[key] = false

func trigger_event(event: TriggeredEvent, node_to_free: Node3D = null):
    if not initialized:
        reset_game_state()
        initialized = true

    match(event):
        TriggeredEvent.INTRO_CALL_MADDY_1:
            if not is_triggered(event):
                AudioManager.get_node("GlobalSoundClips/MaddyCalm2").play()
            var trigger_node = Main.game.get_node("CalloutTrigger1")
            if is_instance_valid(trigger_node):
                trigger_node.queue_free()

        TriggeredEvent.INTRO_CALL_MADDY_2:
            if not is_triggered(event):
                AudioManager.get_node("GlobalSoundClips/MadelineCalm2").play()
            var trigger_node = Main.game.get_node("CalloutTrigger2")
            if is_instance_valid(trigger_node):
                trigger_node.queue_free()

        TriggeredEvent.INTRO_CALL_MADDY_3:
            if not is_triggered(event):
                AudioManager.get_node("GlobalSoundClips/MaddySharp").play()
            var trigger_node = Main.game.get_node("CalloutTrigger3")
            if is_instance_valid(trigger_node):
                trigger_node.queue_free()

        TriggeredEvent.INTRO_CALL_MADDY_4:
            if not is_triggered(event):
                AudioManager.get_node("GlobalSoundClips/MadelineSharp").play()
            var trigger_node = Main.game.get_node("CalloutTrigger4")
            if is_instance_valid(trigger_node):
                trigger_node.queue_free()
            Main.game.player.speed = Main.game.player.DEFAULT_SPEED

        TriggeredEvent.GHOST_ENTERS_HOME_FIRST_TIME:
            if not is_triggered(event):
                # set ghost to active
                Main.game.ghost.spawn()

                # put ghost at front door
                Main.game.ghost.position.x = Main.game.get_node("DoorNavLinkFrontDoor").position.x
                Main.game.ghost.position.z = Main.game.get_node("DoorNavLinkFrontDoor").position.z - 0.5
                Main.game.ghost.position.y = Main.game.get_node("DoorNavLinkFrontDoor").position.y + 0.2

                AudioManager.get_node("GlobalSoundClips/TestGhostFirstEncounter").play()

                # set ghost on path upstairs to player room

                pass

    stateDict[event] = true
    if is_instance_valid(node_to_free):
        node_to_free.queue_free()

func is_triggered(event: TriggeredEvent):
    return eventDict[TriggeredEvent.find_key(event)]


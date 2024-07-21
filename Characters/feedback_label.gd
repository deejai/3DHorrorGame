extends Label

var LIFETIME: float = 2.0
var time_elapsed: float = 0.0

func _ready():
    visible = false

func _process(delta):
    if not visible:
        return

    time_elapsed += delta

    if time_elapsed >= LIFETIME / 2.0:
        modulate.a = 1.0 - (time_elapsed - LIFETIME / 2.0) / (LIFETIME / 2.0)

    if time_elapsed >= LIFETIME:
        visible = false

func generate_feedback(text: String):
    self.text = text
    time_elapsed = 0.0
    visible = true

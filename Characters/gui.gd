extends CanvasLayer

@onready var feedback_label: Label = $FeedbackLabel

func _ready():
    pass

func _process(delta):
    pass

func generate_feedback(text: String):
    feedback_label.generate_feedback(text)

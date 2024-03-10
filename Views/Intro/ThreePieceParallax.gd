extends Node2D

@onready var bg_sprite: Sprite2D = $Background
@onready var mg_sprite: Sprite2D = $Midground
@onready var fg_sprite: Sprite2D = $Foreground

var bg_start: Vector2
var mg_start: Vector2
var fg_start: Vector2

@export var slide_vector: Vector2 = Vector2(-1.18, 0.25)
@export var layer_slide_multiplier: float = 2.0

var dampening_factor: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
    bg_start = bg_sprite.position
    mg_start = mg_sprite.position
    fg_start = fg_sprite.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    dampening_factor += delta * 0.03

    bg_sprite.position += delta * (1.0 - dampening_factor) * slide_vector
    mg_sprite.position += delta * (1.0 - dampening_factor) * slide_vector * layer_slide_multiplier
    fg_sprite.position += delta * (1.0 - dampening_factor) * slide_vector * layer_slide_multiplier * layer_slide_multiplier

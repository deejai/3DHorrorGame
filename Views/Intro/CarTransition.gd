extends Node2D

var time_elapsed: float = 0.0

var house_scene: PackedScene = preload("res://Demo.tscn")
enum TextFade {OUT, IN, WAIT}
var text_fade: TextFade = TextFade.WAIT
var text_fade_wait_timer: float = 1.5

var credits_playing: bool = true
var credits_index: int = 0
@onready var credits_array: Array[CanvasItem] = [
	$Credits/GameTitle,
	$Credits/CreditSam,
	$Credits/Credit4v,
	$Credits/CreditCorndog,
	$Credits/CreditDave,
]

var skipped: bool = false

func _ready():
	for label in credits_array:
		label.modulate.a = 0.0
		label.visible = true


func _process(delta):
	if credits_playing:
		match text_fade:
			TextFade.IN:
				if credits_index > 0:
					print(credits_index)
				credits_array[credits_index].modulate.a += (0.03 if credits_array[credits_index].modulate.a < 0.02 else 0.35) * delta
				if credits_array[credits_index].modulate.a >= 1.0:
					text_fade = TextFade.OUT

			TextFade.OUT:
				credits_array[credits_index].modulate.a -= 0.5 * delta
				if credits_array[credits_index].modulate.a <= 0.0:
					credits_index += 1
					if credits_index >= credits_array.size():
						credits_playing = false
						$GoToNextSceneTimer.start()
					else:
						text_fade_wait_timer = 2.0
						text_fade = TextFade.WAIT

			TextFade.WAIT:
				text_fade_wait_timer -= delta
				if text_fade_wait_timer <= 0:
					text_fade = TextFade.IN


	time_elapsed += delta
	if time_elapsed > 5.5:
		$CarSounds.volume_db -= 6.5 * delta


func _on_background_music_delay_start_timeout():
	$BackgroundMusic.play()


func _on_go_to_next_scene_timer_timeout():
	if skipped:
		return
	
	skipped = true

	Main.transition_node.transition_to(house_scene)

extends Node

class_name AmbiencePlayer

enum Mode {OFF, MIN, WITH_BASS, MAX}
var mode = Mode.MIN
var pending_update: bool = false
var set_to_play: bool = false

@onready var heavy_rumbling: AudioStreamPlayer = $Stems/HeavyRumbling
@onready var bass_line: AudioStreamPlayer = $Stems/BassLine
@onready var eerie_synth: AudioStreamPlayer = $Stems/EerieSynth
@onready var spastic_whirly: AudioStreamPlayer = $Stems/SpasticWhirlySoundLateInTrack

# Called when the node enters the scene tree for the first time.
func _ready():
    heavy_rumbling.volume_db = -12.0 if mode >= Mode.MIN else -100.0
    bass_line.volume_db = -6.0 if mode >= Mode.WITH_BASS else -100.0
    eerie_synth.volume_db = -6.0 if mode >= Mode.MAX else -100.0
    spastic_whirly.volume_db = -10.0 if mode >= Mode.MAX else -100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if pending_update:
        update_intensity()

        if set_to_play:
            heavy_rumbling.play()
            bass_line.play()
            eerie_synth.play()
            spastic_whirly.play()

            set_to_play = false

        pending_update = false

func set_mode(mode: Mode):
    self.mode = mode
    pending_update = true

func update_intensity():
    heavy_rumbling.volume_db = -12.0 if mode >= Mode.MIN else -100.0
    bass_line.volume_db = -6.0 if mode >= Mode.WITH_BASS else -100.0
    eerie_synth.volume_db = -10.0 if mode >= Mode.MAX else -100.0
    spastic_whirly.volume_db = -36.0 if mode >= Mode.MAX else -100.0

func play():
    pending_update = true
    set_to_play = true

func stop():
    heavy_rumbling.stop()
    bass_line.stop()
    eerie_synth.stop()
    spastic_whirly.stop()

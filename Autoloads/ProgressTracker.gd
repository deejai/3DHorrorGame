extends Node

enum MainProgressState {
	INTRO,
	WALKING_TOWARD_HOUSE,
	JUST_ENTERED_HOUSE,
	SOMEONE_CAME_HOME,
	AFTER_SOMEONE_CAME_HOME,
}

var main_progress_state: MainProgressState = MainProgressState.INTRO

func increment_main_state():
	main_progress_state += 1

#func _ready():
#	pass

#func _process(delta):
#	pass

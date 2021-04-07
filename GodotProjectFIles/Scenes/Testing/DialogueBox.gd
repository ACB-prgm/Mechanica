extends TextureRect

onready var label = $Label

signal dialogue_played



func play_dialogue(dialogue: String) -> void:
	randomize()
	label.text = dialogue
	label.visible_characters = 0
	var chars = label.get_total_character_count()
	
	for chara in chars:
		yield(get_tree().create_timer(.05), "timeout")
		label.visible_characters += 1
		$AudioStreamPlayer.pitch_scale = 2 + rand_range(-.5, .5)
		$AudioStreamPlayer.play()
	
	emit_signal("dialogue_played")

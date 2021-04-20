extends TextureRect


onready var timer = $Timer
onready var label = $Label
onready var tween = $Tween
onready var animationPlayer = $AnimationPlayer
onready var dialogueBlip = $AudioStreamPlayer

var chars = 0

signal dialogue_box_finished
signal dialogue_box_started


func _ready():
	rect_scale = Vector2.ZERO
	show()


func play_dialogue(dialogue: String) -> void:
	emit_signal("dialogue_box_started")
	animationPlayer.play("click")
	randomize()
	label.text = dialogue
	label.visible_characters = 0
	chars = label.get_total_character_count()
	timer.start()


func _on_Timer_timeout():
	if chars > 0:
		chars -= 1
		label.visible_characters += 1
		dialogueBlip.pitch_scale = 2 + rand_range(-.5, .5)
		dialogueBlip.play()
		timer.start()
	else:
		emit_signal("dialogue_box_finished")


func finish_playing_early():
	animationPlayer.play("click")
	chars = 0
	label.visible_characters = -1


func _hide():
	animationPlayer.play("click")
	tween.interpolate_property(self, "rect_scale", rect_scale, Vector2.ZERO, 
	.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), 
	.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()


func _show():
	tween.interpolate_property(self, "rect_scale", rect_scale, Vector2(1,1), 
	.2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,1), 
	.2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()

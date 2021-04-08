extends CanvasLayer


onready var popup = $Popup
onready var vbox = $Popup/VBoxContainer
onready var titleLabel = $Popup/VBoxContainer/Title
onready var bodyLabel = $Popup/VBoxContainer/Body
onready var dialogueBox = $DialogueBox

var current_dialogue
var current_dialogue_playing: bool = false
var dialogue_playing: bool = false


func _ready():
	popup.hide()


# POPUPS ———————————————————————————————————————————————————————————————————————
func display_popup(title:String = "", body:String = "" , size: Vector2 = Vector2(1000, 1000)):
	var new_scale = Vector2(size.x/1000, size.y/1000)
	
	titleLabel.set_text(title)
	titleLabel.get("custom_fonts/font").size *= new_scale.x
#	titleLabel.rect_scale = new_scale
	bodyLabel.set_text(body)
	bodyLabel.get("custom_fonts/font").size *= new_scale.x
#	bodyLabel.rect_scale = new_scale
	
	vbox.margin_bottom *= new_scale.y
	vbox.margin_left *= new_scale.x
	vbox.margin_right *= new_scale.x
	vbox.margin_top *= new_scale.y
	
	popup.rect_size = size
	popup.set_anchors_and_margins_preset(Control.PRESET_CENTER, Control.PRESET_MODE_KEEP_SIZE)
	popup.show()


func hide_popup():
	popup.hide()


# DIALOGUE —————————————————————————————————————————————————————————————————————
func display_dialogue(dialogue: Array, character=null) -> void:
	if dialogue_playing:
		dialogueBox.finish_playing_early()
	
	elif !current_dialogue and current_dialogue_playing:
		# Exit dialogue when all finished and player interacts
		current_dialogue_playing = false
		dialogueBox._hide()
		Globals.player.dialogue_freeze(false)
	
	elif current_dialogue_playing:
		# play next dialogue
		var item = current_dialogue[0]
		if typeof(item) == TYPE_STRING:
			dialogueBox.play_dialogue(item)
			current_dialogue.remove(0)
			dialogue_playing = true
		elif typeof(item) == TYPE_ARRAY:
			match item[0]:
				"CHANGE_DIALOGUE":
					character.dialogue = Dialogue.dict.get(item[1])
					current_dialogue.remove(0)
					display_dialogue([], character)
		
	
	else:
		# start displaying dialogue
		Globals.player.dialogue_freeze(true, character)
		if !dialogueBox.is_connected("dialogue_box_started", character, "_on_dialogue_box_started"):
			dialogueBox.connect("dialogue_box_started", character, "_on_dialogue_box_started")
			dialogueBox.connect("dialogue_box_finished", character, "_on_dialogue_box_finished")
		current_dialogue_playing = true
		current_dialogue = dialogue.duplicate(true)
		dialogueBox._show()
		display_dialogue([], character)


func _on_DialogueBox_dialogue_box_finished():
	dialogue_playing = false

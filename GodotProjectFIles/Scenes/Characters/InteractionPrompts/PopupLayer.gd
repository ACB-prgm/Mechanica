extends CanvasLayer


onready var popup = $Popup
onready var vbox = $Popup/VBoxContainer
onready var titleLabel = $Popup/VBoxContainer/Title
onready var bodyLabel = $Popup/VBoxContainer/Body
onready var dialogueBox = $DialogueBox

var current_dialogue
var displaying_dialogue: bool = false


func _ready():
	popup.hide()
	dialogueBox.hide()


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
	if !current_dialogue and displaying_dialogue:
		displaying_dialogue = false
		dialogueBox.hide()
		Globals.player.dialogue_freeze(false)
	
	elif displaying_dialogue:
		var item = current_dialogue[0]
		# play next dialogue
		if typeof(item) == TYPE_STRING:
			dialogueBox.play_dialogue(item)
		elif typeof(item) == TYPE_ARRAY:
			match item[0]:
				"CHANGE_DIALOGUE":
					print("changing")
					character.dialogue = Dialogue.load_dialogue_info().get(item[1])
		current_dialogue.remove(0)
	
	else: #!current_dialogue and !displaying_dialogue
		# start displaying dialogue
		Globals.player.dialogue_freeze(true, character)
		displaying_dialogue = true
		current_dialogue = dialogue.duplicate(true)
		dialogueBox.show()
		display_dialogue([])

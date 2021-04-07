tool
extends Node2D

var dropdown
var dialogue_preview
var interactable_INS
var interactable_TSCN = preload("res://Scenes/Characters/BaseCharacterAdult/BaseCharacterInteractable.tscn")

export var dialogue = ["null"]
export var _texture:StreamTexture = null setget _on_texture_set
export var interactable: bool = false setget set_interactable
export var dialogue_key = "Father_001"
export var dialogue_key_idx= -1


export(String,
	"IDLE",
	"HORIZONTAL",
	"VERTICAL",
	"CIRCLE") var default_movement
export var default_movement_distance: float = 10.0


func _ready():
	get_parent().get_node("AnimationTree").active = true
	dialogue = Dialogue.load_dialogue_info().get(dialogue_key)
	


# SETTING ANIMATION TEXTURE ————————————————————————————————————————————————————
func _on_texture_set(new_texture):
	_texture = new_texture
	
	reset_child_textures(self, new_texture)


func reset_child_textures(parent, new_texture):
	if parent.get_children():
		for child in parent.get_children():
			if child is Sprite:
				child.texture = new_texture
				if child.get_children():
					reset_child_textures(child, new_texture)


# SELECETING DIALOGUE ——————————————————————————————————————————————————————————
func load_dialogue_data():  # Called when this node is selected in the editor
	# if the dialogue has been set previously, loads that past dialogue
	if dialogue_key_idx != -1:
		dropdown.select(dialogue_key_idx)
		_on_dialogue_option_selected(dialogue_key_idx)


func _on_dialogue_option_selected(item):
	# Setget for the plugin dialogue selection
	dialogue_key_idx = item
	dialogue_key = dropdown.get_item_text(item)
	dialogue = Dialogue.load_dialogue_info().get(dialogue_key)
	dialogue_preview.set_text(str(dialogue))


# SETTING INTERACTABLE —————————————————————————————————————————————————————————
func set_interactable(new_value):
	interactable = new_value
	if new_value:
		interactable_INS = interactable_TSCN.instance()
		interactable_INS.connect("interacted", self, "_on_interacted")
		interactable_INS.connect("area_entered", interactable_INS, "_on_BaseCharacterInteractable_area_entered")
		interactable_INS.connect("area_exited", interactable_INS, "_on_BaseCharacterInteractable_area_exited")
		interactable_INS.position = Vector2(0,-325)
		add_child(interactable_INS)
	elif interactable_INS:
		interactable_INS.free()


func _on_interacted():
	PopupLayer.display_dialogue(dialogue, self)






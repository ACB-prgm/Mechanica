extends StaticBody2D


onready var screen = $Screen
onready var tween = $Tween

var is_interacting:bool = false

signal MechEditorComputer_accessed(interacting)


func _ready():
# warning-ignore:return_value_discarded
	connect("MechEditorComputer_accessed", PopupLayer, "_on_MechEditorComputer_accessed")
	screen.modulate = Color(1,1,1,0)


func _on_MechEditorComputer_accessed(interacting):
	if !is_interacting and interacting:
		is_interacting = true
		emit_signal("MechEditorComputer_accessed", true)
	elif is_interacting and !interacting:
		is_interacting = false
		emit_signal("MechEditorComputer_accessed", false)


func _on_ComputerInteractionArea_interactionArea(player_inside):
	if player_inside:
		tween.interpolate_property(screen, "modulate", 
		screen.modulate, Color(1, 1, 2, 1.1), 
		.5, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
		tween.start()
	else:
		tween.interpolate_property(screen, "modulate", 
		screen.modulate, Color(1,1,1,0), 
		.8, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
		tween.start()

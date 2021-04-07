extends Area2D


signal interacted

onready var prompt = $InteractionPrompt



func _ready():
	set_physics_process(false)


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("interacted")


func _on_BaseCharacterInteractable_area_entered(area):
	prompt.show_prompt()
	set_physics_process(true)


func _on_BaseCharacterInteractable_area_exited(area):
	prompt.hide_prompt()
	PopupLayer.hide_popup()
	set_physics_process(false)

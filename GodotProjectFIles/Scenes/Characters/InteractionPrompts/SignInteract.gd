extends StaticBody2D


onready var prompt = $InteractionPrompt


func _ready():
	set_physics_process(false)


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		PopupLayer.display_popup("Bad Sign", "This is a sign that you shouldn't drive high")


func _on_Area2D_body_entered(_body):
	prompt.show_prompt()
	set_physics_process(true)


func _on_Area2D_body_exited(_body):
	prompt.hide_prompt()
	PopupLayer.hide_popup()
	set_physics_process(false)


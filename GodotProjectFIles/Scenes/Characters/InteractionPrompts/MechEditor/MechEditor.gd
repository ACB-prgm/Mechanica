extends TextureRect


onready var animPlayer = $MechEditor/AnimationPlayer
onready var buttons = $MechEditor/Buttons.get_children()
onready var tabs = $MechEditor/Tabs.get_children()


func _ready():
	hide()
	for button in buttons:
		button.set_pressed(false)
	for tab in tabs:
		tab.hide()


func start():
	animPlayer.play("boot_up")


func stop():
	animPlayer.play("shut_down")


func _on_TabButtonPressed(tab_button):
	if tabs:
		for tab in tabs:
			if tab.tab_control == tab_button.tab_control:
				tab.show()
			else:
				tab.hide()

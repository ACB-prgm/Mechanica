extends Sprite


onready var animPlayer = $AnimationPlayer
onready var tween = $Tween


func _ready():
	modulate = Color(1,1,1,0)


func show_prompt() -> void:
	tween.stop_all()
	
	tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,1), 
	.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()


func hide_prompt() -> void:
	tween.stop_all()
	
	tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), 
	.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

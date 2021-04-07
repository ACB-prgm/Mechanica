extends AnimatedSprite


onready var tween = $Tween

var dir = Vector2.LEFT


func _ready():
	playing = true
	tween.interpolate_property(self, "position", position, 
	position + -1000 * dir, 
	0.6, Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.interpolate_property(self, "scale", scale * .5, scale, 
	0.3, Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.start()




func _on_AnimatedSprite_frame_changed():
	if frame == 3:
		tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,1), 
		0.4, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.interpolate_property(self, "position", position, 
		position + Vector2(0, -60), 
		0.6, Tween.TRANS_CIRC, Tween.EASE_OUT)
		tween.start()




func _on_Tween_tween_completed(_object, key):
	if key == ":modulate":
		self.queue_free()

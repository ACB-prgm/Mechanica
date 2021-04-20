extends Label

export var _buff = 0.0
export var _stat = ""


func _ready():
	if _buff:
		display(_buff, _stat)


func display(buff:float = 1.25, stat: String = "ATK"):
	
	match buff:
		1.5:
			$AnimationPlayer.play("double_buff")
		1.25:
			$AnimationPlayer.play("buff")
		0.75:
			$AnimationPlayer.play("nerf")
		0.5:
			$AnimationPlayer.play("double_nerf")
	
	text = stat

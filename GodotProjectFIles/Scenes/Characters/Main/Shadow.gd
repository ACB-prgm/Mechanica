extends Sprite


const Y_POS = 130

onready var skeleton = get_parent().get_node("AnimatedSkeleton")
onready var torso = get_parent().get_node("AnimatedSkeleton/Torso")
onready var BASE_SCALE = scale
onready var BASE_TORSO_H = torso.position.y


func _physics_process(_delta):
	if !$VisibilityNotifier2D.is_on_screen():
		set_physics_process(false)
	position = Vector2(torso.position.x * skeleton.scale.x, Y_POS)
	scale = BASE_SCALE + BASE_SCALE * ((BASE_TORSO_H + torso.position.y)/100.0)


func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)


func _on_VisibilityNotifier2D_screen_exited():
	set_physics_process(false)

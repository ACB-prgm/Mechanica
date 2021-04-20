extends KinematicBody2D


const MAX_VEL = 1000
const ACCELERATION = 100

onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var animSkeleton = $AnimatedSkeleton
onready var footstep_sound = $Sounds/Footstep
onready var SOUNDS = {
	"FOOTSTEP": {
		"player": footstep_sound,
		"original_pitch": .9,
		"pitch_range": 0.1
	}
}

export var facing_left: bool = false

var dustKick = preload("res://Scenes/Characters/Main/DustKick.tscn")
var input_vector: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO


func _ready():
	Globals.player = self
	animTree.active = true
	randomize()


func _physics_process(_delta):
	movement()


 # MOVEMENT ————————————————————————————————————————————————————————————————————
func movement():
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION
		velocity = velocity.clamped(MAX_VEL)
		
		if facing_left and input_vector.x >= 0:
			animPlayer.play("turn_right")
		elif !facing_left and input_vector.x < 0:
			animPlayer.play("turn_left")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION)
	
	
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	animTree.set("parameters/movement/blend_position", input_vector)
	


# ANIMATIONS ———————————————————————————————————————————————————————————————————
func spawn_dustKick() -> void:
	var dir = animSkeleton.scale.x
	var ins_dust = dustKick.instance()
	ins_dust.global_position = to_global(Vector2(-75 * dir, 130))
	ins_dust.dir = input_vector
	ins_dust.scale.x = dir
	get_parent().add_child(ins_dust)


func play_sound(sound:String):
	var player = SOUNDS.get(sound).get("player")
	var original_pitch = SOUNDS.get(sound).get("original_pitch")
	var pitch_range = SOUNDS.get(sound).get("pitch_range")
	
	player.pitch_scale = original_pitch + rand_range(-pitch_range, pitch_range)
	player.play()


func interaction_freeze(pause:bool, character=null):
	if pause:
		velocity = Vector2.ZERO
		set_physics_process(false)
		animTree.set("parameters/movement/blend_position", Vector2.ZERO)
		
		if character:
			var dir_to_char = global_position.direction_to(character.global_position)
			if facing_left and dir_to_char.x >= 0:
				animPlayer.play("turn_right")
			elif !facing_left and dir_to_char.x < 0:
				animPlayer.play("turn_left")
		
		
	else:
		set_physics_process(true)

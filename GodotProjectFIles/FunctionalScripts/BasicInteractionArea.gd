tool
extends Area2D


export var area_radius: int = 250 setget area_radius_set

signal interactionArea(player_inside) # Emitted upon entry and exit of the Area
signal interaction(interacting) # Emitted when the player interacts or exits


func _ready():
	set_physics_process(false)


func area_radius_set(new_value):
	area_radius = new_value
	$CollisionShape2D.shape.radius = new_value


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("interaction", true)
	elif Input.is_action_just_pressed("ui_cancel"):
		emit_signal("interaction", false)


func _on_InteractionArea_area_entered(_area):
	set_physics_process(true)
	emit_signal("interactionArea", true)


func _on_InteractionArea_area_exited(_area):
	set_physics_process(false)
	emit_signal("interactionArea", false)
	emit_signal("interaction", false)

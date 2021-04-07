tool
extends EditorPlugin


var inspector_plugin = preload("res://addons/dialogue_plugin/inspector_plugin.gd")


func _enter_tree():
	inspector_plugin = inspector_plugin.new()
	add_inspector_plugin(inspector_plugin)


func _exit_tree():
	remove_inspector_plugin(inspector_plugin)

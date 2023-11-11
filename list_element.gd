extends Control

var exec_path
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_vars(path):
	exec_path = path
	get_node("HBoxContainer/ScrollContainer/Label").text = path.split("/")[path.split("/").size() - 1]

func _on_button_pressed():
	OS.execute(exec_path, [])

func _on_button_2_pressed():
	Screen.remove_from_list(exec_path)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

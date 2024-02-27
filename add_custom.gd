extends Control

func _ready():
	pass

func _process(_delta):
	pass


func _on_file_dialog_file_selected(path):
	if path.ends_with(".exe"):
		Screen.add_to_list(path)


func _on_file_dialog_files_selected(paths):
	for path in paths:
		if path.ends_with(".exe"):
			Screen.add_to_list(path)

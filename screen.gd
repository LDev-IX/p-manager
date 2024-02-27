class_name Screen extends Node

static var files = []
static var cwd
static var container

func get_files(path, layers):
	if layers == 0:
		return
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			get_files(dir.get_current_dir() + "/" + file_name, layers - 1)
		elif (file_name.ends_with(".exe") or file_name.ends_with(".bat")) and file_name != "p-manager.exe":
			files.push_back(dir.get_current_dir() + "/" + file_name)
		file_name = dir.get_next()

static func load_list():
	var file = FileAccess.open(cwd + "/.list", FileAccess.READ)
	if file != null:
		files = file.get_var()
	files.sort()

static func save_list():
	var file = FileAccess.open(cwd + "/.list", FileAccess.WRITE)
	files.sort()
	file.store_var(files)

static func populate_ui_list():
	Screen.load_list()
	for child in container.get_children():
		container.remove_child(child)
	for file in files:
		var child = load("res://list_element.tscn").instantiate()
		child.set_vars(file)
		container.add_child(child)

func _on_button_2_pressed():
	get_files(cwd, get_node("MarginContainer/VBoxContainer/HBoxContainer/LineEdit").text.to_int())
	Screen.save_list()
	Screen.populate_ui_list()

func _on_add_custom_button_pressed():
	var sc = load("res://add_custom.tscn").instantiate()
	add_child(sc)

static func remove_from_list(file):
	files.erase(file)
	Screen.save_list()
	populate_ui_list()

static func add_to_list(file):
	files.push_back(file)
	Screen.save_list()
	populate_ui_list()

func _ready():
	get_viewport().gui_embed_subwindows = false
	cwd = OS.get_executable_path()
	cwd = cwd.replace("/" + cwd.split("/")[cwd.split("/").size()-1], "")
	container = get_node("MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer")
	Screen.populate_ui_list()

func _process(_delta):
	pass

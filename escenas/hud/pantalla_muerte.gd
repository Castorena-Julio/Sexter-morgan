extends CanvasLayer

var label_kills: Label
@onready var muerteaudio = $muerte
func _ready() -> void:
	layer = 25
	process_mode = Node.PROCESS_MODE_ALWAYS
	_construir_ui()
	visible = false

func mostrar_muerte() -> void:
	# Actualizar contador antes de mostrar
	muerteaudio.play()
	get_tree().paused = true
	if label_kills:
		label_kills.text = "Enemigos eliminados: %d" % GameManager.enemigos_muertos
	visible = true
	# No se pausa el arbol — el nivel ya termino practicamente

func _construir_ui() -> void:
	# Fondo oscuro
	var fondo = ColorRect.new()
	fondo.set_anchors_preset(Control.PRESET_FULL_RECT)
	fondo.color = Color(0.05, 0.0, 0.0, 0.82)
	add_child(fondo)

	# Panel central
	var panel = PanelContainer.new()
	panel.set_anchors_preset(Control.PRESET_CENTER)
	panel.set_offset(SIDE_LEFT, -165)
	panel.set_offset(SIDE_TOP, -160)
	panel.set_offset(SIDE_RIGHT, 165)
	panel.set_offset(SIDE_BOTTOM, 160)
	add_child(panel)

	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 18)
	panel.add_child(vbox)

	# Título
	var titulo = Label.new()
	titulo.text = "💀 HAS CAÍDO"
	titulo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	titulo.add_theme_font_size_override("font_size", 36)
	titulo.add_theme_color_override("font_color", Color(0.9, 0.15, 0.1))
	vbox.add_child(titulo)

	var sep = HSeparator.new()
	vbox.add_child(sep)

	# Kills label
	label_kills = Label.new()
	label_kills.text = "Enemigos eliminados: 0"
	label_kills.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label_kills.add_theme_font_size_override("font_size", 20)
	label_kills.add_theme_color_override("font_color", Color(0.9, 0.85, 0.4))
	vbox.add_child(label_kills)

	var sep2 = HSeparator.new()
	vbox.add_child(sep2)

	# Btn Reiniciar
	var btn_reiniciar = Button.new()
	btn_reiniciar.text = "🔄  Reiniciar nivel"
	btn_reiniciar.add_theme_font_size_override("font_size", 22)
	btn_reiniciar.pressed.connect(_reiniciar)
	vbox.add_child(btn_reiniciar)

	# Btn Menu principal
	var btn_menu = Button.new()
	btn_menu.text = "🏠  Menú principal"
	btn_menu.add_theme_font_size_override("font_size", 22)
	btn_menu.pressed.connect(_ir_al_menu)
	vbox.add_child(btn_menu)

func _reiniciar() -> void:
	visible = false
	get_tree().paused = false
	GameManager.enemigos_muertos = 0
	get_tree().reload_current_scene()

func _ir_al_menu() -> void:
	visible = false
	get_tree().paused = false
	GameManager.enemigos_muertos = 0
	get_tree().change_scene_to_file("res://menu.tscn")

extends CanvasLayer

var visible_menu: bool = false

func _ready() -> void:
	layer = 20
	_construir_ui()
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_just_pressed("ui_cancel"):
		if visible_menu:
			reanudar()
		else:
			mostrar()

func mostrar() -> void:
	visible = true
	visible_menu = true
	get_tree().paused = true

func reanudar() -> void:
	visible = false
	visible_menu = false
	get_tree().paused = false

func _construir_ui() -> void:
	# Fondo oscuro semitransparente
	var fondo = ColorRect.new()
	fondo.set_anchors_preset(Control.PRESET_FULL_RECT)
	fondo.color = Color(0.0, 0.0, 0.0, 0.7)
	add_child(fondo)

	# Panel central
	var panel = PanelContainer.new()
	panel.set_anchors_preset(Control.PRESET_CENTER)
	panel.set_offset(SIDE_LEFT, -150)
	panel.set_offset(SIDE_TOP, -140)
	panel.set_offset(SIDE_RIGHT, 150)
	panel.set_offset(SIDE_BOTTOM, 140)
	add_child(panel)

	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 18)
	panel.add_child(vbox)

	# Título
	var titulo = Label.new()
	titulo.text = "⏸ PAUSA"
	titulo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	titulo.add_theme_font_size_override("font_size", 36)
	vbox.add_child(titulo)

	var sep = HSeparator.new()
	vbox.add_child(sep)

	# Btn Reanudar
	var btn_reanudar = Button.new()
	btn_reanudar.text = "▶  Reanudar"
	btn_reanudar.add_theme_font_size_override("font_size", 22)
	btn_reanudar.pressed.connect(reanudar)
	vbox.add_child(btn_reanudar)

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
	get_tree().paused = false
	GameManager.enemigos_muertos = 0
	get_tree().reload_current_scene()

func _ir_al_menu() -> void:
	get_tree().paused = false
	GameManager.enemigos_muertos = 0
	get_tree().change_scene_to_file("res://menu.tscn")

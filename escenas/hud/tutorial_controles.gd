extends CanvasLayer

func _ready() -> void:
	layer = 30
	process_mode = Node.PROCESS_MODE_ALWAYS
	_construir_ui()
	# Espera 2 segundos y luego desvanece
	await get_tree().create_timer(2.0).timeout
	_desvanecer()

func _construir_ui() -> void:
	# Fondo semitransparente en la parte inferior de la pantalla
	var fondo = ColorRect.new()
	fondo.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	fondo.custom_minimum_size = Vector2(0, 130)
	fondo.set_anchor_and_offset(SIDE_TOP, 1.0, -130)
	fondo.set_anchor_and_offset(SIDE_BOTTOM, 1.0, 0)
	fondo.color = Color(0.0, 0.0, 0.0, 0.72)
	add_child(fondo)

	var margin = MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	margin.set_anchor_and_offset(SIDE_TOP, 1.0, -130)
	margin.set_anchor_and_offset(SIDE_BOTTOM, 1.0, 0)
	margin.add_theme_constant_override("margin_left", 30)
	margin.add_theme_constant_override("margin_right", 30)
	margin.add_theme_constant_override("margin_top", 14)
	margin.add_theme_constant_override("margin_bottom", 14)
	add_child(margin)

	var hbox = HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 48)
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	margin.add_child(hbox)

	var controles = [
		["WASD", "Moverse"],
		["Shift", "Dash"],
		["🖱 Click izq.", "Disparar"],
		["ESC", "Pausa"],
	]

	for par in controles:
		var vbox = VBoxContainer.new()
		vbox.add_theme_constant_override("separation", 4)
		hbox.add_child(vbox)

		var tecla = Label.new()
		tecla.text = par[0]
		tecla.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		tecla.add_theme_font_size_override("font_size", 22)
		tecla.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		vbox.add_child(tecla)

		var accion = Label.new()
		accion.text = par[1]
		accion.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		accion.add_theme_font_size_override("font_size", 15)
		accion.add_theme_color_override("font_color", Color(0.85, 0.85, 0.85))
		vbox.add_child(accion)

func _desvanecer() -> void:
	var tween = create_tween()
	tween.tween_property(self, "layer", 30, 0.4)  # dummy para animar
	# Animar modulate del CanvasLayer
	# CanvasLayer no tiene modulate directo; animamos los hijos
	for child in get_children():
		if child is Control:
			tween.parallel().tween_property(child, "modulate:a", 0.0, 0.4)
	await tween.finished
	queue_free()

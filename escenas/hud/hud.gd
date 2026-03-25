extends CanvasLayer


@onready var barra_vida: ProgressBar = $MarginContainer/VBoxContainer/BarraVida
@onready var label_enemigos: Label = $MarginContainer/VBoxContainer/LabelEnemigos


func actualizar_vida(vida_actual: float, vida_maxima: float) -> void:
	barra_vida.max_value = vida_maxima
	barra_vida.value = vida_actual


func actualizar_contador(n: int) -> void:
	label_enemigos.text = "☠ Eliminados: %d" % n

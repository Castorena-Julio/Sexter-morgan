extends CanvasLayer


@onready var barra_vida: ProgressBar = $MarginContainer/VBoxContainer/BarraVida


func actualizar_vida(vida_actual: float, vida_maxima: float) -> void:
	barra_vida.max_value = vida_maxima
	barra_vida.value = vida_actual

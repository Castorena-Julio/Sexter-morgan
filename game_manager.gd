extends Node


var enemigos_muertos: int = 0

var fib_a: int = 1 
var fib_b: int = 1  


signal enemigo_muerto


var hud = null

func _ready() -> void:
	enemigo_muerto.connect(_on_enemigo_muerto)

func registrar_muerte() -> void:
	emit_signal("enemigo_muerto")

func _on_enemigo_muerto() -> void:
	enemigos_muertos += 1
	if hud:
		hud.actualizar_contador(enemigos_muertos)

func siguiente_fibonacci() -> int:
	# Avanza la secuencia y devuelve el número de enemigos a spawnear
	var siguiente = fib_a + fib_b
	fib_a = fib_b
	fib_b = siguiente
	return fib_a

func oleada_actual() -> int:
	return fib_a

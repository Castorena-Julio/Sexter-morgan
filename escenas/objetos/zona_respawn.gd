extends Node2D

# Escenas de enemigos disponibles para spawnear
const CAMINANTE = preload("res://escenas/personajes/enemigos/caminante.tscn")
const CENTINELA = preload("res://escenas/personajes/enemigos/centinela2.0.tscn")

# Radio alrededor del marcador donde pueden aparecer los enemigos
@export var radio_spawn: float = 120.0

# Tiempo de espera antes de lanzar la siguiente oleada (en segundos)
@export var delay_oleada: float = 2.5

# --- Estado interno ---
var vivos: int = 0          # enemigos vivos de la oleada actual
var oleada_numero: int = 0  # oleada actual (para mostrar en console)

# Fibonacci
var fib_a: int = 1   # cantidad a spawnear en esta oleada
var fib_b: int = 1   # siguiente


func _ready() -> void:
	# Escuchar cada muerte para actualizar el contador de vivos
	GameManager.enemigo_muerto.connect(_on_enemigo_muerto)
	
	# Dar un pequeño delay antes de iniciar la primera oleada
	await get_tree().create_timer(1.0).timeout
	lanzar_oleada(fib_a)


func lanzar_oleada(cantidad: int) -> void:
	oleada_numero += 1
	vivos = cantidad
	print("[ZonaRespawn] Oleada %d — spawneando %d enemigos" % [oleada_numero, cantidad])
	
	for i in range(cantidad):
		var offset = Vector2(
			randf_range(-radio_spawn, radio_spawn),
			randf_range(-radio_spawn, radio_spawn)
		)
		var pos = global_position + offset
		
		# Alternar entre caminante y centinela para más variedad
		var enemigo
		if i % 2 == 0:
			enemigo = CAMINANTE.instantiate()
		else:
			enemigo = CENTINELA.instantiate()
		
		get_tree().current_scene.add_child(enemigo)
		enemigo.global_position = pos


func _on_enemigo_muerto() -> void:
	vivos -= 1
	if vivos <= 0:
		# Esta oleada terminó — calcular siguiente Fibonacci y lanzar
		var siguiente = fib_a + fib_b
		fib_a = fib_b
		fib_b = siguiente
		
		print("[ZonaRespawn] ¡Oleada completada! Próxima: %d enemigos" % fib_a)
		
		await get_tree().create_timer(delay_oleada).timeout
		lanzar_oleada(fib_a)

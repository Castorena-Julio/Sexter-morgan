extends Node2D

# ============================================================
#  ZONA DE RESPAWN
#  Regla: cada 5 enemigos muertos → spawnea 7 nuevos aquí
# ============================================================

# Radio alrededor de esta zona donde aparecen los enemigos
@export var radio_spawn: float = 120.0

# Escenas de enemigos disponibles
const CAMINANTE = preload("res://escenas/personajes/enemigos/caminante.tscn")
const CENTINELA = preload("res://escenas/personajes/enemigos/centinela2.0.tscn")

var kills_acumulados: int = 0   # kills desde el último spawn
const KILLS_PARA_SPAWN: int = 4 # cuántos kills activan el respawn
var CANTIDAD_SPAWN:   int = 2 # cuántos enemigos aparecen


func _ready() -> void:
	GameManager.enemigo_muerto.connect(_on_enemigo_muerto)


func _on_enemigo_muerto() -> void:
	
	kills_acumulados += 1

	# Cada múltiplo de 5 kills → lanzar 7 enemigos (el contador nunca se resetea)
	if kills_acumulados % KILLS_PARA_SPAWN == 0:
		_spawnear(CANTIDAD_SPAWN)


func _spawnear(cantidad: int) -> void:
	print("[ZonaRespawn] Spawneando %d enemigos en %s" % [cantidad, name])
	for i in range(cantidad):
		var offset = Vector2(
			randf_range(-radio_spawn, radio_spawn),
			randf_range(-radio_spawn, radio_spawn)
		)
		var enemigo
		# 70% caminantes, 30% centinelas
		if randf() < 0.70:
			enemigo = CAMINANTE.instantiate()
		else:
			enemigo = CENTINELA.instantiate()

		get_tree().current_scene.add_child(enemigo)
		
		enemigo.global_position = global_position + offset

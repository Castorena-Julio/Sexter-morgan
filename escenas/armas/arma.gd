extends Marker2D

var bala_escena = preload("res://escenas/armas/bala.tscn")
var puede_disparar: bool = true
var cooldown: float = 0.3

func disparar(direccion: Vector2) -> void:
	if not puede_disparar:
		return
	
	# Instanciar la bala en el nivel (no como hijo de Dexter para evitar su scale 0.09)
	var bala = bala_escena.instantiate()
	bala.direccion = direccion.normalized()
	bala.global_position = global_position
	
	# Rotar la bala para que apunte en la dirección correcta
	bala.rotation = direccion.angle()
	
	# Agregar al nivel (padre del padre = el nivel)
	get_tree().current_scene.add_child(bala)
	
	# Iniciar cooldown
	puede_disparar = false
	await get_tree().create_timer(cooldown).timeout
	puede_disparar = true

extends CharacterBody2D
var vida_maxima : float = 100.0
var vida_actual : float = 100.0

var speed: float = 100.0
@onready var player = get_node("/root/nivel1/dexter")
func _ready():
	pass
	
func _physics_process(data):
	var direccion = (player.global_position - global_position).normalized()
	var distancia = global_position.distance_to(player.global_position)
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else :
		$AnimatedSprite2D.flip_h = false
	if distancia < 200:
		$AnimatedSprite2D.play("correr")
		velocity = direccion * speed
	if velocity.y == 0 && velocity.x == 0 :
		$AnimatedSprite2D.play("idle")
	
	move_and_slide()


func recibir_dano(cantidad: float) -> void:
	vida_actual -= cantidad
	vida_actual = max(vida_actual, 0)
	
	print (vida_actual)
	$AnimatedSprite2D.modulate = Color.RED
	
	# Restaurar color despues de un momento
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.3)
	
	if vida_actual <= 0:
		morir()
		
		
func morir() -> void:
	print ("murio")
	queue_free()
	
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerbala"):
		recibir_dano(10.0)
		print ("10")

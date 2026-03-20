extends CharacterBody2D

@export var area_2d: Area2D

const salto : float = -200.0
var _velocidad : float = 200
const move_speed = 200
const dash_speed =400
const dash_duration = 0.2
@onready var dash = $Dash
@onready var sprite = $Sprite2D
@onready var hud = $HUD

# Variables de vida
var vida_maxima : float = 100.0
var vida_actual : float = 100.0


func _ready() :
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	hud.actualizar_vida(vida_actual, vida_maxima)


#movimineto lateral 
func _physics_process(delta):
	
	
	
	#funcion del dash ( salto jugador)
	if  Input.is_action_just_pressed("shift") && dash.can_dash && !dash.is_dashing() && (velocity.x !=0 || velocity.y !=0) :
		
		dash.start_dash(sprite, dash_duration)

	_velocidad = dash_speed if dash.is_dashing() else move_speed
	
	
		
 
	
	
	#gravedad
	if Input.is_action_pressed("arriba") || Input.is_action_pressed("ui_up") :
		velocity.y = -_velocidad
		
		
	elif Input.is_action_pressed("abajo") || Input.is_action_pressed("ui_down"): 
		
		velocity.y = _velocidad
	else : 
		
		velocity.y = 0

	
	if Input.is_action_pressed("derecha") || Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
		$Sprite2D.flip_h = false
		
		
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("izquierda") || Input.is_action_pressed("ui_left"): 
		$AnimatedSprite2D.flip_h = true
		$Sprite2D.flip_h = true
		velocity.x = -_velocidad
	else : 
		
		velocity.x = 0
	move_and_slide()
	
	if velocity.x !=0 || velocity.y !=0 :
		$AnimatedSprite2D.play("new_animation"	)
	else : 
		$AnimatedSprite2D.play("estatico")


#recibir dano
func recibir_dano(cantidad: float) -> void:
	vida_actual -= cantidad
	vida_actual = max(vida_actual, 0)
	hud.actualizar_vida(vida_actual, vida_maxima)
	
	$AnimatedSprite2D.modulate = Color.RED
	
	# Restaurar color despues de un momento
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.3)
	
	if vida_actual <= 0:
		morir()


func morir() -> void:
	
	print("Dexter ha muerto!")

#no me dejo borrar esta funcion y solo le puse pass
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	print ("hola")
	recibir_dano(20.0)

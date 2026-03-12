extends CharacterBody2D

@export var area_2d: Area2D

const salto : float = -200.0
var _velocidad : float = 200
const move_speed = 200
const dash_speed =800
const dash_duration = 0.2
@onready var dash = $Dash
@onready var sprite = $Sprite2D





func _ready() :
	area_2d.body_entered.connect(_on_area_2d_body_entered)



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

	


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	$AnimatedSprite2D.modulate = Color.RED
	
	

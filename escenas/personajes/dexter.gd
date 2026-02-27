extends CharacterBody2D

@export var area_2d: Area2D
const salto : float = -50.0
var _velocidad : float = 200


func _ready() :
	area_2d.body_entered.connect(_on_area_2d_body_entered)

var salud : float = 100

#movimineto lateral 
func _physics_process(delta):
	#gravedad
	if Input.is_action_pressed("arriba")  || Input.is_action_pressed("ui_up"):
		velocity.y = salto
	elif Input.is_action_pressed("abajo") || Input.is_action_pressed("ui_down"):
		velocity.y = -salto
	else : 
		velocity.y = 0
	
	
	if Input.is_action_pressed("derecha") || Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("izquierda") || Input.is_action_pressed("ui_left"): 
		$AnimatedSprite2D.flip_h = true
		velocity.x = -_velocidad
	else : 
		
		velocity.x = 0
	move_and_slide()
	
	if velocity.x !=0 || velocity.y !=0 :
		$AnimatedSprite2D.play("new_animation"	)
	else : 
		$AnimatedSprite2D.play("estatico")

	


func _on_area_2d_body_entered(body: Node2D) -> void:
	salud -= 20 
	$AnimatedSprite2D.modulate = Color.RED
	print(salud)
	

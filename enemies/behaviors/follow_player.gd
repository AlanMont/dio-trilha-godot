extends Node

@export var speed: float =  1

var sprite : AnimatedSprite2D

var enemy: Enemy

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("AnimatedSprite2D")

func _physics_process(delta: float) -> void:
		#Ignorar Game Over
	if GameManager.is_game_over: return
	
	#calcular direção
	var player_position = GameManager.player_position
	var difference = player_position - enemy.position
	var input_vector =difference.normalized()
	#movimenta
	enemy.velocity = input_vector * speed * 100.0	
	enemy.move_and_slide()

	#Girar Sprite
	if  input_vector.x >0:
	#desmarca flip_h do sprite 2D
		sprite.flip_h = false
	elif input_vector.x <0:
	#marca flip_h do sprite 2D
		sprite.flip_h = true

class_name MobSpawner
extends Node2D

@export var creatures: Array[PackedScene]
@export var mobs_per_minute: float = 60.0

@onready var path_follow_2d : PathFollow2D = %PathFollow2D
var cooldown: float = 0.0

func _process(delta: float):
	
	#Ignorar Game Over
	if GameManager.is_game_over: return

	#Temporizador (cooldown)
	cooldown -= delta
	if cooldown> 0: return
	#Frequência: monstros por minuto
	var interval = 60.0 / mobs_per_minute
	cooldown = interval
	#checar se o ponto é válido
	var point = get_point()
	var world_state= get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = point
	parameters.collision_mask = 0b1000
	var result: Array = world_state.intersect_point(parameters, 1)
	if not result.is_empty(): return
	#perguntar se o ponto tem colisão
	
	
	# Instanciar uma criatura Aleatória
	var index = randi_range(0, creatures.size()-1)
	var creatures_scene = creatures[index]
	var creature = creatures_scene.instantiate()
	creature.global_position = point
	get_parent().add_child(creature)
	

func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf() #Random Float
	return path_follow_2d.global_position

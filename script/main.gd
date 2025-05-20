extends Node2D

@export var enemy1: PackedScene
@export var enemy2: PackedScene
@export var enemy3: PackedScene
@export var enemy4: PackedScene
var spawn_interval : float = 1.0
var spawn_interval_amigos : float = 5.0
@onready var spawn1 = $spawn1
@onready var spawn2 = $spawn2
@onready var spawn3 = $spawn3
@onready var spawn4 = $"spawn amigos"
@onready var enemy_scenes : Array = [enemy1, enemy2, enemy3, enemy4]
@onready var spawns : Array = [spawn1, spawn2, spawn3]
@onready var nodeenemies = $NodeEnemies

@export var ana: PackedScene
@export var laura: PackedScene
@export var felipe: PackedScene
@onready var amigos : Array = [ana, laura, felipe]

@onready var tela_morte = $Control

func _ready():
	spawn_enemy()
	spawn_amigos_loop()
	tela_morte.visible = false
	await get_tree().create_timer(19.0).timeout
	check_victory_or_loss()

func check_victory_or_loss():
	var player = get_node("player")
	if player.friends_collected >= 3:
		get_tree().change_scene_to_file("res://victory.tscn")
	else:
		get_tree().change_scene_to_file("res://loss.tscn")

func spawn_amigos_loop():
	var amigo_index = 0
	while amigo_index < amigos.size():
		await get_tree().create_timer(spawn_interval_amigos).timeout
		var amigo_scene = amigos[amigo_index]
		var new_amigo = amigo_scene.instantiate()
		new_amigo.position = spawn4.position
		add_child(new_amigo)
		new_amigo.get_node("AnimatedSprite2D").play()
		amigo_index += 1

func spawn_enemy():
	while true:
		await get_tree().create_timer(spawn_interval).timeout
		var car_scene_path = enemy_scenes[randi() % enemy_scenes.size()]
		var new_enemy = car_scene_path.instantiate()
		var spawn_fkjsa = spawns[randi() % spawns.size()]
		new_enemy.position = spawn_fkjsa.position
		new_enemy.add_to_group("enemies")
		add_child(new_enemy)

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("enemies"):
		get_tree().paused = true
		tela_morte.visible = true
		

extends CharacterBody2D

const SPEED = 300.0

func _ready():
	$AnimatedSprite2D.scale.x = -1

func _physics_process(delta: float) -> void:
	position.x -= 1

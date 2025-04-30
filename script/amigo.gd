extends Area2D

func _ready():
	$AnimatedSprite2D.scale.x = 1

func _physics_process(delta: float) -> void:
	position.x -= 1

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	queue_free()

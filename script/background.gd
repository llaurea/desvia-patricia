extends Node2D

@export var scroll_speed : float = 30.0

var backgrounds = []

func _ready():
	backgrounds = [ $bg1, $bg2, $ceu1, $ceu2]
	
func _process(delta):
	for sp in backgrounds:
		sp.position.x -= scroll_speed * delta
	
		if sp.position.x <= -sp.texture.get_size().x:
			sp.position.x += sp.texture.get_size().x * 2

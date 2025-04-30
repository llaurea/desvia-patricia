extends CharacterBody2D

var speed =80 #quao rapido vai p direita e esquerda
var lane_height =1 #altura das pistas MUDAR
var vivo : bool = true

#fazer animacao da patricia funcionar
func _ready():
	$Patricia.play()

#CARRO IR PRA FRENTE E PRA TRAS
func _physics_process(delta):
	velocity = Vector2.ZERO #começa parado
	if vivo:
#CARRO IR PRA CIMA E PRA BAIXO/TROCAR DE FAIXA
		if Input.is_action_pressed("ui_up"):
			position.y -=lane_height #sobe
		elif Input.is_action_pressed("ui_down"):
			position.y +=lane_height #desce
		if Input.is_action_pressed("ui_right"):
			velocity.x = speed  # direita
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -speed  # esquerda
		else:
			velocity.x = 0  # nao anda se n aperta
	else:
		position.x -= 1
		
	move_and_slide()

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("enemies"):
		vivo = false

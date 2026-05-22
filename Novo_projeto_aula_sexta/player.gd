
extends CharacterBody2D

# Velocidade de movimento do jogador
@export var speed = 200

# Referência ao sprite
@onready var sprite = $Sprite2D

# Função chamada a cada frame física
func _physics_process(delta):
	# Captura entrada do teclado
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_axis("ui_left", "ui_right")
	input_direction.y = Input.get_axis("ui_up", "ui_down")
	
	# Normaliza a velocidade para movimento diagonal
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	
	# Define a velocidade
	velocity = input_direction * speed
	
	# Move o personagem e trata colisões
	move_and_slide()
	
	# Limita o movimento dentro da tela
	var viewport_rect = get_viewport().get_visible_rect()
	global_position = global_position.clamp(viewport_rect.position, viewport_rect.end)
	
	# Animação baseada na direção
	if input_direction.x != 0:
		sprite.flip_h = input_direction.x < 0

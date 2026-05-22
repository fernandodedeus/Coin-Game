extends Area2D

# Sinal para quando a moeda for coletada
signal collected

@onready var audio_player = $AudioStreamPlayer2D

func _ready():
	# Conecta o sinal de body_entered
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		audio_player.play()
		collected.emit()
		queue_free()
		
		# Espera o som tocar antes de remover a moeda
		await audio_player.finished
		
		queue_free()

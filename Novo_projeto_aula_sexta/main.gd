extends Node2D

# Referência ao jogador
@onready var player = $Player

# Referência ao timer de spawn
@onready var coin_spawn_timer = $CoinSpawnTimer

@onready var score_label = $CanvasLayer/Label

# Contador de moedas coletadas
var score = 0

# Prefab da moeda
var coin_scene = preload("res://Novo_projeto_aula_sexta/Coin.tscn")

# Função chamada quando o nó é adicionado à cena
func _ready():
	player.add_to_group("Player")
	# Conecta o sinal de timeout do timer à função de spawn
	coin_spawn_timer.timeout.connect(_spawn_coin)
	
	
	# Adiciona o jogador ao grupo "player"
	

# Função para spawnar moedas
func _spawn_coin():
	# Cria uma nova instância da moeda
	var coin = coin_scene.instantiate()
	
	# Define uma posição aleatória na tela
	var viewport_size = get_viewport().get_visible_rect().size
	coin.position = Vector2(
		randf_range(50, viewport_size.x - 50),
		randf_range(50, viewport_size.y - 50)
	)
	
	
	print(coin)
	print(coin.get_class())
	# Conecta o sinal de coletada da moeda
	coin.collected.connect(_on_coin_collected)
	
	# Adiciona a moeda à cena
	add_child(coin)

# Função chamada quando uma moeda é coletada
func _on_coin_collected():
	# Incrementa a pontuação
	score += 1
	score_label.text = "Pontuação: " + str(score)
	
	print("Peixes coletados: ", score)
	
	# Verifica condição de vitória (opcional)
	
	if score >= 10:
		score_label.text = "Você venceu! Pontuação: " + str(score)
		coin_spawn_timer.stop()
		
		
		
		

extends TextureButton

class_name GatoGachaShop

@export var priceLabel : Label
@export var countLabel : Label
@export var catArea : ColorRect

var price = 1500
var auto_gacha_scene = preload("res://gatoGacha.tscn")
var explosion = preload("res://assets/SillyCatExplosion.tscn")

func _ready():
	priceLabel.text = str(price)
	
func buy(counter : int) -> int:
	if(counter >= price):
		var leftover = counter - price
		_create_auto_gacha()
		return leftover
	return counter
	
	
func _create_auto_gacha():
	var auto_silly_instance = auto_gacha_scene.instantiate()
	catArea.add_child(auto_silly_instance)
	auto_silly_instance.position = Vector2(randi_range(0, 600), randi_range(0, 350))
	var explosion_instance : GPUParticles2D = explosion.instantiate()
	catArea.add_child(explosion_instance)
	explosion_instance.position = auto_silly_instance.position
	explosion_instance.emitting = true
	explosion_instance.one_shot = true


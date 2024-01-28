extends TextureButton

class_name CatRehabUpgrade

@export var priceLabel : Label
@export var countLabel : Label
@export var catArea : TextureRect
@export var manager : Manager
@export var catAreaTextures : Array[Texture2D]
var level = 0
var price = 2000
var isopen

signal openRehab

func _ready():
	priceLabel.text = str(price)

func buy(counter : int) -> int:
	if level == 10:
		return counter
	if(counter >= price):
		if not isopen:
			isopen = true
			emit_signal('openRehab')
		
		var leftover = counter - price
		price *= 2
		catArea.texture = catAreaTextures[level]
		level += 1
		catArea.level = level
		countLabel.text = "Cat Rehab Lvl " + str(level)
		priceLabel.text = str(price)
		return leftover
	return counter

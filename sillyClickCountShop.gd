extends TextureButton

class_name SillyUpgrade

@export var priceLabel : Label
@export var countLabel : Label
var silly_count = 1
var price = 100
var manager : Manager

func _ready():
	manager = get_node("/root/Manager")

func buy(counter : int) -> int:
	if(counter >= price):
		silly_count += 1
		countLabel.text = "Sillicat Gel Upgrade LVL " + str(silly_count)
		var leftover = counter - price
		price = roundi(price * 1.3)
		priceLabel.text = str(price)
		manager.perClick += 1
		manager.perClickPrev = manager.perClick
		return leftover
	return counter

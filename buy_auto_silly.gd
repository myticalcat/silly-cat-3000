extends Control


class_name AutoSillyShop


@export var priceLabel : Label
@export var countLabel : Label
@export var catArea : ColorRect
signal buy_silly
var silly_count = 0
var price = 50
var autosilly_scene = preload("res://autoSilly.tscn")


func _ready():
	priceLabel.text = str(price)
	countLabel.text = "0"

func _on_texture_button_button_down():
	emit_signal("buy_silly")

func get_price() -> int:
	return price
	
func buy(counter : int) -> int:
	if(counter >= price):
		silly_count += 1
		countLabel.text = str(silly_count)
		var leftover = counter - price
		_create_auto_silly()
		price = roundi(price * 1.3)
		priceLabel.text = str(price)
		return leftover
	return counter

func _create_auto_silly():
	var auto_silly_instance = autosilly_scene.instantiate()
	catArea.add_child(auto_silly_instance)
	auto_silly_instance.position = Vector2(randi_range(0, 600), randi_range(0, 350))

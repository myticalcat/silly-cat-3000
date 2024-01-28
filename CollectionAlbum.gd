extends TextureButton

class_name CollectionAlbum

@export var catShow : ColorRect
@export var title : Label
var open = false
var commonCat : Array[Texture2D] = []
var rareCat : Array[Texture2D] = []
var ssrCat : Array[Texture2D] = []
var currentPage : String
var page : Dictionary

func _ready():
	var auto_gacha_scene = preload("res://gatoGacha.tscn")
	var gatoGacha = auto_gacha_scene.instantiate()
	page = {
		'Common Cat' : [commonCat, gatoGacha.commonSilly],
		'Rare Cat' : [rareCat, gatoGacha.rareSilly],
		'SSR Cat' : [ssrCat, gatoGacha.superSilly]
	}
	currentPage = 'Common Cat'
	showPage()
	
func showPage():
	for child in catShow.get_children():
		child.queue_free()
	var arr = page.get(currentPage)[0]
	var len = page.get(currentPage)[1].size()
	title.text = currentPage + " " + str(arr.size()) + "/" + str(len)
	for texture in arr:
		var sprite = Sprite2D.new()
		sprite.texture = texture
		sprite.scale = Vector2(0,0)
		var tween = create_tween()
		tween.tween_property(sprite, 'scale', Vector2(0.3,0.3), 0.3)
		var random_x = randi_range(0, catShow.size.x)
		var random_y = randi_range(0, catShow.size.y)
		sprite.position = Vector2(random_x, random_y)
		sprite.rotation = randf_range(0, PI/2) 
		catShow.add_child(sprite)

func add_cat(cat : GatoResorce):
	var arr : Array[Texture2D]
	match cat.rarity:
		0:
			arr = commonCat
		1:
			arr = rareCat
		2:
			arr = ssrCat
	for tex in arr:
		if(tex == cat.spriteOn):
			return
	arr.append(cat.spriteOn)
	showPage()

func _on_button_down():
	var tween = create_tween()
	if open:
		open = false
		tween.tween_property(self, 'position:x', position.x + 500, 0.5).set_ease(Tween.EASE_IN_OUT)
	else:
		open = true
		tween.tween_property(self, 'position:x', position.x - 500, 0.5).set_ease(Tween.EASE_IN_OUT)


func _on_texture_button_button_down():
	if currentPage == "Common Cat":
		currentPage = "Rare Cat"
	elif currentPage == "Rare Cat":
		currentPage = "SSR Cat"
	else:
		currentPage = "Common Cat"
	showPage()

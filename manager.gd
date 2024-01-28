extends Control

class_name Manager

@export var counterLabel : Label
@export var perClick : int = 1
@export var autosilly : AutoSillyShop
@export var sillyup : SillyUpgrade
@export var gachaShop : GatoGachaShop
@export var catRehab : CatRehabUpgrade
@export var sillyCatButton : TextureButton
@export var silly : Texture2D
@export var notSilly : Texture2D
@export var catArea : ColorRect
@export var soundEffect : AudioStreamPlayer2D
@export var album : CollectionAlbum
@export var normalBG :Texture2D
@export var frenzyBG :Texture2D
@export var background : TextureRect
var counter : int = 100000
var frenzy : bool = false
var perClickPrev = 1
var frenzyTime : int = 0
var tween : Tween
var tweenFinished = true

func _process(delta):	
	if frenzy:
		background.texture = frenzyBG
		background.speed = 25
		perClick = 2 * perClickPrev 
		frenzyTime -= delta * 20
		if(tweenFinished):
			tweenFinished = false
			tween = create_tween()
			tween.tween_property(background, 'modulate', Color.PINK, 5).from(Color.AQUAMARINE)
			tween.tween_property(background, 'modulate', Color.AQUAMARINE, 5).from(Color.PINK)
			tween.finished.connect(turn_on_finish)
		$FrenzyTitle.show()
		$Logo.hide()
		if frenzyTime <= 0:
			background.modulate = Color.WHITE
			frenzy = false
			$FrenzyTitle.hide()
			$Logo.show()
	else:
		background.speed = 50
		background.modulate = Color.WHITE
		perClick = perClickPrev
		background.texture = normalBG
		
func turn_on_finish():
	tweenFinished = true
	
func change_main_silly():
	sillyCatButton.texture_normal = silly
	
func change_main_not_silly():
	sillyCatButton.texture_normal = notSilly

func _ready():
	$FrenzyTitle.hide()
	autosilly.hide()
	sillyup.hide()
	gachaShop.hide()
	catRehab.hide()
	catArea.hide()
	album.hide()

func _on_texture_button_button_down():
	soundEffect.play()
	counter += perClick
	refresh()
	if(counter > 25):
		autosilly.show()
	if(counter > 150):
		sillyup.show()
	if(counter > 500):
		album.show()
		gachaShop.show()
	if(counter > 2000):
		catRehab.show()

func add_cat(cat : GatoResorce):
	album.add_cat(cat)

func _on_buy_auto_silly_buy_silly():
	catArea.show()
	var prevc = counter
	counter = autosilly.buy(counter)
	if prevc != counter:
		soundEffect.play()
	refresh()

func refresh():
	counterLabel.text = str(counter)

func add_counter(ncounter : int):
	counter += ncounter
	refresh()


func _on_silly_click_count_shop_button_down():
	counter = sillyup.buy(counter)
	refresh()


func _on_gato_gacha_shop_button_down():
	counter = gachaShop.buy(counter)
	refresh()


func _on_cat_rehab_upgrade_button_down():
	counter = catRehab.buy(counter)
	refresh()


func _on_frenzy_timer_timeout():
	if frenzy : 
		return	
	var rng = randi_range(0,100)
	print("FrenzyRNG : " + str(rng))
	if(rng == 69):
		$windows.play()
		frenzy = true
		frenzyTime = randi_range(200, 500)

extends TextureButton

onready var game_data = SaveFile.game_data
onready var y_pressed = 0
onready var y_released = 0
onready var shop_item
var item_type

func _ready():
	var _button_pressed = self.connect("pressed", self, "_on_TextureButton_pressed")

func _input(event):
	if event.is_action_pressed("click"):
		y_pressed = event.position.y
	elif event.is_action_released("click"):
		y_released = event.position.y
		
func set_font_size(label, size):
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://fonts/Sugar Snow.ttf")
	dynamic_font.size = size
	label.add_font_override("font", dynamic_font)
		
# Check if the user has scrolled or has pressed the button
func has_pressed():
	return abs(y_pressed-y_released) < 20
	
func change_to_scene(scene):
	MusicController.play_pop_sf()
	if get_tree().change_scene(scene) != OK:
		print ("An unexpected error occured when trying to switch to" + scene + "scene")

func _on_TextureButton_pressed():
	var PopUpSprite = self.get_parent().get_parent().get_parent().get_parent().get_parent().get_node_or_null("PopUpSprite")
	if(self.has_pressed() and !is_instance_valid(PopUpSprite)):
		pop_up(self.texture_normal.get_path())
			
func pop_up(item_file):
	# Create Nodes
	var PopUpSprite = Sprite.new()
	var ItemSprite = Sprite.new()
	var CoinSprite = Sprite.new()
	var BuyTextureButton = TextureButton.new()
	var CancelTextureButton = TextureButton.new()
	var BuyLabel = Label.new()
	var MoneyLabel = Label.new()
	var CancelLabel = Label.new()
	var ItemLabel = Label.new()
	var DescriptionLabel = Label.new()
	var dynamic_font = DynamicFont.new()
	
	for item in game_data.inventory_items:
		if item.file == item_file:
			shop_item = item
			self.get_parent().get_parent().get_parent().get_parent().get_parent().shop_item = item
			break;
			
	# PopUpSprite Configuration
	PopUpSprite.name = "PopUpSprite"
	PopUpSprite.texture = load("res://assets/images/menus and ui/inventory slot - 2.png")
	PopUpSprite.modulate.a = 0.85
	PopUpSprite.position.x = 554
	PopUpSprite.position.y = 1206.719
	PopUpSprite.scale.x = 2.347
	PopUpSprite.scale.y = 2.578
	
	# ItemSprite Configuration
	ItemSprite.texture = load(shop_item.file)
	ItemSprite.position.x = -100.538
	ItemSprite.position.y = -97.645
	var scale = 1.0
	var list = []
	list_of_scale_values(list)
	for i in list:
		if(ItemSprite.texture.get_height()*i <= 145 and ItemSprite.texture.get_width()*i <= 155):
			scale = i
			break
	ItemSprite.scale.x = scale
	ItemSprite.scale.y = scale
	
	# CoinSprite Configuration
	CoinSprite.texture = load("res://assets/images/menus and ui/coin.png")
	CoinSprite.position.x = -142.808
	CoinSprite.position.y = -9.08
	CoinSprite.scale.x = 0.289
	CoinSprite.scale.y = 0.289
	
	# BuyTextureButton Configuration
	BuyTextureButton.expand = true
	BuyTextureButton.texture_normal = load("res://assets/images/menus and ui/inventory slot - 2 (green).png")
	BuyTextureButton.margin_left = -172
	BuyTextureButton.margin_top = 17
	BuyTextureButton.margin_right = 165
	BuyTextureButton.margin_bottom = 95
	BuyTextureButton.rect_position.x = -172.96
	BuyTextureButton.rect_position.y = 17.572
	BuyTextureButton.rect_size.x = 338
	BuyTextureButton.rect_size.y = 78
	BuyTextureButton.rect_pivot_offset.x = 200.225
	BuyTextureButton.rect_pivot_offset.y = 38.964
	BuyTextureButton.emit_signal("pressed")
	BuyTextureButton.set_script(load("res://scenes/ShopItem.gd"))
	
	# CancelTextureButton Configuration
	CancelTextureButton.expand = true
	CancelTextureButton.texture_normal = load("res://assets/images/menus and ui/inventory slot - 2 (red).png")
	CancelTextureButton.margin_left = -172
	CancelTextureButton.margin_top = 97
	CancelTextureButton.margin_right = 165
	CancelTextureButton.margin_bottom = 175
	CancelTextureButton.rect_position.x = -172.96
	CancelTextureButton.rect_position.y = 97.072
	CancelTextureButton.rect_size.x = 338
	CancelTextureButton.rect_size.y = 78
	CancelTextureButton.rect_pivot_offset.x = 200.225
	CancelTextureButton.rect_pivot_offset.y = 38.964
	CancelTextureButton.emit_signal("pressed")
	CancelTextureButton.set_script(load("res://scenes/ShopItem.gd"))
	
	# BuyLabel Configuration
	BuyLabel.text = "Buy"
	BuyLabel.align = Label.ALIGN_CENTER
	BuyLabel.valign = Label.VALIGN_CENTER
	BuyLabel.margin_left = 0
	BuyLabel.margin_top = 0
	BuyLabel.margin_right = 334
	BuyLabel.margin_bottom = 76
	BuyLabel.rect_position.x = 0
	BuyLabel.rect_position.y = 0
	BuyLabel.rect_size.x = 334
	BuyLabel.rect_size.y = 76
	dynamic_font.font_data = load("res://fonts/Sugar Snow.ttf")
	dynamic_font.size = 35
	BuyLabel.add_font_override("font", dynamic_font)
	
	# CancelLabel Configuration
	CancelLabel.text = "Cancel"
	CancelLabel.align = Label.ALIGN_CENTER
	CancelLabel.valign = Label.VALIGN_CENTER
	CancelLabel.margin_left = 0
	CancelLabel.margin_top = 0
	CancelLabel.margin_right = 334
	CancelLabel.margin_bottom = 76
	CancelLabel.rect_position.x = 0
	CancelLabel.rect_position.y = 0
	CancelLabel.rect_size.x = 334
	CancelLabel.rect_size.y = 76
	dynamic_font.font_data = load("res://fonts/Sugar Snow.ttf")
	dynamic_font.size = 35
	CancelLabel.add_font_override("font", dynamic_font)
	
	# ItemLabel Configuration
	ItemLabel.text = shop_item.name
	ItemLabel.align = Label.ALIGN_CENTER
	ItemLabel.valign = Label.VALIGN_CENTER
	ItemLabel.autowrap = false
	ItemLabel.margin_left = -9
	ItemLabel.margin_top = -212
	ItemLabel.margin_right = 115
	ItemLabel.margin_bottom = -154
	ItemLabel.rect_position.x = -135
	ItemLabel.rect_position.y = -200.933
	ItemLabel.rect_size.x = 204
	ItemLabel.rect_size.y = 58
	self.set_font_size(ItemLabel, 30)
	
	# DescriptionLabel Configuration
	DescriptionLabel.text = shop_item.description
	DescriptionLabel.autowrap = true
	DescriptionLabel.margin_left = -17
	DescriptionLabel.margin_top = -136
	DescriptionLabel.margin_right = 165
	DescriptionLabel.margin_bottom = 3
	DescriptionLabel.rect_position.x = -17
	DescriptionLabel.rect_position.y = -136
	DescriptionLabel.rect_size.x = 182
	DescriptionLabel.rect_size.y = 139
	self.set_font_size(DescriptionLabel, 20)
	
	# MoneyLabel Configuration
	MoneyLabel.text = "%03d" % shop_item.price
	MoneyLabel.valign = Label.VALIGN_CENTER
	MoneyLabel.margin_left = 94
	MoneyLabel.margin_top = -55
	MoneyLabel.margin_right = 328
	MoneyLabel.margin_bottom = 47
	MoneyLabel.rect_position.x = 94.465
	MoneyLabel.rect_position.y = -55.804
	MoneyLabel.rect_size.x = 234
	MoneyLabel.rect_size.y = 103
	self.set_font_size(MoneyLabel, 100)
	
	# Join all Nodes
	PopUpSprite.add_child(CoinSprite)
	CoinSprite.add_child(MoneyLabel)
	BuyTextureButton.add_child(BuyLabel)
	PopUpSprite.add_child(BuyTextureButton)
	CancelTextureButton.add_child(CancelLabel)
	PopUpSprite.add_child(CancelTextureButton)
	PopUpSprite.add_child(ItemSprite)
	PopUpSprite.add_child(ItemLabel)
	PopUpSprite.add_child(DescriptionLabel)
	self.get_parent().get_parent().get_parent().get_parent().get_parent().add_child(PopUpSprite)
	
		
func substract_money(q):
	game_data.money -= q
	
func list_of_scale_values(values):
	for i in range(100, 0, -1):
		values.append((i*0.01))

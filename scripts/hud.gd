extends CanvasLayer
class_name HUD

@onready var pickup_label = $VBoxContainer/MarginContainer/PanelContainer/HBoxContainer/PickupLabel
@onready var life_label = $VBoxContainer/MarginContainer2/PanelContainer/HBoxContainer/LifeLabel
@onready var level_label = $MarginContainer3/CenterContainer/PanelContainer/HBoxContainer/LevelLabel

func _ready():
	var parent = owner as LevelManager
	if parent == null:
		print("Warning: HUD isn't going to be updated. Owner as LevelManager wasn't not found")
		return
	parent.pickup_updated.connect(on_pickup_updated)	
	update_life_count()
	update_level_label()
	
func on_pickup_updated(currentTotalPickup, totalPickup):
	pickup_label.text = str(currentTotalPickup) + "/" + str(totalPickup)

func update_life_count():
	var life = GameManager.player_life
	life_label.text = ": " + str(life)

func update_level_label():
	var current_level = GameManager.current_level_index
	var total_levels = GameManager.total_levels
	level_label.text = str(current_level + 1) + " / " + str(total_levels)

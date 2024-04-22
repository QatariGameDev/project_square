extends CanvasLayer
class_name HUD

@onready var pickup_label = $VBoxContainer/MarginContainer/PanelContainer/HBoxContainer/PickupLabel
@onready var life_label = $VBoxContainer/MarginContainer2/PanelContainer/HBoxContainer/LifeLabel

func _ready():
	var parent = owner as LevelManager
	if parent == null:
		print("Warning: HUD isn't going to be updated. Owner as LevelManager wasn't not found")
		return
	parent.pickup_updated.connect(on_pickup_updated)	
	update_life_count()
	
func on_pickup_updated(currentTotalPickup, totalPickup):
	pickup_label.text = str(currentTotalPickup) + "/" + str(totalPickup)

func update_life_count():
	var life = GameManager.player_life
	life_label.text = ": " + str(life)

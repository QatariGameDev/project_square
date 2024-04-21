extends CanvasLayer
class_name HUD

@onready var pickup_label = $MarginContainer/PanelContainer/HBoxContainer/PickupLabel

func _ready():
	var parent = owner as LevelManager
	if parent == null:
		print("Warning: HUD isn't going to be updated. Owner as LevelManager wasn't not found")
		return
	parent.pickup_updated.connect(on_pickup_updated)	

func on_pickup_updated(currentTotalPickup, totalPickup):
	pickup_label.text = str(currentTotalPickup) + "/" + str(totalPickup)

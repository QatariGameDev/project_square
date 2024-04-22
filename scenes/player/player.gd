extends CharacterBody2D

@export var _speed: float = 300.0
@export var _jump_velocity: float = -450.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	#hint Autoload (GroupNames)
	add_to_group(GroupNames.PlayerGroup)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _jump_velocity
		AudioManager.play_global_jump_sound()

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)

	move_and_slide()

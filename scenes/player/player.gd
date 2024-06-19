extends CharacterBody2D

@export var _speed: float = 300.0
@export var _jump_velocity: float = -450.0
@export var _acceleration: float = 1500.0
@export var _air_resistance: float = 0.5  # To reduce speed by half when changing direction
@export var _coyote_time: float = 0.2
@export var _jump_hold_time: float = 0.3
@export var _slide_factor: float = 0.5

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var coyote_timer: float = 0.0
var jump_timer: float = 0.0
var is_jumping: bool = false
var previous_direction: int = 0

enum State {
	MOVING_RIGHT,
	MOVING_LEFT,
	IS_STOPPING
}

var current_state: State = State.IS_STOPPING

func _ready():
	add_to_group(GroupNames.PlayerGroup)

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		coyote_timer -= delta
		velocity.y += gravity * delta
	else:
		coyote_timer = _coyote_time
		is_jumping = false
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer > 0):
		velocity.y = _jump_velocity
		is_jumping = true
		jump_timer = _jump_hold_time
		AudioManager.play_global_jump_sound()
	
	if is_jumping and Input.is_action_pressed("jump"):
		if jump_timer > 0:
			velocity.y = _jump_velocity
			jump_timer -= delta
		else:
			is_jumping = false
	
	# Update state based on input
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	elif Input.is_action_pressed("ui_right"):
		direction = 1

	# Handle horizontal movement based on state and direction change in mid-air
	if direction != 0:
		if direction != previous_direction and not is_on_floor():
			velocity.x *= _air_resistance  # Reduce speed by half when changing direction mid-air
		current_state = (State.MOVING_LEFT if direction == -1 else State.MOVING_RIGHT)
	else:
		current_state = State.IS_STOPPING

	previous_direction = direction

	match current_state:
		State.MOVING_LEFT:
			velocity.x = move_toward(velocity.x, -_speed, _acceleration * delta)
		State.MOVING_RIGHT:
			velocity.x = move_toward(velocity.x, _speed, _acceleration * delta)
		State.IS_STOPPING:
			if is_on_floor():
				velocity.x = move_toward(velocity.x, 0.0, _acceleration * delta)
			else:
				velocity.x = lerp(velocity.x, 0.0, _slide_factor * delta)
	
	# Move the character
	move_and_slide()

func move_toward(value: float, target: float, step: float) -> float:
	if value < target:
		return min(value + step, target)
	elif value > target:
		return max(value - step, target)
	else:
		return value

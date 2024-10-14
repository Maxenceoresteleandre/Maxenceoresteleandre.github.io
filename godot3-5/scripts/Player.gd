extends DynamicObject
class_name Player

signal enter_water
signal exit_water


const MAX_FINGER_DISTANCE = 50.0
const BASE_BOING_PITCH = 0.9
const MAX_BOING_PITCH = 2
const BOING_VARIATION = 0.1
const SUPER_DASH_ZOOM := 0.1
const SUPER_DASH_DURATION = 0.03
const SUPER_DASH_TIME = 0.5
enum {ControlNormal, ControlSuperDash, ControlInactive, ControlPaused}

export var player_camera_path : NodePath = ""

export var has_dash : bool = true
export var has_torpedo : bool = true

var gravity = 10              #10 min
var friction = 0.35
var water_deceleration = 0.85
var underwater_speed = 800     #25 max  #1200 max
var max_fall_speed = 6000
var dash_speed_bonus = 900.0
var default_torpedo_speed := 2000.0

var torpedo_speed := default_torpedo_speed
var can_torpedo := false
var torpedo_direction : Vector2
var in_torpedo := false
onready var PlayerCamera : DynamicCamera 
var control_mode : int = ControlNormal
var can_dash := false
var has_control := true
var finger = Vector2.ZERO
var is_looking_right : int = 1
var underwater = false
var underwater_int = 0
var velocity = Vector2.ZERO
var dead = false
var boing_pitch = BASE_BOING_PITCH
onready var fish_skeleton = $Skeleton
var can_super_dash := false
var dashing := false
var has_first_tapped := false
var is_click_pressed := false

func _ready() -> void:
	GlobalVariables.player = self

func set_player_control(control : bool) -> void:
	has_control = control

func in_water() -> void:
	underwater_int += 1
	dashing = false
	if underwater_int > 0:
		underwater = true
		emit_signal("enter_water")

func out_water() -> void:
	underwater_int -= 1
	if underwater_int <= 0:
		underwater_int = 0
		underwater = false
		if control_mode != ControlPaused:
			exit_water_gameplay()
		boing_pitch = BASE_BOING_PITCH
		is_looking_right = -1
		if velocity.x>0:
			is_looking_right = 1
		emit_signal("exit_water")

func exit_water_gameplay() -> void:
	if in_torpedo:
		velocity = velocity.normalized() * torpedo_speed * 0.75
	reset_dash()
	reset_torpedo()

func is_dashing() -> bool:
	return dashing

func dash() -> void:
	can_dash = false
	dashing = true
	update_finger_pos()
	velocity = max(dash_speed_bonus, velocity.length() + dash_speed_bonus/1.5) * finger.normalized()

func reset_dash() -> void:
	dashing = false
	can_dash = true

func reset_torpedo() -> void:
	dashing = false
	in_torpedo = false
	if has_torpedo:
		has_first_tapped = false
		can_torpedo = true
	else:
		can_torpedo = false

func _input(event : InputEvent) -> void:
	if has_control:
		if (event.is_action_pressed("click")):
			is_click_pressed = true
		elif (event.is_action_released("click")):
			is_click_pressed = false

func reset_controls() -> void:
	velocity = Vector2.ZERO
	can_super_dash = false
	can_torpedo = true
	can_dash = true
	has_control = true
	is_click_pressed = false
	has_first_tapped = false

func _physics_process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if velocity.x < 0:
		fish_skeleton.scale.x = 0.25
	elif velocity.x > 0:
		fish_skeleton.scale.x = -0.25
	match control_mode:
		ControlNormal:
			normal_controls(delta)
		ControlSuperDash:
			super_dash_controls(delta)
		ControlInactive:
			inactive_controls(delta)
		ControlPaused:
			pass # don't move, unaffected by forces

func inactive_controls(_delta : float) -> void:
	move_and_slide(physic_force + velocity / 2.0, Vector2(0, -1))

func set_control_mode(new_mode: int) -> void:
	control_mode = new_mode
	#if new_mode == ControlPaused:
	#	velocity = Vector2.ZERO

func enter_super_dash_mode() -> void:
	if control_mode == ControlSuperDash:
		return
	$SuperDashTimer.start(SUPER_DASH_TIME)
	Engine.time_scale = 0.25
	$Skeleton.set_anim_speed(5.0)
	control_mode = ControlSuperDash
	can_super_dash = true
	PlayerCamera.set_camera_zoom(PlayerCamera.get_camera_zoom() - SUPER_DASH_ZOOM, 0.05)

func exit_super_dash_mode() -> void:
	$Skeleton.set_anim_speed(1.0)
	Engine.time_scale = 1.0
	control_mode = ControlNormal
	velocity /= 2.0
	can_super_dash = false
	can_dash = true
	PlayerCamera.set_camera_zoom(PlayerCamera.get_camera_zoom() + SUPER_DASH_ZOOM, 0.1)

func super_dash() -> void:
	can_super_dash = false 
	dashing = true
	PlayerCamera.set_camera_zoom(PlayerCamera.get_camera_zoom() - 0.25, 0.01)
	var mouse_pos := get_global_mouse_position()
	look_at(mouse_pos)
	var finger_target = mouse_pos - global_position
	$SuperDashRaycast.cast_to = finger_target
	$SuperDashRaycast.global_rotation = 0.0
	$SuperDashRaycast.force_raycast_update()
	yield(get_tree().create_timer(0.01),"timeout")
	var super_dash_target : Vector2
	var is_target_invalid : bool = $SuperDashRaycast.is_colliding()
	var collision_normal : Vector2 = $SuperDashRaycast.get_collision_normal()
	if is_target_invalid:
		super_dash_target = global_position.linear_interpolate($SuperDashRaycast.get_collision_point(), 0.9)
	else:
		super_dash_target = mouse_pos
	velocity = (super_dash_target - global_position).normalized()
	if velocity.x>0:
		is_looking_right = 1
	else:
		is_looking_right = -1
	var dash_tween := create_tween().set_ease(Tween.EASE_OUT)
	dash_tween.tween_property(self, "global_position", super_dash_target, SUPER_DASH_DURATION)
	yield(dash_tween, "finished")
	yield(get_tree().create_timer(0.05), "timeout")
	dashing = false
	PlayerCamera.set_camera_zoom(PlayerCamera.get_camera_zoom() + 0.25, 0.05)
	
	if is_target_invalid:
		velocity *= dash_speed_bonus
		boing_collision(collision_normal)
		exit_super_dash_mode()
	else:
		$SuperDashTimer.start(SUPER_DASH_TIME)
		yield(get_tree().create_timer(0.05), "timeout")
		can_super_dash = true

func super_dash_controls(delta : float) -> void:
	if can_super_dash:
		if is_click_pressed and Input.is_action_just_pressed("click"):
			super_dash()
			fish_skeleton.play(fish_skeleton.Dash)
			return
		if $SuperDashTimer.is_stopped():
			exit_super_dash_mode()
		compute_gravity()
		rotation += (velocity.length()/10000)*is_looking_right*delta*70
		fish_skeleton.play(fish_skeleton.SuperIdle)
		move_and_slide(physic_force + velocity / 2.0, Vector2(0, -1))

func compute_gravity() -> void:
	velocity.y = min(velocity.y+gravity, max_fall_speed)

func normal_controls(delta : float) -> void:
	if not underwater:
		if is_click_pressed and Input.is_action_just_pressed("click") and can_dash and has_dash:
			dash()
		if can_dash:
			rotation += (velocity.length()/10000)*is_looking_right*delta*70
			fish_skeleton.play(fish_skeleton.Idle)
		else:
			look_at(global_position + velocity)
			fish_skeleton.play(fish_skeleton.Dash)
		compute_gravity()
		velocity = Vector2( 
			(velocity.x-sign(velocity.x)*friction)*float(abs(velocity.x)>5),
			velocity.y/1.008 )
		###########################
		if get_slide_count() > 0:
			var collision = get_slide_collision(0)
			if collision != null:
				if velocity.length() < 300 and not has_dash :
					velocity = Vector2.ZERO
					set_physics_process(false)
					yield(get_tree().create_timer(1.5),"timeout")
					death()
					set_physics_process(true)
					return
				boing_collision(collision.normal)
		###########################
		move_and_slide(physic_force + velocity, Vector2(0, -1))
	else: # if underwater
		if in_torpedo:
			move_and_slide(torpedo_direction * torpedo_speed)
			if get_slide_count() > 0:
				exit_torpedo(get_slide_collision(0).normal)
			return
		if is_click_pressed:
			update_finger_pos()
			velocity = finger.normalized() * max(velocity.length(), underwater_speed)
			if can_torpedo and Input.is_action_just_pressed("click"):
				if not has_first_tapped:
					initiate_double_tap()
				else:
					enter_torpedo()
		#else :
		velocity /= 1.0 + delta*water_deceleration
		if velocity.length() < 10:
			fish_skeleton.play(fish_skeleton.Idle)
		elif not in_torpedo :
			fish_skeleton.play(fish_skeleton.Swimming)
			fish_skeleton.set_playback_speed(max(0.5, (velocity.length())/500))
		move_and_slide(physic_force + velocity, Vector2(0, -1))

func exit_torpedo(collision_normal : Vector2) -> void:
	velocity = (torpedo_speed * torpedo_direction).reflect(collision_normal.tangent())
	look_at(global_position + velocity)
	reset_torpedo()

func enter_torpedo() -> void:
	#fish_skeleton.play(fish_skeleton.SuperIdle)
	#yield(get_tree().create_timer(1.0),"timeout")
	torpedo_direction = finger.normalized()
	if torpedo_direction == Vector2.ZERO:
		reset_torpedo()
		return
	torpedo_speed = default_torpedo_speed + sqrt(velocity.length())
	fish_skeleton.play(fish_skeleton.Dash)
	in_torpedo = true
	dashing = true

func boing_collision(normal : Vector2) -> void:
	velocity = velocity.reflect((normal).tangent())
	boing_pitch = min(boing_pitch+BOING_VARIATION, MAX_BOING_PITCH)
	$AudioStreamJump.pitch_scale = boing_pitch
	$AudioStreamJump.play(0)

func update_finger_pos() -> void:
	finger = (get_global_mouse_position()-global_position)
	if finger.length_squared() < 100.0:
		finger = Vector2.ZERO
	else:
		finger = finger.normalized() * min(finger.length()/10, MAX_FINGER_DISTANCE)
		look_at(get_global_mouse_position())

func _on_DoubleTapTimer_timeout() -> void:
	has_first_tapped = false

func initiate_double_tap() -> void:
	has_first_tapped = true
	$DoubleTapTimer.start()

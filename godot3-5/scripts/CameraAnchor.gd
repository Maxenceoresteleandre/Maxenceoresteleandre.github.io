extends Area2D
tool

const CAMERA_EXTENTS = Vector2(1080.0 * 0.7, 1920.0 * 0.7)

export var set_zoom := true
export var camera_zoom : float = 2.0 setget set_camera_zoom
export var camera_pos := Vector2.ZERO setget set_camera_pos
export var lock_x := true
export var lock_y := true
export var limit_right := false
export var limit_left := false
export var limit_top := false
export var limit_down := false

func _ready():
	if not Engine.editor_hint:
		camera_pos += global_position

func set_camera_zoom(new_zoom : float):
	camera_zoom = new_zoom
	if Engine.editor_hint:
		update()

func set_camera_pos(new_pos : Vector2):
	camera_pos = new_pos
	if Engine.editor_hint:
		update()

func _draw():
	if Engine.editor_hint:
		var cam_extents : Vector2 = Vector2(
			CAMERA_EXTENTS.x * camera_zoom * (1.0/scale.x),
			CAMERA_EXTENTS.y * camera_zoom * (1.0/scale.y))
		draw_rect(
			Rect2(to_local(camera_pos + position) - (cam_extents/2.0), cam_extents), 
			Color.tomato, false, 1.0)

func _on_CameraAnchor_body_entered(body):
	if body == GlobalVariables.player:
		GlobalVariables.player_camera.add_to_anchors(self)
		if set_zoom:
			GlobalVariables.player_camera.attach(self, camera_zoom)

func _on_CameraAnchor_body_exited(body):
	if body == GlobalVariables.player:
		GlobalVariables.player_camera.detach(self)

func get_area_extents():
	var extents = Vector2(
		$CollisionShape2D.shape.extents.x * global_scale.x,
		$CollisionShape2D.shape.extents.y * global_scale.y)
	return extents

func get_desired_camera_position(pos : Vector2):
	if lock_x:
		pos.x = camera_pos.x
	if lock_y:
		pos.y = camera_pos.y
	return(pos)

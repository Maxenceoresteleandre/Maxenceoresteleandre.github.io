extends Camera2D
class_name DynamicCamera

enum Rotations {Vertical, Horizontal, VerticalInvert, HorizontalInvert}
enum Limits {Up, Right, Down, Left}
const CAMERA_ROTATIONS = [0, 90, 180, -90]

export var camera_target : NodePath = ""
onready var default_zoom : float = zoom.x
var current_rotation = Rotations.Vertical
var current_anchor : Array = []
var cam_anchor : Area2D = null
var following := false
var target : Node2D = null
var rushing := false
var bound_left_pos : float
var bound_top_pos : float
var bound_right_pos : float
var bound_bottom_pos : float
var bound_left : float = -10000000
var bound_top : float = -10000000
var bound_right : float = 10000000
var bound_bottom : float = 10000000


func _ready():
	GlobalVariables.player_camera = self
	if get_node(camera_target) != null:
		target = get_node(camera_target)
	else:
		yield(get_tree(), "physics_frame")
		target = GlobalVariables.player
	following = true

func set_bound(limit : int, pos : Vector2, update_limits := true):
	match limit:
		Limits.Left:
			bound_left_pos = pos.x
		Limits.Up:
			bound_top_pos = pos.y
		Limits.Right:
			bound_right_pos = pos.x
		Limits.Down:
			bound_bottom_pos = pos.y
	if update_limits:
		update_bounds()

func update_bounds():
	# Get the canvas transform
	var ctrans = get_canvas_transform()
	# The canvas transform applies to everything drawn,
	# so scrolling right offsets things to the left, hence the '-' to get the world position.
	# Same with zoom so we divide by the scale.
	var min_pos = -ctrans.get_origin() / ctrans.get_scale()
	# The maximum edge is obtained by adding the rectangle size.
	# Because it's a size it's only affected by zoom, so divide by scale too.
	var view_size = get_viewport_rect().size / ctrans.get_scale()
	var max_pos = min_pos + view_size
	# Note: rotation is not taken into account here. An improvement would be
	# to use the inverse transform instead of this.
	var screen_size : Vector2 = view_size #get_viewport().get_visible_rect().size
	if current_rotation==Rotations.Vertical or current_rotation==Rotations.Vertical:
		bound_left   = bound_left_pos   + screen_size.x/(2.0)#/zoom.x)
		bound_top    = bound_top_pos    + screen_size.y/(2.0)#/zoom.y)
		bound_right  = bound_right_pos  - screen_size.x/(2.0)#/zoom.x)
		bound_bottom = bound_bottom_pos - screen_size.y/(2.0)#/zoom.y)
	else:
		bound_left   = bound_left_pos   + screen_size.y/(2.0)#/zoom.x)
		bound_top    = bound_top_pos    + screen_size.x/(2.0)#/zoom.y)
		bound_right  = bound_right_pos  - screen_size.y/(2.0)#/zoom.x)
		bound_bottom = bound_bottom_pos - screen_size.x/(2.0)#/zoom.y)

func attach(new_anchor : Area2D, new_zoom : float):
	if zoom.x != new_zoom:
		set_new_zoom(new_zoom * default_zoom)

func add_to_anchors(new_anchor : Area2D):
	current_anchor.append(new_anchor)
	cam_anchor = new_anchor

func detach(old_anchor : Area2D):
	if old_anchor in current_anchor:
		current_anchor.erase(old_anchor) 
		if len(current_anchor) == 0:
			if old_anchor.set_zoom:
				set_new_zoom(default_zoom)
			cam_anchor = null
			#set_scroll_limits()
		else:
			cam_anchor = current_anchor[0]
			#set_scroll_limits()
			if zoom.x != cam_anchor.camera_zoom:
				set_new_zoom(cam_anchor.camera_zoom * default_zoom)

func set_new_zoom(new_zoom : float, time : float  = 0.75):
	if rushing:
		zoom = Vector2(new_zoom, new_zoom)
	else:
		$Tween.interpolate_property(self, "zoom", zoom, Vector2(new_zoom, new_zoom),time, 
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
		yield($Tween, "tween_all_completed")
	update_bounds()

func _process(_delta):
	if following:
		var target_pos : Vector2 = target.global_position
		global_position = Vector2(
			min(max(target_pos.x, bound_left), bound_right),
			min(max(target_pos.y, bound_top), bound_bottom)
		)

func set_target(new_target : Node2D):
	following = true
	set_process(true)
	target = new_target

func stop_follow():
	following = false
	set_process(false)

func move_to(point : Vector2, time : float = 0.5):
	stop_follow()
	if time <= 0.0:
		position = point
	else:
		$Tween.interpolate_property(self, "position", position, point, time,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()

func get_camera_zoom():
	return (zoom.x + zoom.y) / 2.0

func set_camera_zoom(new_zoom : float = 1.0, time : float = 0.5):
	if time <= 0.0:
		zoom = Vector2(new_zoom, new_zoom)
	else:
		$Tween.interpolate_property(self, "zoom", zoom, Vector2(new_zoom, new_zoom), 
			time, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()

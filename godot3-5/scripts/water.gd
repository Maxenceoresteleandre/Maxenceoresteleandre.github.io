tool
extends Polygon2D

export var is_opaque := false

onready var polygon_bg : Polygon2D = $PolygonBG
onready var collision_polygon : CollisionPolygon2D = $Area2D/CollisionPolygon2D
onready var line2D : Line2D = $Line2D

func _ready() -> void:
	draw_object()
	polygon_bg.visible = is_opaque
	if not Engine.editor_hint and not is_opaque:
		polygon_bg.queue_free()

func draw_object() -> void:
	collision_polygon.polygon = polygon
	if is_opaque:
		polygon_bg.polygon = polygon
	line2D.points = polygon
	if len(polygon) > 0:
		line2D.add_point(polygon[0])

func _on_Area2D_body_entered(body : Node2D) -> void:
	if body.has_method("in_water"):
		body.in_water()

func _on_Area2D_body_exited(body : Node2D) -> void:
	if body.has_method("out_water"):
		body.out_water()

func _on_Water_draw() -> void:
	draw_object()


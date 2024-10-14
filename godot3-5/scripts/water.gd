tool
extends Polygon2D

export var is_opaque := false

func _ready() -> void:
	draw_object()
	$PolygonBG.visible = is_opaque
	if not Engine.editor_hint and not is_opaque:
		$PolygonBG.queue_free()

func draw_object() -> void:
	$Area2D/CollisionPolygon2D.polygon = polygon
	if is_opaque:
		$PolygonBG.polygon = polygon
	$Line2D.points = polygon
	if len(polygon) > 0:
		$Line2D.add_point(polygon[0])

func _on_Area2D_body_entered(body : Node2D) -> void:
	$Line2D.queue_free()
	if body.has_method("in_water"):
		body.in_water()

func _on_Area2D_body_exited(body : Node2D) -> void:
	if body.has_method("out_water"):
		body.out_water()

func _on_Water_draw() -> void:
	draw_object()


tool
extends Polygon2D

export var is_opaque := false

func _ready():
	draw_object()
	$PolygonBG.visible = is_opaque
	if not Engine.editor_hint and not is_opaque:
		$PolygonBG.queue_free()

func draw_object():
	$Area2D/CollisionPolygon2D.polygon = polygon
	if is_opaque:
		$PolygonBG.polygon = polygon
	$Line2D.points = polygon
	if len(polygon) > 0:
		$Line2D.add_point(polygon[0])

func _on_Area2D_body_entered(body):
	if body.has_method("in_water"):
		body.in_water()

func _on_Area2D_body_exited(body):
	if body.has_method("out_water"):
		body.out_water()

func _on_Water_draw():
	draw_object()


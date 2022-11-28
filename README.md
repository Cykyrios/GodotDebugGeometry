# GodotDebugGeometry
Godot GDScript used to draw geometry for development and debugging purposes.

A demo project displaying  random shapes [is available here](https://github.com/Cykyrios/GodotDebugGeometry-demo).

## Features
Enables easily drawing objects for debugging purposes.

The list of currently supported shapes is the following:
* Cube (axis-oriented box)
* Sphere
* Cylinder
* Cone
* Arrow
* Coordinate system (set of 3 colored arrows)
* Grid
* Line
* Point

Most available shapes can be drawn as either lines or solid geometry and in arbitrary orientations. Debug Lines can have non-zero thickness and are then drawn as a solid cylinder. All functions have a time argument which determines how long a shape will stay in the world before being erased. A time value of 0 will display the shape for a single frame.

## Usage
Make debug_geometry.gd an autoload node. To add a shape to the world, you can call `DebugGeometry.draw_debug_shape` where `shape` is any of the available shapes.

Keep in mind that all shapes are drawn relative to the DebugGeometry node, which is at the top level of the scene tree, being an autoload.

If you do not want to use it as an autoload, I recommend adding `class_name DebugGeometry` at the top of the file, and placing a `MeshInstance3D` with this script attached where you want in your scene tree. Keep in mind that everything will be drawn relative to this node.

Note that all updates to debug shapes happen in `_process()` with a very low priority, so you should typically be able to call drawing functions from anywhere. Under some circumstances, such as calling drawing functions in quick succession faster than `_process()` delta times, duplicate shapes may appear.


## Drawing functions reference
```gdscript
draw_debug_cube(t: float, p: Vector3, extents: Vector3, c: Color = Color(0, 0, 0), b_triangles: bool = false)
```
* t: display time, will last a single frame if equal to 0 (ideal for continuously updating shapes)
* p: center of the box
* extents: dimensions of the box
* c: color of the shape
* b_triangles: displays as solid shape if true, otherwise only draws wireframe

```gdscript
draw_debug_sphere(t: float, p: Vector3, lon: int, lat: int, r: float, c: Color = Color(0, 0, 0), b_triangles: bool = false)
```
* p: center of the sphere
* lon: longitude subdivisions, lon = 8 will look like an octogon when seen from above
* lat: latitude subdivision, half the value of `lon` will give the same number of subdivisions
* r: radius of the sphere

```gdscript
draw_debug_cylinder(t: float, p1: Vector3, p2: Vector3, r: float, lon: int = 8, b_caps: bool = true, c: Color = Color(0, 0, 0), b_triangles: bool = false)
```
* p1: first end of the cylinder
* p2: second end of the cylinder
* r: radius of the cylinder
* lon: number of sides (see description for debug_sphere's `lon`)
* b_caps: draw flat ends of the cylinders

```gdscript
draw_debug_cone(t: float, p1: Vector3, p2: Vector3, r1: float, r2: float, lon: int = 8, b_caps: bool = true, c: Color = Color(0, 0, 0), b_triangles: bool = false)
```
* r1: radius at first end
* r2: radius at second end
* All other parameters are the same as debug_cylinder

```gdscript
draw_debug_arrow(t: float, p: Vector3, n: Vector3, s: float = 1.0, c: Color = Color(0, 0, 0), b_triangles: bool = true)
```
* p: origin of the arrow
* n: direction of the arrow
* s: size (length) of the arrow

```gdscript
draw_debug_coordinate_system(t: float, p: Vector3, x: Vector3 = Vector3.RIGHT, y: Vector3 = Vector3.UP, s: float = 1.0, c: float = 1.0, b_triangles: bool = true)
```
* p: origin of the coordinate system
* x: direction of the X axis
* y: direction of the Y axis (this vector defines the XY plane, not the Y axis itself)
* s: size of the arrows

```gdscript
draw_debug_grid(t: float, p: Vector3, a: float, b: float, div_a: int, div_b: int, normal: Vector3 = Vector3(0, 1, 0), tangent: Vector3 = Vector3(1, 0, 0), color: Color = Color(0, 0, 0))
```
* p: center of the grid
* a: length of the grid
* b: width of the grid
* div_a: number of divisions along length, must be at least 1 to render
* div_b: number of division along width, must be at least 1 to render
* normal: normal vector to the plane of the grid
* tangent: defines the direction of the 'a' direction

```gdscript
draw_debug_line(t: float, p1: Vector3, p2: Vector3, thickness: float, color: Color = Color(0, 0, 0))
```
* p1: first end of the line
* p2: second end of the line
* thickness: if greater than zero, represents the diameter of the corresponding cylinder

```gdscript
draw_debug_point(t: float, p: Vector3, size: float, color: Color = Color(0, 0, 0), b_triangles: bool = true)
```
* p: position of the point
* size: if greater than zero, represents the diameter of the corresponding sphere. Note that a size of zero may render as a single pixel.

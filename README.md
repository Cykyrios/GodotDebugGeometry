# GodotDebugGeometry
Godot GDScript used to draw geometry for development and debugging purposes

A demo project displaying  random shapes [is available here](https://github.com/Cykyrios/GodotDebugGeometry-demo).

## Features
This is a work in progress, updates are welcome (especially to the drawing manager).

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

Most available shapes can be drawn as either lines or solid geometry and in arbitrary orientations. Debug Lines can have non-zero thickness and are then drawn as a solid cylinder. All functions have a time argument which determines how long a shape will stay in the world before being erased.

## Usage
To add a shape to the world, add an ImmediateGeometry node to a scene and attach `DebugGeometry.gd` to it. You can then get a reference to this node, from which you can call `draw_debug_shape` where `shape` is any of the available shapes.

Keep in mind that all shapes are drawn relative to the DebugGeometry node, which should usually be placed at the origin of your level scene.

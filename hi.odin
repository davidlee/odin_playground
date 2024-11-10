package main

import "core:c"
import "core:fmt"
import "core:log"
import "core:math/rand"
import "core:mem"
import "core:strings"
import "vendor:raylib"


Point32 :: struct {
	x: i32,
	y: i32,
}

Res32 :: Point32

Avatar :: struct {
	pos:     Point32,
	delta:   Point32,
	size:    i32,
	jumping: i32,
}

Cell :: struct {
	ch: u8,
}


CellMatrix :: [100][100]Cell

WorldState :: struct {
	avatar:     Avatar,
	screenSize: Res32,
	font:       raylib.Font,
	cells:      CellMatrix,
}

Direction :: enum {
	North,
	East,
	South,
	West,
}

initWorld :: proc() -> WorldState {
	s: Res32 = {800, 600}
	a: Avatar = {
		pos  = {s.x / 2, s.y / 2},
		size = 20,
	}

	celltypes: [7]u8 = {'x', '.', '-', ':', 'X', '#', '@'}
	cells: CellMatrix = {}

	for i in 0 ..< len(CellMatrix) {
		for j in 0 ..< len(CellMatrix) {
			cells[i][j].ch = rand.choice(celltypes[:])
		}
	}

	return WorldState{screenSize = s, avatar = a, cells = cells}
}

main :: proc() {
	using raylib

	world := initWorld()
	setup(&world)

	for !WindowShouldClose() {
		BeginDrawing()
		updateState(&world)
		draw(world)
		EndDrawing()
	}
	CloseWindow()
}

setup :: proc(world: ^WorldState) {
	using raylib
	InitWindow(world.screenSize.x, world.screenSize.y, "Prototype Title")
	camera: Camera2D = {}
	camera.zoom = 1.0
	zoomMode: int = 0 // 0-Mouse Wheel, 1-Mouse Move
	world.font = LoadFont("assets/3270NerdFontMono-Regular.ttf")
	SetTargetFPS(60)
}

draw :: proc(world: WorldState) {
	using raylib

	ClearBackground(RAYWHITE)

	// background
	for arr, y in world.cells {
		for cell, x in arr {
			cstr := fmt.ctprintf("%c", cell.ch)
			v: Vector2 = {f32(x) * 8.0, f32(y) * 8.0}
			DrawTextEx(world.font, cstr, v, 10, 5, BLACK)
		}
	}

	// player
	p := world.avatar.pos
	z := world.avatar.size
	s := world.screenSize

	DrawRectangle(p.x - z, p.y - z, z, z, RED)
}

updateState :: proc(world: ^WorldState) {
	updatePlayer(world)
}

updatePlayer :: proc(world: ^WorldState) {
	using raylib
	av := &world.avatar

	min: Point32 = {av.size, av.size}
	max: Point32 = {world.screenSize.x, world.screenSize.y}

	if IsKeyDown(.LEFT) {
		av.delta.x -= 1
	}

	if IsKeyDown(.RIGHT) {
		av.delta.x += 1
	}

	// TODO collision detection of tiles 
	canJump: bool = av.pos.y == max.y

	if canJump {
		if IsKeyPressed(.UP) {
			av.jumping -= 10
		}
		if IsKeyDown(.UP) {
			av.jumping -= 1

		} else {
			av.delta.y += av.jumping
			av.jumping = 0
		}
	} else {
		av.delta.y += 1
	}

	// apply delta 
	av.pos.x += av.delta.x
	av.pos.y += av.delta.y

	// bounds checks
	if av.pos.x <= min.x {
		av.delta.x = 0
		av.pos.x = min.x
	} else if av.pos.x >= max.x {
		av.delta.x = 0
		av.pos.x = max.x
	}

	if av.pos.y <= min.y {
		av.delta.y = 0
		av.pos.y = min.y
	} else if av.pos.y >= max.y {
		av.delta.y = 0
		av.pos.y = max.y
	}
}

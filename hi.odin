package main

import "core:c"
import "core:fmt"
import "core:log"
import "core:mem"
import "core:strings"
import "vendor:raylib"


Point32 :: struct {
	x: i32,
	y: i32,
}

Res32 :: Point32

Avatar :: struct {
	pos:  Point32,
	size: i32,
}

WorldState :: struct {
	avatar:     Avatar,
	counter:    int,
	screenSize: Res32,
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
		size = 5,
	}
	return WorldState{screenSize = s, avatar = a, counter = 0}
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
	InitWindow(world.screenSize.x, world.screenSize.y, "Lovely Title")
	camera: Camera2D = {}
	camera.zoom = 1.0
	zoomMode: int = 0 // 0-Mouse Wheel, 1-Mouse Move
	SetTargetFPS(60)
}

draw :: proc(world: WorldState) {
	using raylib
	ClearBackground(RAYWHITE)
	DrawText("Hello!", 50, 50, 14, LIGHTGRAY)
	p := world.avatar.pos
	z := world.avatar.size
	s := world.screenSize
	DrawRectangle(p.x - z, p.y - z, z, z, RED)
}


updateState :: proc(world: ^WorldState) {
	using raylib
	k: i32 = 10

	if IsKeyDown(.LEFT) {
		world.avatar.pos.x = max(1, world.avatar.pos.x - k)
	}

	if IsKeyDown(.RIGHT) {
		world.avatar.pos.x = min(world.screenSize.x - 1, world.avatar.pos.x + k)
	}

	// log.infof("avatar x: %d", world.avatar.pos.x)
	// fmt.printf("x: %d", world.avatar.pos.x)
}

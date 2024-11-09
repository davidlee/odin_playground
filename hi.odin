package main

import "core:fmt"
import "core:mem"
import "core:strings"
import "vendor:raylib"

import "core:c"


foreign import flecs "libflecs_static.a"

foreign flecs {
	// fuck knows what its real type should be
	ecs_init :: proc() -> [^]int ---
}

Res32 :: struct {
	x: i32,
	y: i32,
}

main :: proc() {
	fmt.println("main :: proc ## running")
	res: int = get_num()
	fmt.printfln("I GOT A: %d", res)
	world: [^]int = ecs_init()

	// res: Res32 = {800, 600}
	frame := 0

	// using raylib


	// InitWindow(res.x, res.y, "Lovely Title")
	// SetTargetFPS(60)

	// for !WindowShouldClose() {
	// 	frame += 1
	// 	BeginDrawing()
	// 	ClearBackground(RAYWHITE)
	// 	DrawText("Hello!", 50, 50, 14, LIGHTGRAY)
	// 	msg: cstring = fmt.ctprintf("frame: %d", frame)


	// 	DrawText(msg, 150, 50, 14, DARKPURPLE)
	// 	EndDrawing()
	// }
	// CloseWindow()
}

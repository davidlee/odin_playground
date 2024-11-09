package main

import "core:fmt"
import "core:mem"
import "core:strings"
import "vendor:raylib"


import "core:c"

foreign import pew "library.o"

// gcc -Wall library.c
// ar rcs library.a a.out

foreign pew {
	@(link_name = "example")
	get_num :: proc() -> int ---

}
// foreign import flecs "libflecs_static.a"

// foreign flecs {

// }

Res32 :: struct {
	x: i32,
	y: i32,
}

main :: proc() {
	fmt.println("main :: proc ## running")
	res: int = get_num()
	fmt.printfln("I GOT A: %d", res)


	// code: https://odin-lang.org/docs/overview/#tracking-allocator
	// when ODIN_DEBUG || true {
	// 	track: mem.Tracking_Allocator
	// 	mem.tracking_allocator_init(&track, context.allocator)
	// 	context.allocator = mem.tracking_allocator(&track)

	// 	defer {
	// 		if len(track.allocation_map) > 0 {
	// 			fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
	// 			for _, entry in track.allocation_map {
	// 				fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
	// 			}
	// 		}
	// 		if len(track.bad_free_array) > 0 {
	// 			fmt.eprintf("=== %v incorrect frees: ===\n", len(track.bad_free_array))
	// 			for entry in track.bad_free_array {
	// 				fmt.eprintf("- %p @ %v\n", entry.memory, entry.location)
	// 			}
	// 		}
	// 		mem.tracking_allocator_destroy(&track)
	// 	}
	// }

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

// TODO proof of concept using FLECS
// maybe based on https://github.com/raith-hamzah/odin-flecs or 

// ok, managed to get 
